################### INTRODUCTION ######################

This project is the whole backend of Tocarta and serves for 2 purposes:

1. For administration purpose
2. Provide APIs for all tablets and mobile phones

################### INSTALLATION ######################

Please follow these instructions to install the project:

1. Inside your Workspace, clone the project using GIT

$ git clone https://<bitbucket_username>@bitbucket.org/tocarta/tocarta-admin.git

2. Switch to dev branch

$ git checkout dev

3. Install and config all gems

$ bundle install

4. Pull database from server

** Download and install PostgreSQL: http://postgresapp.com **

$ heroku db:pull --app tocarta-admin-staging

5. Start server

$ rails s
$ open http://localhost:3000

################### Making changes to the project ######################

Please follow these instructions to make changes to the project:

1. Pull project and merge files if necessary

$ git pull

2. Make sure database migration is up-to-date

$ rake db:migrate

3. Check files before commit and commit changes

$ git status
$ git add .
$ git commit -am "introducing feature <----> related to trello_ticket_id <----->"
$ git push

################### Working with the API ######################

Check APIs at: http://localhost:3000/api

To make changes in the API Console:

1. Review and make changes in the file: tocarta-wadl.xml (in the root directory)
2. Login to https://apigee.com/togo (dev@tocarta.es/tcDevTe4m)
3. Upload the file and save. Then refresh the API Console Page.

################### DEPLOY TO SERVER ######################

Please follow these instructions in order to deploy to server:

1. Configure Heroku Remotes

$ git checkout master
$ heroku git:remote -r heroku-beta -a tocarta-admin-staging
$ heroku git:remote -r heroku-prod -a tocarta-admin

2. Merge dev into master

$ git checkout dev
$ git pull
$ git checkout master
$ git merge dev
$ git push

3. Push to Staging and test it

$ git checkout master
$ git push heroku-beta master
$ heroku run "rake db:migrate" --app tocarta-admin-staging
$ open http://beta.tocarta.com

4. Push to Production and test it

$ git checkout master
$ git push heroku-prod master
$ heroku run "rake db:migrate" --app tocarta-admin
$ open http://admin.tocarta.es

