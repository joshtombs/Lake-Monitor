class SensorsController < ApplicationController
	before_action :set_sensor, only: [:edit, :update, :destroy, :get_update_rate]
	helper_method :edit_link
	before_filter :authorize, :only => [:edit]

	def index
		@sensors = Sensors.all
	end

	def get_update_rate
		render json: {
				sensor_id: params[:id],
				update_rate: @sensor.update_rate
			}.to_json
	end

	def edit_link(id)
		"/edit_sensor/" + id.to_s
	end

	def edit
		@form_url = "/edit_sensor/" + params[:id]
	end

	def update
		respond_to do |format|
		  if @sensor.update(sensor_params)
		    format.html { redirect_to '/sensor_information', notice: 'sensor was successfully updated.' }
		    format.json { render :show, status: :ok, location: @sensor }
		  else
		    format.html { render :edit }
		    format.json { render json: @sensor.errors, status: :unprocessable_entity }
		  end
		end
	end

	private
		def set_sensor
		  @sensor = Sensors.find(params[:id])
		end

		def sensor_params
	      params.permit(:sensor_id, :sensor_type, :update_rate, :location)
	    end
end