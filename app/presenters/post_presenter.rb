class PostPresenter
  attr_reader :body, :title, :post_date, :author_string, :body_class, :title_class, :post, :id, :updated_at, :created_at, :tags, :account
  def initialize(post)
    #binding.pry
    puts post.inspect
    @post = post
    @body = Plugin.apply_filter('the_content', post.body,post.freeze)
    @title = Plugin.apply_filter('the_title', post.title,post.freeze)
    @author_string = Plugin.apply_filter('the_author', post.account,post.freeze)
    @body_class = Plugin.apply_filter('body_class', "body",post.freeze)
    @title_class = Plugin.apply_filter('title_class', "title",post.freeze)
    @updated_at = Plugin.apply_filter('the_updated_at', post.updated_at,post.freeze)
    @created_at = Plugin.apply_filter('the_created_at', post.created_at,post.freeze)
    @id = Plugin.apply_filter('the_id', post.id,post.freeze)
    @tags = Plugin.apply_filter('the_tags', post.tags,post.freeze)
    @account = Plugin.apply_filter('the_accounr', post.account,post.freeze)
  end
end
