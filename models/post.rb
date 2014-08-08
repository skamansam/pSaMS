class Post < ActiveRecord::Base
  belongs_to :account
  belongs_to :category
  validates_presence_of :title
  validates_presence_of :body
  acts_as_taggable

  before_save :apply_before_save_filters

  def self.tag_cloud
  end

  # finds all posts according to category path
  # Examples:
  # <code>
  #   Post.find_by_category("Welcome to MeBlog")
  #   Post.find_by_category("Welcome to MeBlog",:tools)
  #   Post.find_by_category("Welcome to MeBlog","tools")
  # </code>
  def self.find_all_by_category(*path)
    path = path.map(&:to_s)
    cur_category = Category.find_by_name(path[0])
    path[1..-1].each do |s|
      cur_category = Category.find_by_name(s) unless cur_category.nil
    end if path.size > 1
        
    return cur_category.posts
  end

  def self.for_news
    where(is_news: true)
  end

  def self.without_news
    where(is_news: false)
  end

  def to_date
    (self.updated_at || self.created_at).to_date.to_formatted_s :rfc822
  end

end
