class DeliveryController < ApplicationController

	# POST /
	def calculate
		success = true
		error = 'none'
		distance = LocationService.calculate_distance(
			delivery_params[:address],
			delivery_params[:distanceType]
		)
		coordinates = Geocoder.coordinates(delivery_params[:address])

		if distance.nan?
	  	error = "incorrect_address"
			success = false
		else
			rate =  LocationService.calculate_rate(distance)
			if rate.nil?
		  	error = 'distance_exceeded'
				success = false
			end
		end
    
    respond_to do |format|
    	format.js {
    		render 'calculate',
    		locals: {
    			success: success,
    			distance: distance,
    			rate: rate,
    			error: error,
    			coordinates: coordinates
    		}
  		}
    end
	end

	private

		def delivery_params
			params.permit(:address, :distanceType)
		end
end
