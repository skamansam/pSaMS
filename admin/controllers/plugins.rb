PSaMs::Admin.controllers :plugins do
  get :index do
    @title = "Plugins"
    @plugins = Plugin.all
    render 'plugins/index'
  end

  get :new do
    @title = pat(:new_title, :model => 'plugin')
    @plugin = Plugin.new
    render 'plugins/new'
  end

  get :show, :with=> :id do
    @title = pat(:show_title, :model => 'plugin')
    @plugin = Plugin.find(params[:id])
    render 'plugins/show'
  end

  post :create do
    @plugin = Plugin.new(params[:plugin])
    if @plugin.save
      @title = pat(:create_title, :model => "plugin #{@plugin.id}")
      flash[:success] = pat(:create_success, :model => 'Plugin')
      params[:save_and_continue] ? redirect(url(:plugins, :index)) : redirect(url(:plugins, :edit, :id => @plugin.id))
    else
      @title = pat(:create_title, :model => 'plugin')
      flash.now[:error] = pat(:create_error, :model => 'plugin')
      render 'plugins/new'
    end
  end

  get :edit, :with => :id do
    @title = pat(:edit_title, :model => "plugin #{params[:id]}")
    @plugin = Plugin.find(params[:id])
    if @plugin
      render 'plugins/edit'
    else
      flash[:warning] = pat(:create_error, :model => 'plugin', :id => "#{params[:id]}")
      halt 404
    end
  end

  put :update, :with => :id do
    @title = pat(:update_title, :model => "plugin #{params[:id]}")
    @plugin = Plugin.find(params[:id])
    if @plugin
      if @plugin.update_attributes(params[:plugin])
        flash[:success] = pat(:update_success, :model => 'Plugin', :id =>  "#{params[:id]}")
        params[:save_and_continue] ?
          redirect(url(:plugins, :index)) :
          redirect(url(:plugins, :edit, :id => @plugin.id))
      else
        flash.now[:error] = pat(:update_error, :model => 'plugin')
        render 'plugins/edit'
      end
    else
      flash[:warning] = pat(:update_warning, :model => 'plugin', :id => "#{params[:id]}")
      halt 404
    end
  end

  delete :destroy, :with => :id do
    @title = "Plugins"
    plugin = Plugin.find(params[:id])
    if plugin
      if plugin.destroy
        flash[:success] = pat(:delete_success, :model => 'Plugin', :id => "#{params[:id]}")
      else
        flash[:error] = pat(:delete_error, :model => 'plugin')
      end
      redirect url(:plugins, :index)
    else
      flash[:warning] = pat(:delete_warning, :model => 'plugin', :id => "#{params[:id]}")
      halt 404
    end
  end

  delete :destroy_many do
    @title = "Plugins"
    unless params[:plugin_ids]
      flash[:error] = pat(:destroy_many_error, :model => 'plugin')
      redirect(url(:plugins, :index))
    end
    ids = params[:plugin_ids].split(',').map(&:strip)
    plugins = Plugin.find(ids)
    
    if Plugin.destroy plugins
    
      flash[:success] = pat(:destroy_many_success, :model => 'Plugins', :ids => "#{ids.to_sentence}")
    end
    redirect url(:plugins, :index)
  end
end
