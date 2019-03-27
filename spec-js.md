# Specifications for the Rails with jQuery Assessment

Specs:
- [X] Use jQuery for implementing new requirements (jQuery is used in prayers.js)
- [X] Include a show resource rendered using jQuery and an Active Model Serialization JSON backend. (navigate through bible prayers show views)
- [X] Include an index resource rendered using jQuery and an Active Model Serialization JSON backend. (load prayer comments on prayer show page)
- [X] Include at least one has_many relationship in information rendered via JSON and appended to the DOM. (prayer has many comments - JSON: /prayers/prayer_id/comments)
- [X] Use your Rails API and a form to create a resource and render the response without a page refresh. (create group_comments on group)
- [X] Translate JSON responses into js model objects. (function showComments implements creation of comment JS model objects)
- [X] At least one of the js model objects must have at least one method added by your code to the prototype.(comment formatter for prayer show page)

Confirm
- [X] You have a large number of small Git commits
- [X] Your commit messages are meaningful
- [X] You made the changes in a commit that relate to the commit message
- [X] You don't include changes in a commit that aren't related to the commit message