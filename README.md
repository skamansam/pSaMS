# padrino Sam's Management System
This is not a port, but a complete rewrite of SaMS (http://rbe.homeip.net/content/projects/MeApps/sams.html),
in padrino.

## About SaMS
In 1997, all I had available for my website was very limited hosting via an Earthlink account. This
account did offer one thing most other free providers lacked: Perl support. So I learned Perl
and implemented a content management system for my site. Originally, it was intended to be 
a workaround for the inconsistencies in browser implementations for a dynamic navigation tree,
but a acquired a few more features over the years.

## About MeApps
A little while after creating SaMS, I heard about a new trend called "web logs," or just
"blogging." I could not find any good free blogging software, so I wrote my own, called
"MeBlog." MeBlog used a flat-file backend as a database, so it could be used on any
basic web server with only Perl support. The added advantage is you could read the 
entries without the need for any special software. 

MeBlog led to more adventurous apps, including MeStart, a fully customizable start page in the vein of 
Google Home. All these and more can be found 

## pSaMS Features

### Theme API
You can add your own theme assets, under app/assets/*/theme/theme_name/ and use the 

### Two themes to get started
pSaMS comes with two thems, one which uses Bootstrap, and one which uses jQuery-UI

### Javascript Source Map support
For javascript development, pSaMS is preconfigured to generate a custom source map with
each javascript file, only in development mode. Production mode does not generate 
source maps, and uses the closure compiler.

### Sub-App Support
Since pSaMS is built using padrino, you can create your own sub-apps easily. See the
[Padrino](http://www.padrinorb.com/guides/generators#sub-app-generator) site for more.
There are two apps included: 
  * A download app, for tracking and uploading files for sharing
  * A photo app, for showing the world your amazing adventures

## Getting Started

### Requirements

pSaMS requires a working ruby environment. You can [install ruby here](https://www.ruby-lang.org/en/installation/).

You also need a working version of Git, which can be [downloaded from here](http://git-scm.com/downloads).

If your environment is set up properly, you should be able to install the latest 
version of padrino by typing `gem install padrino` in a terminal.

### Installation / Configuration

All you need to do is grab the source of this app from GitHub and install all the necessary gems.
You can do that by opening up a terminal and typing the following:

```sh
cd /path/to/my/projects/folder
git clone https://github.com/skamansam/pSaMS.git
cd pSaMS
bundle install
```
### Problems?

If the `bundle install` command fails with errors installing the mysql gem, you could try
installing the gem manually or removing the line that begins `gem "mysql"` from the file Gemfile.
See [Changing Databases](Changing Databases) for more.

### Changing Databases

SQLite is used for development, as it is a local filestore database and requires no other 
running program to use. MySQL is the default for production mode, as it can be easily
configured to be used with a lot of hosting sites, or even [OpenShift](http://www.openshift.com),
and is a more "enterprise-y" solution. If you want to use MariaDB instead, just install 
it, as MariaDB is a drop-in replacement for MySQL.  

If you have problems install the mysql gem or just want to change your database, you can do so 
by changing the mysql gem specification in the Gemfile to your database of choice. For
instance, if you want to use MongoDB for a backend, change the 

### Hosted Deployment

If you want to get pSaMS up and running quickly, you can use one of the following hosted
rails servers.

#### Amazon EC2

#### Heroku

The Heroku gem is deprecated; please install [the Heroku Toolbelt from here](https://toolbelt.heroku.com/). 

Ensure your selected database is postgresql by adding the postgresql gem to the Gemfile
and uncommenting and editing the postgresql configuration in config/database.rb.

After that, issue the follwoing commands

```sh

# go into the project directory
cd /path/to/pSaMS

# login to heroku
heroku login

# create a heroku app with the cedar stack. Change $mysite$ to the app name you want
heroku create --stack cedar $mysite$

# add the postgres database to your heroku app
heroku addons:add heroku-postgresql

#get the name of the database. it will be something like HEROKU_POSTGRESQL_$db_name$_URL
heroku pg

# get the postgres login information for your database. $db_name$ is taken from last command
# credentials are in connection info string (dbname, host, user, password, sslmode)
heroku pg:credentials $db_name$

#set the variables so we can use them in config/database.rb. Replace the appropriate vriables 
heroku config:set PG_DB=$dbname$ PG_HOST=$host$ PG_USER=$user$ PG_PASS=$password$
```

#### OpenShift Origin

#### Engine Yard

### Optimizations

There are a few optimizations you can make to pSaMS if you want to speed up content 
delivery on your server. 

#### Redis

#### Memcached


