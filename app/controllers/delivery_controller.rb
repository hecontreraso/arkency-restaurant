class DeliveryController < ApplicationController

	# POST /
	def calculate
		success = true
		error = 'none'
		distance = LocationService.calculate_distance(delivery_params[:address])
		coordinates = Geocoder.coordinates(delivery_params[:address])

		if distance.nan?
	  	error = "We are unable to find your address!"
			success = false
		else
			rate =  LocationService.calculate_rate(distance)
			if rate.nil?
		  	error = 'You are too far away from us!'
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
			params.permit(:address)
		end
end
