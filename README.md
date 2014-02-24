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


