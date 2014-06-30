# pSaMS Plugin API

## Audience
This is a document describing the API for creating plugins for use with pSaMS. If you are familiar with WordPress plugin creation, you already have the basics for pSaMS plugin creation.

## Installing Plugins
Plugins can be installed by adding them to the `Gemfile`, as you would add other gems, or dropping them into the `/plugins` folder. You can use the administration console to activate or deactivate plugins once they have been installed. 

## Plugin Initialization
Each plugin must inherit `pSaMS::Plugin` and have an `#initialize` method which registers itself with the appropriate hook. 

## Plugin Implementation

### Plugin DSL
The Plugin API uses an easy DSL (domain-specific language) to encourage everyone to create plugins and to remove the hassle of plugin creation and integration. There is also a compatibility layer for those familiar with WordPress plugin creation.

### Asynchronous Execution
Some hooks are implemented using the publisher-subscriber ("pub/sub") pattern, and are executed asynchronously. Any hooks that process data before saving to the Database are asynchronously executed. Plugins which `include pSaMS::Plugin::Subscriber` are, obviously, the latter part of this pattern.

### Synchronous Execution
Most hooks

### Mix 'N' Match
You can have a single plugin that has many different methods for hooking into pSaMS. For instance, you can have a plugin for editing text that has a view for editing posts, a processor for preprocessing text before it is saved into the database, and has another processor for when the data is retrieved from the database. The first example plugin that comes with pSaMS, for editing posts with Markdown (and saving/processing images) and has all these features.

### Example

```ruby
# /path/to/pSaMS/plugins/HelloWorld.rb
# This plugin creates a new menu item, and displays simple text.
Module PSaMS
    class Route::HelloWorld << Plugin::Page
      route '/hello' do
        menu "Hello, World!"
        contents file("content.html") 
      end
    end
    class Editor::HelloWorld << PSaMS::Plugin::Editor
      admin_page ""
      class "hello_editor"
      id "hello"
      
      add_js :jquery, "js/jquery-1.10.12.js"
      add_css :hello_editor, "js/hello-1.0.1.js"
      
      contents "Hello, pSaMS!!!"

      layout "<div id='toolbar'></div>{{input}}" #default is "{{input}}"
      js [:jquery,'hello_world_editor'] #calls add_js(file.dehumanize.to_sym,'js/#{file}.js') for strings
      css ['hello_world_editor',:bootstrap]
      
      on_show replace_markers
      on_save convert_to_haml
      
      def convert_to_haml(post)
        ...
      end
      def convert_to_haml(post)
        ...
      end
    end
end

register_plugin(PSamS::Editor::HelloWorld)
register_plugin(PSamS::Route::HelloWorld)

``
