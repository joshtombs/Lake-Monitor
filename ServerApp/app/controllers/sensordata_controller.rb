class SensordataController < ApplicationController
  before_action :set_sensordata, only: [:show, :edit, :update, :destroy]
  #before_action :get_daily_data, only: [:get_daily_wind_speed, :get_daily_wind_direction, :get_daily_rainfall, :get_daily_water_level, :get_daily_water_temp, :get_daily_ambient_temp, :get_daily_humidity, :get_daily_flow_rate]

  helper_method :get_daily_data, :get_daily_wind_speed, :get_daily_wind_direction, :get_daily_rainfall, :get_daily_water_level, :get_daily_water_temp, :get_daily_ambient_temp, :get_daily_humidity, :get_daily_flow_rate
  protect_from_forgery
  skip_before_action :verify_authenticity_token, if: :json_request?

  # GET /sensordata
  # GET /sensordata.json
  def index
    @most_recent_wind_speed = Sensordata.joins('LEFT OUTER JOIN sensors ON sensordata.sensor_id = sensors.sensor_id').select('sensordata.time_recorded, sensordata.sensor_id, sensordata.value, sensors.type as type').where("sensors.type =  'wind speed'").order(time_recorded: :desc).first
    @most_recent_wind_speed = (@most_recent_wind_speed.nil?) ? "N/A" : @most_recent_wind_speed.value
    @most_recent_wind_direction = Sensordata.joins('LEFT OUTER JOIN sensors ON sensordata.sensor_id = sensors.sensor_id').select('sensordata.time_recorded, sensordata.sensor_id, sensordata.value, sensors.type as type').where("sensors.type =  'wind direction'").order(time_recorded: :desc).first
    @most_recent_wind_direction = (@most_recent_wind_direction.nil?) ? "N/A" : @most_recent_wind_direction.value
    @most_recent_rainfall = Sensordata.joins('LEFT OUTER JOIN sensors ON sensordata.sensor_id = sensors.sensor_id').select('sensordata.time_recorded, sensordata.sensor_id, sensordata.value, sensors.type as type').where("sensors.type =  'rainfall'").order(time_recorded: :desc).first
    @most_recent_rainfall = (@most_recent_rainfall.nil?) ? "N/A" : @most_recent_rainfall.value
    @most_recent_water_level = Sensordata.joins('LEFT OUTER JOIN sensors ON sensordata.sensor_id = sensors.sensor_id').select('sensordata.time_recorded, sensordata.sensor_id, sensordata.value, sensors.type as type').where("sensors.type =  'water level'").order(time_recorded: :desc).first
    @most_recent_water_level = (@most_recent_water_level.nil?) ? "N/A" : @most_recent_water_level.value
    @most_recent_water_temp = Sensordata.joins('LEFT OUTER JOIN sensors ON sensordata.sensor_id = sensors.sensor_id').select('sensordata.time_recorded, sensordata.sensor_id, sensordata.value, sensors.type as type').where("sensors.type =  'water temp'").order(time_recorded: :desc).first
    @most_recent_water_temp = (@most_recent_water_temp.nil?) ? "N/A" : @most_recent_water_temp.value
    @most_recent_ambient_temp = Sensordata.joins('LEFT OUTER JOIN sensors ON sensordata.sensor_id = sensors.sensor_id').select('sensordata.time_recorded, sensordata.sensor_id, sensordata.value, sensors.type as type').where("sensors.type =  'ambient temp'").order(time_recorded: :desc).first
    @most_recent_ambient_temp = (@most_recent_ambient_temp.nil?) ? "N/A" : @most_recent_ambient_temp.value
    @most_recent_humidity = Sensordata.joins('LEFT OUTER JOIN sensors ON sensordata.sensor_id = sensors.sensor_id').select('sensordata.time_recorded, sensordata.sensor_id, sensordata.value, sensors.type as type').where("sensors.type =  'humidity'").order(time_recorded: :desc).first
    @most_recent_humidity = (@most_recent_humidity.nil?) ? "N/A" : @most_recent_humidity.value
    @most_recent_flow_rate = Sensordata.joins('LEFT OUTER JOIN sensors ON sensordata.sensor_id = sensors.sensor_id').select('sensordata.time_recorded, sensordata.sensor_id, sensordata.value, sensors.type as type').where("sensors.type =  'flow rate'").order(time_recorded: :desc).first
    @most_recent_flow_rate = (@most_recent_flow_rate.nil?) ? "N/A" : @most_recent_flow_rate.value

    @sensordata = Sensordata.joins('LEFT OUTER JOIN sensors ON sensordata.sensor_id = sensors.sensor_id').select('sensordata.time_recorded, sensordata.sensor_id, sensordata.value, sensors.type as type').order(time_recorded: :desc).first(10)
  end

  # GET /previous_data
  def previous
    @dates = Array.new
    Sensordata.order(time_recorded: :desc).all.each do |data|
      @dates << Date::MONTHNAMES[Integer(data.time_recorded.strftime("%m"))] + data.time_recorded.strftime(" %Y")
    end
    @dates = @dates.uniq
  end

  #GET /previous_data/November/2015
  def previous_month
    @month_name = params[:month]
    @month = Date::MONTHNAMES.index(@month_name)
    @year = Integer(params[:year])
    
    @dates = Array.new

    records = Sensordata.where("MONTH(time_recorded) = ? and YEAR(time_recorded) = ?", @month, @year).order(time_recorded: :desc).select("time_recorded")
    
    records.each do |r|
      #Filter out dates so that only one entry in dates per calender day
      substr = r.time_recorded.strftime("%F")
      unless @dates.any? { |date| date.to_s.include?(substr) }
        @dates << r.time_recorded
      end
    end
    
    @dates = @dates.uniq
  end

  def get_daily_data(date)
    d_array = [date.strftime("%m"), date.strftime("%d"), date.strftime("%Y")]
    @daily_data = Sensordata.joins('LEFT OUTER JOIN sensors ON sensordata.sensor_id = sensors.sensor_id').select('sensordata.time_recorded, sensordata.sensor_id, sensordata.value, sensors.type as type').where("MONTH(time_recorded) = ? and DAY(time_recorded) = ? and YEAR(time_recorded) = ?", d_array[0], d_array[1], d_array[2]).order(time_recorded: :desc)
  end

  def get_daily_wind_speed(date)
    get_daily_data(date)
    @daily_data.where("sensors.type =  'wind speed'").each do |r|
      puts r.value
    end
    @daily_wind_speed = @daily_data.where("sensors.type =  'wind speed'").first
    (@daily_wind_speed.nil?) ? "N/A" : @daily_wind_speed.value
  end

  def get_daily_wind_direction(date)
    get_daily_data(date)
    @daily_wind_direction = @daily_data.where("sensors.type =  'wind direction'").first
    (@daily_wind_direction.nil?) ? "N/A" : @daily_wind_direction.value
  end

  def get_daily_rainfall(date)
    get_daily_data(date)
    @daily_rainfall = @daily_data.where("sensors.type =  'rainfall'").first
    (@daily_rainfall.nil?) ? "N/A" : @daily_rainfall.value
  end

  def get_daily_water_level(date)
    get_daily_data(date)
    @daily_water_level = @daily_data.where("sensors.type =  'water level'").first
    (@daily_water_level.nil?) ? "N/A" : @daily_water_level.value
  end

  def get_daily_water_temp(date)
    get_daily_data(date)
    @daily_water_temp = @daily_data.where("sensors.type =  'water temp'").first
    (@daily_water_temp.nil?) ? "N/A" : @daily_water_temp.value
  end

  def get_daily_ambient_temp(date)
    get_daily_data(date)
    @daily_ambient_temp = @daily_data.where("sensors.type =  'ambient temp'").first
    (@daily_ambient_temp.nil?) ? "N/A" : @daily_ambient_temp.value
  end

  def get_daily_humidity(date)
    get_daily_data(date)
    @daily_humidity = @daily_data.where("sensors.type =  'humidity'").first
    (@daily_humidity.nil?) ? "N/A" : @daily_humidity.value
  end

  def get_daily_flow_rate(date)
    get_daily_data(date)
    @daily_flow_rate = @daily_data.where("sensors.type =  'flow rate'").first
    (@daily_flow_rate.nil?) ? "N/A" : @daily_flow_rate.value
  end

  #Get /show_previous/1
  def previous_day
    d_array = [Date::MONTHNAMES.index(params[:month]), params[:day], params[:year]]
    @daily_readings = Sensordata.joins('LEFT OUTER JOIN sensors ON sensordata.sensor_id = sensors.sensor_id').select('sensordata.time_recorded, sensordata.sensor_id, sensordata.value, sensors.type as type').where("MONTH(time_recorded) = ? and DAY(time_recorded) = ? and YEAR(time_recorded) = ?", d_array[0].to_s, d_array[1], d_array[2]).order(time_recorded: :desc)

    @previous_link = "/previous_data/" + params[:month] + "/" + params[:year]
  end

  # GET /sensordata/1
  # GET /sensordata/1.json
  def show
  end

  # GET /sensordata/new
  def new
    @sensordata = Sensordata.new
  end

  # GET /sensordata/1/edit
  def edit
  end

  # POST /sensordata
  # POST /sensordata.json
  def create
    @sensordata = Sensordata.new(sensordata_params)

    respond_to do |format|
      if @sensordata.save
        format.html { redirect_to @sensordata, notice: 'sensordata was successfully created.' }
        format.json { render :show, status: :created, location: @sensordata }
      else
        format.html { render :new }
        #format.json { render json: @sensordata.errors, status: :unprocessable_entity }
        render json: { errors: @sensordata.errors }, status: :unprocessable_entity
      end
    end
  end

  # PATCH/PUT /sensordata/1
  # PATCH/PUT /sensordata/1.json
  def update
    respond_to do |format|
      if @sensordata.update(sensordata_params)
        format.html { redirect_to @sensordata, notice: 'sensordata was successfully updated.' }
        format.json { render :show, status: :ok, location: @sensordata }
      else
        format.html { render :edit }
        format.json { render json: @sensordata.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /sensordata/1
  # DELETE /sensordata/1.json
  def destroy
    @sensordata.destroy
    respond_to do |format|
      format.html { redirect_to sensordata_url, notice: 'sensordata was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  protected

    def json_request?
      request.format.json?
    end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_sensordata
      @sensordata = Sensordata.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def sensordata_params
      params.permit(:time_recorded, :wind_speed, :wind_direction, :rainfall, :water_level, :water_temp, :ambient_temp, :humidity, :flow_rate)
    end
end