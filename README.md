# TODO List
This is Rails + AngularJS application.

## Task manager

I'm a person who passionate about own productivity. I want to manage my tasks and projects more effectively. I need a simple tool that supports me in controlling my task­flow.

### Functional requirements

1. I want to be able to sign in/sign up by email/password or Facebook
2. I want to be able to create/update/delete projects
3. I want to be able to add tasks to my project
4. I want to be able to update/delete tasks
5. I want to be able to prioritise tasks into a project
6. I want to be able to choose deadline for my task
7. I want to be able to mark a task as 'done'
8. I want to be able to add coments to my tasks
9. I want to be able to delete coments
10. I want to be able to attache files to coments

### Technical requirements

1. It should be a WEB application
1.1. For the client side must be used: HTML5, CSS3, Twitter Bootstrap, JavaScript, AngularJS, jQuery.
1.2. For server side Ruby on Rails.
2. It should have client side and server side validation.
3. It should look like on screens (see attached file ‘rg_test_task_grid.png’).
4. It should work like one page WEB application and should use AJAX technology, load and submit data without reloading a page.
5. It should have user authentication solution and a user should only have access to theirown projects and tasks (Devise, Cancancan).
6. It should have automated tests for all functionality (models ­ RSpec, controllers ­ RSpec, acceptance/functional tests ­ RSpec + Capybara).