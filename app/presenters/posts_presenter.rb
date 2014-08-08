class PostsPresenter
  attr_reader :posts, :posts_class

  def initialize(posts)
    @posts = posts.map{ |p| PostPresenter.new(p)}
    @posts_class = FilterPlugin.apply_filter('posts_class','posts',posts)
  end
end
