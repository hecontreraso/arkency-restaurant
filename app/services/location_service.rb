class LocationService

  def self.calculate_distance(address, type)
    if type == 'lineal'
	    coordinates = Geocoder.coordinates(address)
	    Geocoder::Calculations.distance_between(
	    	coordinates, [ENV['RESTAURANT_LATITUDE'],
	    	ENV['RESTAURANT_LONGITUDE']]
	  	)
	  elsif type == 'route'
	  	maps_url = 'https://maps.googleapis.com/maps/api/distancematrix/json?'
	  	origin = "origins=#{address}"
	  	encoded_uri = URI.encode("#{maps_url}origins=#{ENV['RESTAURANT_ADDRESS']}&destinations=#{address}&key=#{ENV['GOOGLE_MAPS_KEY']}")

	  	response = HTTParty.get(encoded_uri)

	  	distance_in_km = response["rows"][0]["elements"][0]["distance"]["value"]
	  	distance_in_km / 1000.0
	  end
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



# &destinations=%0A20%20Craven%20Park%2C%20London%20NW10%208TD%2C%20Reino%20Unido&key=AIzaSyBjCQYMJBzafDWbp3x9kK73-MvWEo8wwn8