class CommentPresenter
  attr_reader :body, :title, :email_string, :body_class, :title_class, :post, :id, :updated_at, :created_att
  def initialize(comment)
    @comment = comment
    @body = Plugin.apply_filter('comment_content', comment.body,comment.freeze)
    @title = Plugin.apply_filter('comment_title', comment.title,comment.freeze)
    @email_string = Plugin.apply_filter('comment_email', comment.account,comment.freeze)
    @body_class = Plugin.apply_filter('comment_body_class', "comment.body",comment.freeze)
    @title_class = Plugin.apply_filter('comment_title_class', "comment.title",comment.freeze)
    @updated_at = Plugin.apply_filter('comment_updated_at', comment.updated_at,comment.freeze)
    @created_at = Plugin.apply_filter('comment_created_at', comment.created_at,comment.freeze)
    @id = Plugin.apply_filter('comment_id', comment.id,comment.freeze)
    @comments = CommentsPresenter.new(comment.comments)
  end
end
