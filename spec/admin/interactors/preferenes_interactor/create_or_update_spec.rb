require 'spec_helper'
RSpec.describe 'PreferencesInteractor::CreateOrUpdate' do
  context 'when creating a new preference' do
    let(:current_account) { FactoryGirl.build :admin }
    let(:params_key) { 'editor' }
    let(:params_value) { 'html' }
    let(:params_context) { 'admin.post.editor' }
    subject do
      PreferencesInteractor::CreateOrUpdate.new(
        account: current_account, key: params_key,
        value: params_value, context: params_context
      )
    end
    context 'given user, key, value, and context' do
      it 'should succeed' do
        current_account.save
        expect(subject.perform).to eql true
        expect(subject.errors).to be_blank
        expect(Preference.where(
          account: current_account, key: params_key,
          value: params_value, context: params_context
        ).size).to eql 1
      end
    end
    context 'missing required attributes' do
      it 'should not save' do
      end
    end
  end

  context 'when updating a new preference' do
  end
end
