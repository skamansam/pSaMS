# Helper methods defined here can be accessed in any controller or view in the application

PSaMs::App.helpers do
  include ActsAsTaggableOn::TagsHelper

  def account_link(account)
    return "Unknown" unless account
    link_to account.name+' '+account.surname, 'mailto:'+account.email
  end

  def post_tag_cloud(tags = Post.tag_counts_on(:tags), separator = " | ")
    out = []
    tag_cloud(tags, %w(cloud1 cloud2 cloud3 cloud4)) do |tag, css_class|
      out << link_to( tag.name, url_for(:posts, :tags, :tag_name=>tag.name), :class => css_class)
    end
    out.join(separator).html_safe
  end

end
