class BasicEditor 
  #include Editor
  
  def initialize(plugin_path,post)
  end
  
  def editor_name
    "Plain Text"
  end
  
  def editor_pane
    render plugin_path("views/")
  end
end
