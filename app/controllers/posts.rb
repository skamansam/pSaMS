PSaMs::App.controllers :posts do
  #layout &:set_theme
  layout :application

  get :index, :map=>"/posts" do
    @posts = Post.all(:order=>'updated_at desc')
    render "posts/index" #, :layout=>theme_layout_path
  end

  get :show, map: "/posts/:id" do
    @post = nil #Post.find_by_id(params[:id]) || Post.find_by_path(params[:id])
    render "show"
  end
  get :category, with: :id do 
    @posts = Category.find_by_id(params[:id]).posts # || Category.find_by_name(:id)).try(:posts)
    render "index"
  end

  get :category_tags, map: "/posts/category/:category_id/tags/*tags" do
    render params.inspect
  end
  
  get :tags, with: :tag_name do
    render params.inspect
  end

end
