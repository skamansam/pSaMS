class CommentsPresenter
  attr_reader :comments, :comments_class

  def initialize(comments = [])
    @comments = comments.map{ |c| CommentPresenter.new(c)}
    @comments_class = Plugin.apply_filter('comments_class','comments',comments)
  end
end
