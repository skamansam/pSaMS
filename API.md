# pSaMS Plugin API

## Audience
This is a document describing the API for creating plugins for use with pSaMS. If you are familiar with WordPress plugin creation, you already have the basics for pSaMS plugin creation.

## Installing Plugins
Plugins can be installed by adding them to the `Gemfile`, as you would add other gems, or dropping them into the `/plugins` folder. You can use the administration console to activate or deactivate plugins once they have been installed. 

## Plugin Initialization
Each plugin must inherit `pSaMS::Plugin` and have an `#initialize` method which registers itself with the appropriate hook. 

## Plugin Implementation
### Asynchronous Execution
Some hooks are implemented using the publisher-subscriber ("pub/sub") pattern, and are executed asynchronously. Any hooks that process data before saving to the Database are asynchronously executed. Plugins which `include pSaMS::Plugin::Subscriber` are, obviously, the latter part of this pattern.

### Synchronous Execution
Most hooks

### Mix 'N' Match
You can have a single plugin that 

### Example

```ruby
# /path/to/pSaMS/plugins/HelloWorld.rb
# This plugin creates a new menu item, and displays simple text.
``
