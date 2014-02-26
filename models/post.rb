class Post < ActiveRecord::Base
  belongs_to :account
  belongs_to :category
  validates_presence_of :title
  validates_presence_of :body
end
