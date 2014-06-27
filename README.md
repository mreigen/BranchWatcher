## Rails 4 application squeleton for the IO team

### Important:
To use this application:  
- Check it out, then change the name. (do not clone it)
- Uncomment the line gem 'rename' in the gem file  
- In the app folder run: `rails g rename:app_to your_new_name`  
- Comment the gem 'rename'

This application is working with Redis, MOngoDB and Postgress
(Postgress is actually commented out but can be reinstated by uncommening the postgress gem in gemfile
and the active record line in application.rb)

### Stack:
* Ruby version 2.1
* RoR version 4.0.2

* System dependencies
  Redis, MongoDB
  Good to use Zeus to speadup application loading on dev environment

* to install Redis and mongo on a mac  
   `brew doctor`  
   `brew install redis`  
   `brew install mongodb`  
   `brew doctor`  

* setup the dbpath directory: (option —dbpath xxx for other location)  
  `sudo mkdir -p /data/db`

  make it writable by you:  
  `sudo chown 'id -u' /data/db`


* To have mongo start on startup:  
   `ln -sfv /usr/local/opt/mongodb/*.plist ~/Library/LaunchAgents`

* To start mongodb and redis, on a prompt or on screen  
  `mongod`  
  `redis`  

* to use Zeus cd in your project directory:  
  `gem install zeus`  
  `zeus init`  
  `zeus start`  

  Rails server: `zeus s`  
  Console:  `zeus c` 

  More info here: http://robots.thoughtbot.com/improving-rails-boot-time-with-zeus
