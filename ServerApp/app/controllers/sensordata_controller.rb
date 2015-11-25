class SensordataController < ApplicationController
  before_action :set_sensordata, only: [:show, :edit, :update, :destroy, :show_previous]
  
  protect_from_forgery
  skip_before_action :verify_authenticity_token, if: :json_request?

  # GET /sensordata
  # GET /sensordata.json
  def index
    @sensordata = Sensordata.order(time_recorded: :desc).first(3)
    @recentsensordata = Sensordata.order(time_recorded: :desc).first
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
  def previous_range
    @month_name = params[:month]
    @month = Date::MONTHNAMES.index(@month_name)
    @year = Integer(params[:year])

    @records = Sensordata.where("MONTH(time_recorded) = ? and YEAR(time_recorded) = ?", @month, @year).order(time_recorded: :desc)
  end

  #Get /show_previous/1
  def show_previous
    @previous_link = "/previous_data/" + Date::MONTHNAMES[Integer(@sensordata.time_recorded.strftime("%m"))] + "/" + @sensordata.time_recorded.strftime(" %Y")
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