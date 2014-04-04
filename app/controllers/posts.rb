PSaMs::App.controllers :posts do

  # get :index, :map => '/foo/bar' do
  #   session[:foo] = 'bar'
  #   render 'index'
  # end

  # get :sample, :map => '/sample/url', :provides => [:any, :js] do
  #   case content_type
  #     when :js then ...
  #     else ...
  # end

  # get :foo, :with => :id do
  #   'Maps to url '/foo/#{params[:id]}''
  # end

  # get '/example' do
  #   'Hello world!'
  # end

  get :index do
    @posts = Post.all(:order=>'updated_at desc')
    render "posts/index"
  end

  get :show do
    @post = Post.find_by_id(params[:id]) || Post.find_by_path(params[:id])
    render "posts/show"
  end

  get :category, with: :id do 
    @posts = Category.find_by_id(params[:id])
    render "posts/index"
  end
end
