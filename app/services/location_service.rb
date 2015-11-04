class LocationService

  def self.calculate_distance(address)
    coordinates = Geocoder.coordinates(address)
    Geocoder::Calculations.distance_between(coordinates, [ENV['RESTAURANT_LATITUDE'], ENV['RESTAURANT_LONGITUDE']])
  end

	def self.calculate_rate(distance)
		case 
		when distance >= 0 && distance < 10
			return 3
		when distance >= 10 && distance < 30
			return 5
		when distance >= 30 && distance <= 40
			return 10
		else
			return nil
		end
	end

end
