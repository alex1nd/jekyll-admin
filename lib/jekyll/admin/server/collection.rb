module Jekyll
  module Admin
    class Server < Sinatra::Base
      namespace "/collections" do
        get do
          json site.collections.map { |c| c[1].to_liquid }
        end

        get "/:collection_id" do
          ensure_collection
          json collection.to_liquid
        end

        get "/:collection_id/documents" do
          ensure_collection
          json collection.docs.map { |doc| document_for_api(doc).to_liquid }
        end

        get "/:collection_id/*" do
          ensure_document
          content_type :json
          document_for_api.to_liquid.to_json
        end

        put "/:collection_id/*" do
          ensure_collection
          File.write document_path, document_body
          site.process
          content_type :json
          document_for_api.to_liquid.to_json
        end

        delete "/:collection_id/*" do
          ensure_document
          File.delete document_path
          content_type :json
          status 200
          halt
        end

        private

        def collection
          collection = site.collections.find { |l, _c| l == params["collection_id"] }
          collection[1] if collection
        end

        def document_id
          params["splat"].first.gsub(%r!(\d{4})/(\d{2})/(\d{2})/(.*)!, '\1-\2-\3-\4')
        end

        def document_path
          sanitized_path File.join(collection.directory, document_id)
        end

        def document
          collection.docs.find { |d| d.path == document_path }
        end

        def ensure_collection
          render_404 if collection.nil?
        end

        def ensure_document
          ensure_collection
          render_404 if document.nil?
        end

        # Returns a document suitable for to_liquid being called on for the API
        # The document will be the document as seen by Jekyll, but:
        #  1. without front matter defaults by
        #  2. With a `raw_content` field added
        def document_for_api(original_doc = document)
          doc = original_doc.dup
          doc.instance_variable_set "@data", {}

          # If the file has YAML front matter, read it in
          content = File.read(doc.path, Utils.merged_file_read_opts(site, {}))
          if content =~ Jekyll::Document::YAML_FRONT_MATTER_REGEXP
            content = $POSTMATCH
            data_file = SafeYAML.load(Regexp.last_match(1))
            doc.merge_data!(data_file, :source => "YAML front matter") if data_file
          end

          # Return the unrendered markdown, see https://git.io/vKDTG
          doc.merge_data!({ "raw_content" => content }, :source => "Jekyll Admin")

          # Set date, title, slug, extension, etc.
          doc.post_read

          # Unless we explicitly create the drop, the resulting drop will be based on the
          # original document, not the duplicated one, due to Ruby strangeness
          doc.instance_variable_set "@to_liquid", Drops::DocumentDrop.new(doc)

          doc
        end
      end
    end
  end
end
