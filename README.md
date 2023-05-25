there is no database in this project, in this project you will find an implementation to talk to contentful API, I used contentful gem to do this task, in this task I did the following:

1- I added recipe controller, which has two actions (show and index)

2- I added a service to act as an interface when talking to contentful (app/services/contentful_interface.rb)

3- I added tests for both the controller and the service


# Run
- `$ bundle install`
- `$ rails s`

# Rspec
to run tests run 
- `$ rspec`

I used Rails 6 with Ruby 3
