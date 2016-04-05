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
  let(:post) { FactoryGirl.build(:post) }
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

  end
  it 'should have comments' do

  end
  it 'should have a category' do

  end
  it 'should get all published posts' do

  end
  it 'should be able to be published' do

  end
  it 'should be able to be unpublished' do

  end
  it 'should get all posts by an author' do

  end
  it 'should get all posts by category path' do

  end
  it 'should get all news posts' do

  end
  it 'should get all non-news posts' do

  end
  it 'should get the properly formatted date' do

  end

end
