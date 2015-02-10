PSaMs::Admin.controllers :preferences do
  layout 'application.haml'
  get :index do
    @title = "Preferences"
    @preferences = Preference.all
    render 'preferences/index'
  end

  get :new do
    @title = pat(:new_title, :model => 'preference')
    @preference = Preference.new
    render 'preferences/new'
  end

  post :create do
    @preference = Preference.new(params[:preference])
    if @preference.save
      @title = pat(:create_title, :model => "preference #{@preference.id}")
      flash[:success] = pat(:create_success, :model => 'Preference')
      params[:save_and_continue] ? redirect(url(:preferences, :index)) : redirect(url(:preferences, :edit, :id => @preference.id))
    else
      @title = pat(:create_title, :model => 'preference')
      flash.now[:error] = pat(:create_error, :model => 'preference')
      render 'preferences/new'
    end
  end

  get :edit, :with => :id do
    @title = pat(:edit_title, :model => "preference #{params[:id]}")
    @preference = Preference.find(params[:id])
    if @preference
      render 'preferences/edit'
    else
      flash[:warning] = pat(:create_error, :model => 'preference', :id => "#{params[:id]}")
      halt 404
    end
  end

  put :update, :with => :id do
    @title = pat(:update_title, :model => "preference #{params[:id]}")
    @preference = Preference.find(params[:id])
    if @preference
      if @preference.update_attributes(params[:preference])
        flash[:success] = pat(:update_success, :model => 'Preference', :id =>  "#{params[:id]}")
        params[:save_and_continue] ?
          redirect(url(:preferences, :index)) :
          redirect(url(:preferences, :edit, :id => @preference.id))
      else
        flash.now[:error] = pat(:update_error, :model => 'preference')
        render 'preferences/edit'
      end
    else
      flash[:warning] = pat(:update_warning, :model => 'preference', :id => "#{params[:id]}")
      halt 404
    end
  end

  delete :destroy, :with => :id do
    @title = "Preferences"
    preference = Preference.find(params[:id])
    if preference
      if preference.destroy
        flash[:success] = pat(:delete_success, :model => 'Preference', :id => "#{params[:id]}")
      else
        flash[:error] = pat(:delete_error, :model => 'preference')
      end
      redirect url(:preferences, :index)
    else
      flash[:warning] = pat(:delete_warning, :model => 'preference', :id => "#{params[:id]}")
      halt 404
    end
  end

  delete :destroy_many do
    @title = "Preferences"
    unless params[:preference_ids]
      flash[:error] = pat(:destroy_many_error, :model => 'preference')
      redirect(url(:preferences, :index))
    end
    ids = params[:preference_ids].split(',').map(&:strip)
    preferences = Preference.find(ids)

    if Preference.destroy preferences

      flash[:success] = pat(:destroy_many_success, :model => 'Preferences', :ids => "#{ids.to_sentence}")
    end
    redirect url(:preferences, :index)
  end
end
