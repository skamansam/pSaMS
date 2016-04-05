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

# Helper methods defined here can be accessed in any controller or view in the application

PSaMs::App.helpers do
  include ActsAsTaggableOn::TagsHelper

  def account_link(account)
    return "Unknown" unless account
    link_to account.name+' '+account.surname, "/posts/author/#{account.id}", title: "See more posts by #{account.name+' '+account.surname}"
  end

  def post_tag_cloud(tags = Post.tag_counts_on(:tags), separator = " | ")
    out = []
    tag_cloud(tags, %w(cloud1 cloud2 cloud3 cloud4)) do |tag, css_class|
      out << link_to( tag.name, url_for(:posts, :tags, :tag_name=>tag.name), :class => css_class)
    end
    out.join(separator).html_safe
  end

  def post_category_cloud(counts = Category.post_counts, separator = " | ")
    return [] if counts.empty?
    out = []

    classes = %w(cloud1 cloud2 cloud3 cloud4)
    max_count = counts.values.max

    counts.each do |name,cnt|
      index = ((cnt / max_count) * (classes.size - 1))
      out << link_to(name,  url_for(:posts, :category, id: name) , class: classes[index == Float::NAN ? 0 : index.round] )
    end

    out.join(separator).html_safe
  end

end
