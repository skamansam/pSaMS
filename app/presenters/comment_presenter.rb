class CommentPresenter
  attr_reader :body, :title, :comments, :email_string, :body_class, :title_class,
   :id, :updated_at, :created_at, :name, :email, :avatar
  def initialize(comment)
    @comment = comment
    @body = Plugin.apply_filter('comment_content', comment.body,comment.freeze)
    @title = Plugin.apply_filter('comment_title', comment.title,comment.freeze)
    @name = Plugin.apply_filter('comment_name', name_from_email(comment.email), comment.freeze)
    @avatar = Plugin.apply_filter('comment_avatar', comment.email, comment.freeze)
    @body_class = Plugin.apply_filter('comment_body_class', "comment.body",comment.freeze)
    @title_class = Plugin.apply_filter('comment_title_class', "comment.title",comment.freeze)
    @updated_at = Plugin.apply_filter('comment_updated_at', comment.updated_at.localtime, comment.freeze)
    @created_at = Plugin.apply_filter('comment_created_at', comment.created_at.localtime,comment.freeze)
    @id = Plugin.apply_filter('comment_id', comment.id,comment.freeze)
    @comments = CommentsPresenter.new(comment.comments)
  end

  # NOTE: this should be a filter plugin
  def name_from_email(email)
    email.split('@').first
  end
end
