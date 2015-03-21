require 'spec_helper'
describe 'PreferencesInteractor::CreateOrUpdate' do

  context 'when creating a new preference' do
    let(:current_account){FactoryGirl.build :admin}
    let(:params_key){'editor'}
    let(:params_value){'html'}
    let(:params_context){'admin.post.editor'}
    let(:prefs_create_or_update){PreferencesInteractor::CreateOrUpdate.perform(current_account,params_key,params_value,params_context)}
    context 'given user, key, value, and context' do
      it 'should save' do
        expect{prefs_create_or_update}.to change{Preference.count}.by 1
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
