# == Schema Information
#
# Table name: posts
#
#  id          :integer          not null, primary key
#  title       :string
#  body        :text
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  account_id  :integer
#  category_id :integer
#  path        :string
#  is_news     :boolean          default(FALSE)
#  published   :boolean          default(FALSE)
#

class Post < ActiveRecord::Base
  include ActsAsTaggableOn
  belongs_to :account
  belongs_to :category
  has_many :attachments
  has_many :comments, as: :comment_for

  validates_presence_of :title
  validates_presence_of :body
  acts_as_taggable

  before_save :apply_before_save_filters

  def self.published
    where(published: true)
  end

  def self.tag_cloud
  end

  def self.by_author(account_id)
    where account_id: account_id
  end

  def self.by_category(category_path)
    Category.find_by_path(category_path).try(:posts)
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

    cur_category.posts.published
  end

  def self.for_news
    published.where(is_news: true)
  end

  def self.without_news
    published.where(is_news: false)
  end

  def to_date
    (updated_at || created_at).to_date.to_formatted_s :rfc822
  end

  private

  def apply_before_save_filters
  end
end
