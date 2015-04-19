## Courses Github Page

This branch is used to generate our Github Pages for the courses site. The pages are published to [http://umn-asr.github.io/courses/](http://umn-asr.github.io/courses/)


### Updating the site

- Checkout the gh-pages branch of the courses repo
- `bundle install --path ./vendor/bundle`
- Site pages are in the top-level directory.
  - The main page of the site is index.md
- Edit the page as needed
- `bundle exec jekyll serve --watch`
- [http://localhost:4000/courses/index.html](http://localhost:4000/courses/index.html) to review your changes
- Commit and push back to the gh-pages branch
- Wait a bit for the site to build, then check the url to make sure that nothing weird happened
