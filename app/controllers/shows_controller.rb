class ShowsController < ApplicationController
  # GET /shows
  # GET /shows.json
  def index
    @shows = Show.all

    render json: @shows
  end

  # GET /shows/1
  # GET /shows/1.json
  def show
    @show = Show.find(params[:id])

    render json: @show
  end

  # POST /shows
  # POST /shows.json
  def create
    @show = Show.new(params[:show])

    if @show.save
      render json: @show, status: :created, location: @show
    else
      render json: @show.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /shows/1
  # PATCH/PUT /shows/1.json
  def update
    @show = Show.find(params[:id])

    if @show.update(params[:show])
      head :no_content
    else
      render json: @show.errors, status: :unprocessable_entity
    end
  end

  # DELETE /shows/1
  # DELETE /shows/1.json
  def destroy
    @show = Show.find(params[:id])
    @show.destroy

    head :no_content
  end
end
