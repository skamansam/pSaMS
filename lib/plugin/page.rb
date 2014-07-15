module Plugin::Page
  attr_reader :plugin_page_routing_table, # maps menu items to page renderers
                  :plugin_page_menu_table     # maps manu item
  
  def register_page(class_name,route_name,menu_name,render_function)
    plugin_page_menu_table[menu_name] = route_name
    plugins_page_routing_table[route_name][class_name] = render_function
  end

end
