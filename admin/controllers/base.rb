PSaMs::Admin.controllers :base do
  layout 'application.haml'
  get :index, :map => "/" do
    render "base/index"
  end
end
