class CommentGravatar

  def self.info
    ["Comment Gravatar","Replaces a comment's avatar with a gravatar image using the commenter's email"]
  end

  def initialize
    logger.info "Initializing CommentGravatr"
  end

  def self.migrate ; end

  def self.setup
    Plugin.add_filter('comment_avatar', "CommentGravatar", 'new_avatar')
  end

  # generates a link to a gravatar image based on the comment's email
  def new_avatar(avatar,comment)
    gravatar_url_from_email(comment.email)
  end

  def gravatar_url_from_email(email)
    require 'digest/md5'
    hash = Digest::MD5.hexdigest(email.downcase)
    "http://www.gravatar.com/avatar/#{hash}?s=50"
  end

end
