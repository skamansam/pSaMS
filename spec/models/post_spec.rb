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

require 'spec_helper'

RSpec.describe Post do
  let(:post) { FactoryGirl.create(:post) }

  it 'should have an author' do
    expect(post.account).to be_truthy
  end

  it 'should fail without a title' do
    post.title = nil
    expect(post.valid?).to eql false
  end

  it 'should fail without a body' do
    post.body = nil
    expect(post.valid?).to eql false
  end

  it 'should have tags' do
    post.tags.create(name: 'tag_one')
    expect(post.tags).not_to be_empty
  end

  it 'should have comments' do
    FactoryGirl.create(:comment, comment_for: post)
    expect(post.comments).not_to be_empty
  end

  it 'should have a category' do
    expect(post.category).not_to be_blank
  end

  it 'should get all published posts' do
    post.save
    unpublished_post = FactoryGirl.create(:unpublished_post)
    expect(Post.published.all).to include(post)
    expect(Post.published.all).not_to include(unpublished_post)
  end

  it 'should be able to be published' do
    post.update_attributes(published: true)
    expect(Post.published.all).to include(post)
  end

  it 'should be able to be unpublished' do
    post.update_attributes(published: false)
    expect(Post.published.all).not_to include(post)
  end

  it 'should get all posts by an author' do
    expect(Post.by_author(post.author)).to include(post)
  end

  it 'should get all posts by category path' do
    Category.create(name: 'test2', parent: Category.create(name: 'test1'))
    expect(Post.by_category('test1/test2')).to include(post)
  end

  it 'should get all news posts' do
    post.update_attributes(is_news: true)
    expect(Post.for_news).to include(post)
  end

  it 'should get all non-news posts' do
    post.update_attributes(is_news: false)
    expect(Post.without_news).to include(post)
  end

  it 'should get the properly formatted date' do
    date = Date.parse("1/2/1999 1:02:03")
    post.updated_at = date
    expect(Post.to_date).to eql "January 2,1999 01:02:03"
    date = Date.parse("2/3/2000 2:03:04")
    post.updated_at = nil
    post.created_at = date
    expect(Post.to_date).to eql "Febraury 3, 2000 02:03:04"
  end

end
