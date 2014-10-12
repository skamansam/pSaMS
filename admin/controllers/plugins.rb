PSaMs::Admin.controllers :plugins do
  layout 'application.haml'
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
    @plugin_object = @plugin.plugin_object
    render 'plugins/show'
  end

  post :create, :with=> :id do
    @title = "Plugins"
    plugin = Plugin.find(params[:id])
    logger.info "Deactivating Plugin #{plugin.present? ? plugin.name : params[:id]}"
    if plugin
      if plugin.update_attributes(:active=>true)
        flash[:success] = pat(:create_success, :model => 'Plugin', :id => "#{params[:id]}")
      else
        flash[:error] = pat(:create_error, :model => 'plugin')
      end
      redirect url(:plugins, :index)
    else
      flash[:warning] = pat(:create_warning, :model => 'plugin', :id => "#{params[:id]}")
      halt 404
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
    logger.info "Deactivating Plugin #{plugin.present? ? plugin.name : params[:id]}"
    if plugin
      if plugin.update_attributes(:active=>false)
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
    plugins = Plugin.where(id: ids)

    if plugins.update_all(:active=>false)

      flash[:success] = pat(:destroy_many_success, :model => 'Plugins', :ids => "#{ids.to_sentence}")
    end
    redirect url(:plugins, :index)
  end
end
