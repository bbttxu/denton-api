class VenuesController < ApplicationController
  # GET /venues
  # GET /venues.json
  def index

    latitude = params[:latitude] ||= "33.21499"
    longitude = params[:longitude] ||= "-97.132672"
    radius = params[:radius] ||= "20"
    units = params[:units] ||= "km"


    @venues = Venue.near( [latitude,longitude], radius )

    render json: @venues
  end

  # GET /venues/1
  # GET /venues/1.json
  def show
    @venue = Venue.find(params[:id])

    render json: @venue
  end

  # POST /venues
  # POST /venues.json
  def create
    @venue = Venue.new(params[:venue])

    if @venue.save
      render json: @venue, status: :created, location: @venue
    else
      render json: @venue.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /venues/1
  # PATCH/PUT /venues/1.json
  def update
    @venue = Venue.find(params[:id])

    if @venue.update(params[:venue])
      head :no_content
    else
      render json: @venue.errors, status: :unprocessable_entity
    end
  end

  # DELETE /venues/1
  # DELETE /venues/1.json
  def destroy
    @venue = Venue.find(params[:id])
    @venue.destroy

    head :no_content
  end
end
