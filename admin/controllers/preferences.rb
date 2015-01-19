PSaMs::Admin.controllers :preferences do
  layout 'application.haml'
  get :index, provides: [:js] do
    @prefs = Preference.all
    json prefs: [:one,:two]
  end

  post :create, provides: [:json] do
    @pref = Preference.new(params[:preference])
    if @pref.save
      flash[:success] = pat(:create_success, :model => 'Preference')
      params[:save_and_continue] ? redirect(url(:categories, :index)) : redirect(url(:categories, :edit, :id => @category.id))
    else
      @title = pat(:create_title, :model => 'category')
      flash.now[:error] = pat(:create_error, :model => 'category')
      render 'categories/new'
    end
  end

  put :update, :with => :id, provides: [:json] do
    @title = pat(:update_title, :model => "category #{params[:id]}")
    @category = Category.find(params[:id])
    if @category
      if @category.update_attributes(params[:category])
        flash[:success] = pat(:update_success, :model => 'Category', :id =>  "#{params[:id]}")
        params[:save_and_continue] ?
        redirect(url(:categories, :index)) :
        redirect(url(:categories, :edit, :id => @category.id))
      else
        flash.now[:error] = pat(:update_error, :model => 'category')
        render 'categories/edit'
      end
    else
      flash[:warning] = pat(:update_warning, :model => 'category', :id => "#{params[:id]}")
      halt 404
    end
  end

  delete :destroy, :with => :id, provides: [:json] do
    @title = "Categories"
    category = Category.find(params[:id])
    if category
      if category.destroy
        flash[:success] = pat(:delete_success, :model => 'Category', :id => "#{params[:id]}")
      else
        flash[:error] = pat(:delete_error, :model => 'category')
      end
      redirect url(:categories, :index)
    else
      flash[:warning] = pat(:delete_warning, :model => 'category', :id => "#{params[:id]}")
      halt 404
    end
  end

  delete :destroy_many, provides: [:json] do
    @title = "Categories"
    unless params[:category_ids]
      flash[:error] = pat(:destroy_many_error, :model => 'category')
      redirect(url(:categories, :index))
    end
    ids = params[:category_ids].split(',').map(&:strip)
    categories = Category.find(ids)

    if Category.destroy categories

      flash[:success] = pat(:destroy_many_success, :model => 'Categories', :ids => "#{ids.to_sentence}")
    end
    redirect url(:categories, :index)
  end
end
