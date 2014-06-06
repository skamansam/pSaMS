PSaMs::App.controllers :posts do
  #layout &:set_theme
  layout :application

  before_filter :load_category

  get :index, :map=>"/posts" do
    @posts = Post.without_news.order('updated_at desc').all
    @category = Category.find_by_id(params[:category_id]) || Category.first
    render "posts/index" #, :layout=>theme_layout_path
  end

  get :show, map: "/posts/:id" do
    @post = Post.find_by_id(params[:id]) #|| Post.find_by_path(params[:id])
    render "show"
  end
  get :category, with: :id do 
    @category = Category.find_by_id(params[:id])
    @posts = category.posts.without_news # || Category.find_by_name(:id)).try(:posts)
    render "index"
  end

  get :category_tags, map: "/posts/category/:category_id/tags/*tags" do
    render params.inspect
  end
  
  get :tags, with: :tag_name do
    render params.inspect
  end

  private 
  def load_category
    @category = Category.find_by_id(params[:id]) || Category.first
  end

end
