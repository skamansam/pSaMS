PSaMs::Admin.controllers :plugins do
  layout 'application.haml'
  get :index do
    flash[:error] = error_check
    @title = "Plugins"
    #@plugins = Plugin.select('plugins.*,count(name) as plugin_count').group(:name).order(:name)
    @plugins = Plugin.select('*,count(name) as cnt').group(:name).order(:name)
    if params[:reload]
      Plugin.reload_plugins!
    end
    render 'plugins/index'
  end

  get :new do
    flash[:error] = error_check
    @title = pat(:new_title, :model => 'plugin')
    @plugin = Plugin.new
    render 'plugins/new'
  end

  get :show, :with=> :id do
    flash[:error] = error_check
    @title = pat(:show_title, :model => 'plugin')
    @plugin = Plugin.find(params[:id])
    @plugin_methods = Plugin.where(name: @plugin.name).order([:plugin_type,:class_name])
    @plugin_object = @plugin.plugin_object
    render 'plugins/show'
  end

  post :create, :with=> :id do
    flash[:error] = error_check
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
    flash[:error] = error_check
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
    flash[:error] = error_check
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
    flash[:error] = error_check
    @title = "Plugins"
    plugin = Plugin.find(params[:id])
    logger.info "Deactivating Plugin #{plugin.present? ? plugin.name : params[:id]}"
    if plugin
      if (plugin.active && plugin.update_attributes(:active=>false)) ||
         (!plugin.active && plugin.delete)
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
    flash[:error] = error_check
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
