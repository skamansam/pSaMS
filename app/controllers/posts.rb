PSaMs::App.controllers :posts do
  #layout &:set_theme
  layout :application

  get :tags, provides: [:json,:js] do
    ActsAsTaggableOn::Tag.all.map(&:name).to_json
  end

  get :index, :map=>"/posts" do
    @presenter = PostsPresenter.new(@posts = Post.without_news.order('updated_at desc').all)
    load_category
    render "posts/index" #, :layout=>theme_layout_path
  end

  get :tags, :with=>:tag_name do
    @posts = Post.without_news.tagged_with(params[:tag_name]).order('updated_at desc')
    @presenter = PostsPresenter.new(@posts)
    load_category
    render "posts/index" #, :layout=>theme_layout_path
  end

  get :show, map: "/posts/:id" do
    @post = PostPresenter.new(Post.find_by_id(params[:id]))
    load_category
    render "show"
  end
  get :category, with: :id do
    load_category(params[:id])
    logger.info params.inspect
    logger.info @category.inspect
    @posts = @category.posts.without_news # || Category.find_by_name(:id)).try(:posts)
    @presenter = PostsPresenter.new(@posts)
    render "index"
  end

  get :category_tags, map: "/posts/category/:category_id/tags/*tags" do
    load_category
    render params.inspect
  end

  get :tags, with: :tag_name do
    load_category
    render params.inspect
  end

end
