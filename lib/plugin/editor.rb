module Plugin::Editor
  attr_reader :editor_table

  def get_default_editor
    editor_table.first
  end

  def set_default_editor(editor_class,editor_title=nil,editor_view=nil)
    idx = editor_table.index_of(edito_class) 
    editor = editor_table.delete(idx)
    editor_table.unshift(editor)
  end
end
