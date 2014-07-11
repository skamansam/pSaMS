# padrino Sam's Management System
This is not a port, but a complete rewrite of SaMS (http://rbe.homeip.net/content/projects/MeApps/sams.html), in padrino.

## About SaMS
In 1997, all I had available for my website was very limited hosting via an Earthlink account. This account did offer one thing most other free providers lacked: Perl support. So I learned Perl and implemented a content management system for my site. Originally, it was intended to be a workaround for the inconsistencies in browser implementations for a dynamic navigation tree,
but a acquired a few more features over the years.

## About MeApps
A little while after creating SaMS, I heard about a new trend called "web logs," or just "blogging." I could not find any good free blogging software, so I wrote my own, called "MeBlog." MeBlog used a flat-file backend as a database, so it could be used on any basic web server with only Perl support. The added advantage is you could read the entries without the need for any special software. 

MeBlog led to more adventurous apps, including MeStart, a fully customizable start page in the vein of Google Home. All these and more can be found 

## pSaMS Features

### Theme API
You can add your own theme assets, under app/assets/*/theme/theme_name/ and use the 

### Two themes to get started
pSaMS comes with two thems, one which uses Bootstrap, and one which uses jQuery-UI

### Javascript Source Map support
For javascript development, pSaMS is preconfigured to generate a custom source map with each javascript file, only in development mode. Production mode does not generate source maps, and uses the closure compiler.

### Sub-App Support
Since pSaMS is built using padrino, you can create your own sub-apps easily. See the [Padrino](http://www.padrinorb.com/guides/generators#sub-app-generator) site for more.
There are two apps included: 
  * A download app, for tracking and uploading files for sharing
  * A photo app, for showing the world your amazing adventures

## Roadmap/Features

This is a tentative release schedule. My personal challenge is to hit a 
release or mid-release every 6 months, so that means version 0.5 should be finished sometime in June 2014 and version 4.0 should come out January 2018.

NOTE: I will not support non-free or non-cross-platform APIs or data sources, 
such as iCloud, which is iOS only. If you need support for such services, consider becoming a contributer to pSaMS!

All italicized items have been started, but not finished. All emboldened 
items are finished! All others are features that have not been started. 

* Release 0.1 "MV" ("Minimal Viable")
  * _Manage posts_
    * _Cane be authored in several formats_:
      * __Plain text__
      * Markdown
      * HTML
      * Latex equation format
        - generate checksum for each latex
    * Switcher for editor
  * HTML Validator for all pages (javascript/link)
  * Add View shortcuts (helpers), for use with themes:
    * __Tag Cloud__
    * Category Cloud
    * __Category Menu__
  * Enable "widget" editor for helpers (which panels have which widgets in what order)
  * __Add a category as an external link__
  * __Manage Categories__
    * Sort via sort_by field__
    * Sortable categories
  * __Enable Tagging__
    * __Tag Cloud Widget on sidebar__
  * __configure Menu based on Categories__
  * __Enable basic theme support__ (see Themes section)
    * __Base theme is RBE "Bubbly Blue" theme__
  * Add several js libraries, with on-demand support, via require.js:
    * __jquery (no module loading support)__
    * jquery-ui (module loading of components)
    * __bootstrap__ (comes with padrino-admin)
    * angular (on-demand module loading of components)
    * Modernizr support (in case you REALLY want to break the interwebs)

* Release 0.5 "MV5"
  * Source Map Support in development mode
  * Better Themeability
    * Three themes: basic, clean and RBE "Bubbly Blue" theme
  * Two Sub-apps:
    * Downloads
    * Photos
  * Filestore backend capabilities:
    * Amazon S3 File Store
    * Google Drive

* Release 1.0 "Marcelis"
  * Package as a gem for ease of installation
  * Create plugin generator for ease of installation
  * extract HTML,Markdown, etc. editors into Plugins
  * i18n editor in admin panel (with https://github.com/svenfuchs/i18n-active_record ?)
  * Minimal Wordpress Plugin API Implementation (see API.md)

* Release 1.5 "Marcel15"
  * More filestore backend capabilities:
    * Box.net
    * DropBox
    * ownCloud
  * More sub-apps: 
    * Image GeoCaching

* Release 2.0 "ZedsDead"
  * Theme API (with isolated filepath and namespace)
  * Ability to import/export themes via admin console
  * Domain-Specific Language (DSL) for content

* Release 2.5 "2ed5Dead"
  * More sub-apps:
    * recipe management
      * kitchen inventory management
      * conversion of units
      * ingredient quantity change based on a single ingredient (i.e "I only have one egg, and I need two...\[recipe adjusts to suit\]")
      * MOP Checklist/wizard
      * Item checklist
      * Wizard interface (show about, then ingredients, then m.o.p. step by step)
      * print card-size and full-page
  * More filestore backend capabilities:
    * SkyDrive
    * SugarSync

* Release 3.0 ""
  * Theme Packaging for redistribution
  * DSL for page creation/templates

* Release 3.5
  * More filestore backend capabilities:
    * SpiderOak
    * SugarSync

* Release 4.0
  * Edit site layouts/templates via admin console
  * Package sub-apps as gems with "psams" namespace (i.e. 'psams-photos') for easy in/exclusion  


## Getting Started

### Requirements

pSaMS requires a working ruby environment. You can [install ruby here](https://www.ruby-lang.org/en/installation/).

You also need a working version of Git, which can be [downloaded from here](http://git-scm.com/downloads).

If your environment is set up properly, you should be able to install the latest version of padrino by typing `gem install padrino` in a terminal.

### Installation / Configuration

All you need to do is grab the source of this app from GitHub and install all the necessary gems. You can do that by opening up a terminal and typing the following:

```sh
cd /path/to/my/projects/folder
git clone https://github.com/skamansam/pSaMS.git
cd pSaMS
bundle install
```
### Problems?

If the `bundle install` command fails with errors installing the mysql gem, you could try installing the gem manually or removing the line that begins `gem "mysql"` from the file Gemfile. See [Changing Databases](Changing Databases) for more.

### Changing Databases

SQLite is used for development, as it is a local filestore database and requires no other running program to use. MySQL is the default for production mode, as it can be easily configured to be used with a lot of hosting sites, or even [OpenShift](http://www.openshift.com), and is a more "enterprise-y" solution. If you want to use MariaDB instead, just install it, as MariaDB is a drop-in replacement for MySQL.  

If you have problems install the mysql gem or just want to change your database, you can do so by changing the mysql gem specification in the Gemfile to your database of choice. For instance, if you want to use MongoDB for a backend, change the 

### Hosted Deployment

If you want to get pSaMS up and running quickly, you can use one of the following hosted rails servers.

#### Amazon EC2 (micro instance)

#### Heroku

The Heroku gem is deprecated; please install [the Heroku Toolbelt from here](https://toolbelt.heroku.com/). 

Ensure your selected database is postgresql by adding the postgresql gem to the Gemfile and uncommenting and editing the postgresql configuration in config/database.rb.

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

There are a few optimizations you can make to pSaMS if you want to speed up content delivery on your server. 

#### Redis
From the Redis homepage, "Redis is an open source, BSD licensed, advanced key-value store." What this means for Padrino is that instead of a slow, disk-based caching mechanism (or none at all!), Padrino can use a running Redis server to store caching information.

#### Memcached
From Wikipedia, "Memcached is a general-purpose distributed memory caching system. It is often used to speed up dynamic database-driven websites by caching data and objects in RAM to reduce the number of times an external data source (such as a database or API) must be read." What this means is that Padrino can use a memcached server to store the cache, in order to speed up page load times. In order to use this feature, simply add the following to app/app.rb (there is already a block comment for this so you can uncomment the appropriate code)


```register Padrino::Cache
   enable :caching 
   set :cache, Padrino::Cache::Store::Memcache.new(::Memcached.new('$host:port', :exception_retry_limit => 1))
```
Where $host:$port is the server host and port of your running Memcached server (i.e. 127.0.0.1:11211).

You can also setup your database to use Memcached.

#### Memcached + MySQL
See [the MySQL manual](http://dev.mysql.com/doc/refman/5.5/en/ha-memcached.html) for more information on this topic.
#### Memcached + PostgreSQL
#### Memcached + Your DB
I am sure by doing a little searching, you can find instructions on how to enable Memcached on the database of your choosing.


# Think you can do better?
You can become a contributer by cloning this repository, making your changes, and submitting a pull request. Remember to write tests (RSpec/Cucumber/TestUnit)! If nothing breaks, I will merge your changes into the main repo, add your feature to the list above and place your name below!

# Contributers

* Skaman Sam Tyler
  * Lead Developer/Creator
