require 'rails_helper'

RSpec.describe LocationService do

  describe '#calculate_distance' do
    it 'returns correct distance' do
    	ENV['RESTAURANT_LATITUDE'] = '37.7624307'
    	ENV['RESTAURANT_LONGITUDE'] = '-122.4662728'

    	distance = LocationService.calculate_distance('San Francisco, 750 Howard Street, California, Estados Unidos', 'lineal')
    	expect(distance.round(2)).to eq(6.15)
    end
  end

  describe '#calculate_rate' do
    it 'returns correct rate' do
    	expect(LocationService.calculate_rate(5)).to eq(3)
    	expect(LocationService.calculate_rate(15)).to eq(5)
    	expect(LocationService.calculate_rate(35)).to eq(10)

    	expect(LocationService.calculate_rate(-10)).to eq(nil)
    	expect(LocationService.calculate_rate(45)).to eq(nil)
    end
  end

end
