class SensordataController < ApplicationController
  before_action :set_sensordata, only: [:show, :edit, :update, :destroy]
  
  helper_method :get_daily_data, :get_daily_value, :get_hourly_data, :get_hourly_value
  protect_from_forgery
  skip_before_action :verify_authenticity_token, if: :json_request?

  # GET /sensordata
  # GET /sensordata.json
  def index
    @most_recent_wind_speed = Sensordata.joins('LEFT OUTER JOIN sensors ON sensordata.sensor_id = sensors.sensor_id').select('sensordata.time_recorded, sensordata.sensor_id, sensordata.value, sensors.sensor_type as sensor_type').where("sensors.sensor_type =  'wind speed'").order(time_recorded: :desc).first
    @most_recent_wind_speed = (@most_recent_wind_speed.nil?) ? "N/A" : @most_recent_wind_speed.value
    @most_recent_wind_direction = Sensordata.joins('LEFT OUTER JOIN sensors ON sensordata.sensor_id = sensors.sensor_id').select('sensordata.time_recorded, sensordata.sensor_id, sensordata.value, sensors.sensor_type as sensor_type').where("sensors.sensor_type =  'wind direction'").order(time_recorded: :desc).first
    @most_recent_wind_direction = (@most_recent_wind_direction.nil?) ? "N/A" : @most_recent_wind_direction.value
    @most_recent_rainfall = Sensordata.joins('LEFT OUTER JOIN sensors ON sensordata.sensor_id = sensors.sensor_id').select('sensordata.time_recorded, sensordata.sensor_id, sensordata.value, sensors.sensor_type as sensor_type').where("sensors.sensor_type =  'rainfall'").order(time_recorded: :desc).first
    @most_recent_rainfall = (@most_recent_rainfall.nil?) ? "N/A" : @most_recent_rainfall.value
    @most_recent_water_level = Sensordata.joins('LEFT OUTER JOIN sensors ON sensordata.sensor_id = sensors.sensor_id').select('sensordata.time_recorded, sensordata.sensor_id, sensordata.value, sensors.sensor_type as sensor_type').where("sensors.sensor_type =  'water level'").order(time_recorded: :desc).first
    @most_recent_water_level = (@most_recent_water_level.nil?) ? "N/A" : @most_recent_water_level.value
    @most_recent_water_temp = Sensordata.joins('LEFT OUTER JOIN sensors ON sensordata.sensor_id = sensors.sensor_id').select('sensordata.time_recorded, sensordata.sensor_id, sensordata.value, sensors.sensor_type as sensor_type').where("sensors.sensor_type =  'water temp'").order(time_recorded: :desc).first
    @most_recent_water_temp = (@most_recent_water_temp.nil?) ? "N/A" : @most_recent_water_temp.value
    @most_recent_ambient_temp = Sensordata.joins('LEFT OUTER JOIN sensors ON sensordata.sensor_id = sensors.sensor_id').select('sensordata.time_recorded, sensordata.sensor_id, sensordata.value, sensors.sensor_type as sensor_type').where("sensors.sensor_type =  'ambient temp'").order(time_recorded: :desc).first
    @most_recent_ambient_temp = (@most_recent_ambient_temp.nil?) ? "N/A" : @most_recent_ambient_temp.value
    @most_recent_humidity = Sensordata.joins('LEFT OUTER JOIN sensors ON sensordata.sensor_id = sensors.sensor_id').select('sensordata.time_recorded, sensordata.sensor_id, sensordata.value, sensors.sensor_type as sensor_type').where("sensors.sensor_type =  'humidity'").order(time_recorded: :desc).first
    @most_recent_humidity = (@most_recent_humidity.nil?) ? "N/A" : @most_recent_humidity.value
    @most_recent_flow_rate = Sensordata.joins('LEFT OUTER JOIN sensors ON sensordata.sensor_id = sensors.sensor_id').select('sensordata.time_recorded, sensordata.sensor_id, sensordata.value, sensors.sensor_type as sensor_type').where("sensors.sensor_type =  'flow rate'").order(time_recorded: :desc).first
    @most_recent_flow_rate = (@most_recent_flow_rate.nil?) ? "N/A" : @most_recent_flow_rate.value

    @sensordata = Sensordata.joins('LEFT OUTER JOIN sensors ON sensordata.sensor_id = sensors.sensor_id').select('sensordata.time_recorded, sensordata.sensor_id, sensordata.value, sensors.sensor_type as sensor_type').order(time_recorded: :desc).first(10)
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
    @daily_data = Sensordata.joins('LEFT OUTER JOIN sensors ON sensordata.sensor_id = sensors.sensor_id').select('sensordata.time_recorded, sensordata.sensor_id, sensordata.value, sensors.sensor_type as sensor_type').where("MONTH(time_recorded) = ? and DAY(time_recorded) = ? and YEAR(time_recorded) = ?", d_array[0], d_array[1], d_array[2]).order(time_recorded: :desc)
  end

  def get_daily_value(date, sensor_type)
    get_daily_data(date)
    @daily_value = @daily_data.where("sensors.sensor_type =  ?", sensor_type).first
    (@daily_value.nil?) ? "N/A" : @daily_value.value
  end

  def get_hourly_data(hour)
    d_array = [Date::MONTHNAMES.index(params[:month]), params[:day], params[:year]]
    @hourly_data = Sensordata.joins('LEFT OUTER JOIN sensors ON sensordata.sensor_id = sensors.sensor_id').select('sensordata.time_recorded, sensordata.sensor_id, sensordata.value, sensors.sensor_type as sensor_type').where("MONTH(time_recorded) = ? and DAY(time_recorded) = ? and YEAR(time_recorded) = ? and TIME(time_recorded) BETWEEN ? AND ?", d_array[0], d_array[1], d_array[2], hour, (Integer(hour) + 1).to_s).order(time_recorded: :desc)
  end

  def get_hourly_value(hour, sensor_type)
    get_hourly_data(hour)
    @hourly_value = @hourly_data.where("sensors.sensor_type =  ?", sensor_type).first
    (@hourly_value.nil?) ? "N/A" : @hourly_value.value
  end

  #Get /show_previous/1
  def previous_day
    d_array = [Date::MONTHNAMES.index(params[:month]), params[:day], params[:year]]
    @month_name = params[:month]
    @day = params[:day].to_s
    @year = params[:year].to_s

    @hours = Array.new

    all_hours = Sensordata.joins('LEFT OUTER JOIN sensors ON sensordata.sensor_id = sensors.sensor_id').select('sensordata.time_recorded, sensordata.sensor_id, sensordata.value, sensors.sensor_type as sensor_type').where("MONTH(time_recorded) = ? and DAY(time_recorded) = ? and YEAR(time_recorded) = ?", d_array[0].to_s, d_array[1], d_array[2]).order(time_recorded: :desc).select("time_recorded")
    
    all_hours.each do |r|
      #Filter out dates so that only one entry in dates per calender day
      substr = r.time_recorded.strftime("%H")
      unless @hours.any? { |hour| hour.to_s.include?(substr) }
        @hours << r.time_recorded.strftime("%H")
      end
    end
    
    @hours = @hours.uniq

    @previous_link = "/previous_data/" + params[:month] + "/" + params[:year]
  end

  def previous_posts
    @range_data = Array.new
  end

  def update_posts
    @starting_date = Date.parse(params[:start_date][:year] + "-" + params[:start_date][:month] + "-" + params[:start_date][:day])
    @ending_date = Date.parse(params[:end_date][:year] + "-" + params[:end_date][:month] + "-" + params[:end_date][:day])
    @range_data = Sensordata.joins('LEFT OUTER JOIN sensors ON sensordata.sensor_id = sensors.sensor_id').where("DATE(time_recorded) >= ? and DATE(time_recorded) <= ?", @starting_date, @ending_date).select('sensordata.time_recorded, sensordata.sensor_id, sensordata.value, sensors.sensor_type as sensor_type').order(time_recorded: :desc).first(10)
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
      params.permit(:time_recorded, :sensor_id, :value)
    end
end