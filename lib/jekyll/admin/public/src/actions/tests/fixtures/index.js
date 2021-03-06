export const doc = {
  "id": "the-revenant",
  "collection": "movies",
  "content": "ha ha",
  "layout": "default",
  "title": "The Revenant",
  "path": "the-revenant.md"
};

export const documents = [
  {
    "id": "2016-05-20-testing-posts",
    "collection": "posts",
    "content": "You’ll find this post in your `_posts` directory.",
    "layout": "post",
    "title": "Testing Posts",
    "date": "2016-05-20 01:10:46 +0300",
    "categories": "test",
    "path": "2016-05-20-testing-posts.md"
  },
  {
    "id": "2016-05-29-google-summer-of-code",
    "collection": "posts",
    "content": "You’ll find this post in your `_posts` directory.",
    "layout": "post",
    "title": "Google Summer of Code!",
    "date": "2016-05-29 01:10:46 +0300",
    "categories": "gsoc",
    "students": [
      {
        "name": "Mert Kahyaoğlu",
        "email": "mertkahyaoglu93@gmail.com",
        "username": "mertkahyaoglu"
      },
      {
        "name": "Ankur Singh",
        "email": "ankur13019@iiitd.ac.in",
        "username": "rush-skills"
      }
    ],
    "mentors": ["Ben Balter", "Jurgen Leschner", "Parker Moore"],
    "path": "2016-05-29-google-summer-of-code.md"
  },
  {
    "id": "2016-01-01-some-post",
    "collection": "posts",
    "content": "You’ll find this post in your `_posts` directory.",
    "layout": "post",
    "title": "Welcome to Jekyll!",
    "date": "2016-01-01 01:10:46 +0300",
    "categories": "jekyll update",
    "path": "2016-01-01-some-post.md"
  }
];

export const collections = [
  {
    "path": "/posts",
    "title": "Posts"
  },
  {
    "path": "/movies",
    "title": "Movies"
  }
];

export const page = {
  "name": "contact.md",
  "content": "This is the base Jekyll theme.",
  "layout": "page",
  "title": "Contact Page",
  "dir": "/",
  "url":"/page.html",
  "path": "contact.md"
};

export const state = {
  body: 'Google summer of code is awesome',
  path: 'gsoc.md',
  title: 'Google Summer of Code',
  published: true,
  layout: "post",
  categories: "gsoc",
  students: [
    "GSoC Students",
    {
      name: {
        first: "Mert",
        last: "Kahyaoğlu"
      },
      email: [
        "mertkahyaoglu93@gmail.com",
        "test@gmail.com"
      ],
      username: "mertkahyaoglu"
    },
    {
      name: {
        first: "Ankur",
        last: "Singh"
      },
      email: "ankur13019@iiitd.ac.in",
      username: "rush-skills"
    }
  ],
  mentors: ["Ben Balter", "Jurgen Leschner", "Parker Moore"],
  new_field_count: 0
};
