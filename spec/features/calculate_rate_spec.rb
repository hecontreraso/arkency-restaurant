require 'rails_helper'

RSpec.feature 'get tasks rates', js: true do

  before(:each) do
    ENV['RESTAURANT_LATITUDE'] = '37.7624307'
    ENV['RESTAURANT_LONGITUDE'] = '-122.4662728'
  end

  describe 'enter a correct address' do
    it 'returns correct fee on' do
      visit '/'
      within("#delivery-index") do
        fill_in 'address', with: '750 Howard Street, San Francisco, California, Estados Unidos'
      end
      click_button "I'm hungry!!"
      expect(find('.response')).to have_content('You are currently located at 6.15 kilometers from us. You will be charged with 3 for the delivery. Enjoy!')
    end
  end

  describe 'enter an incorrect address' do
    it 'shows error message' do
      visit '/'
      within("#delivery-index") do
        fill_in 'address', with: 'incorrectincorrectincorrectincorrect'
      end
      click_button "I'm hungry!!"
      expect(find('.response')).to have_content('We are unable to find your address!')
    end
  end

end
