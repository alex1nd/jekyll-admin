describe "pages" do
  include Rack::Test::Methods

  def app
    Jekyll::Admin::Server
  end

  before(:each) do
    Jekyll::Admin.site.process
  end

  after(:each) do
    Jekyll::Admin.site.process
  end

  context "page index" do
    it "lists pages" do
      get "/pages"
      expect(last_response).to be_ok
      expect(last_response_parsed.last["name"]).to eq('page.md')
    end

    it "doesn't include front matter defaults" do
      get "/pages"
      expect(last_response).to be_ok
      expect(last_response_parsed.first.key?("some_front_matter")).to eq(false)
    end
  end

  context "getting a single page" do
    it "returns a page" do
      get "/pages/page.md"
      expect(last_response).to be_ok
      expect(last_response_parsed["foo"]).to eq('bar')
    end

    it "returns the rendered output" do
      get "/pages/page.md"
      expect(last_response).to be_ok
      expected = "<h1 id=\"test-page\">Test Page</h1>\n"
      expect(last_response_parsed["content"]).to eq(expected)
    end

    it "returns the raw content" do
      get "/pages/page.md"
      expect(last_response).to be_ok
      expect(last_response_parsed["raw_content"]).to eq("# Test Page\n")
    end

    it "doesn't contain front matter defaults" do
      get "/pages/page.md"
      expect(last_response_parsed.key?("some_front_matter")).to eql(false)
    end

    it "404s for an unknown page" do
      get "/pages/foo.md"
      expect(last_response.status).to eql(404)
    end
  end

  it "writes a new page" do
    path = File.expand_path "page-new.md", fixture_path("site")
    File.delete(path) if File.exist?(path)

    request = {
      :meta => { :foo => "bar" },
      :body => "test"
    }
    put '/pages/page-new.md', request.to_json

    expect(last_response).to be_ok
    expect(last_response_parsed["foo"]).to eq('bar')

    File.delete(path)
  end

  it "updates a page" do
    path = File.expand_path "page-update.md", fixture_path("site")
    File.delete(path) if File.exist?(path)
    File.write path, "---\n---\n\ntest"

    request = {
      :meta => { :foo => "bar2" },
      :body => "test"
    }
    put '/pages/page-update.md', request.to_json

    expect(last_response).to be_ok
    expect(last_response_parsed["foo"]).to eq('bar2')

    File.delete(path)
  end

  it "deletes a page" do
    path = File.expand_path "page-delete.md", fixture_path("site")
    File.delete(path) if File.exist?(path)
    File.write path, "---\n---\n\ntest"
    Jekyll::Admin.site.process

    delete '/pages/page-delete.md'
    expect(last_response).to be_ok
    expect(File.exist?(path)).to eql(false)
  end
end
