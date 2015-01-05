PSaMs::Admin.controllers :base do
  layout 'application.haml'
  get :index, :map => "/" do
    flash[:error] = error_check
    render "base/index"
  end
end
