class PostPresenter
  attr_reader :body, :title, :post_date, :author_string,
              :body_class, :title_class, :post, :id, :updated_at,
              :created_at, :tags, :account, :comments
  def initialize(post)
    puts post.inspect
    @post = post
    @body = Plugin.apply_filter('post_content', post.body,post.freeze)
    @title = Plugin.apply_filter('post_title', post.title,post.freeze)
    @author_string = Plugin.apply_filter('post_author', post.account,post.freeze)
    @body_class = Plugin.apply_filter('post_body_class', "body", post.freeze)
    @title_class = Plugin.apply_filter('post_title_class', "title",post.freeze)
    @updated_at = Plugin.apply_filter('post_updated_at', post.updated_at.localtime,post.freeze)
    @created_at = Plugin.apply_filter('post_created_at', post.created_at.localtime,post.freeze)
    @id = Plugin.apply_filter('post_id', post.id,post.freeze)
    @tags = Plugin.apply_filter('post_tags', post.tags,post.freeze)
    @account = Plugin.apply_filter('post_account', post.account,post.freeze)
    @comments = CommentsPresenter.new(post.comments)
  end
end
