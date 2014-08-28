class ArtistsController < ApplicationController
  # GET /artists
  # GET /artists.json
  def index
    @artists = Artist.all

    render json: @artists
  end

  # GET /artists/1
  # GET /artists/1.json
  def show
    @artist = Artist.where({:slug=>params[:id]})

    render json: @artist
  end

  # POST /artists
  # POST /artists.json
  # def create
  #   @artist = Artist.new(params[:artist])

  #   if @artist.save
  #     render json: @artist, status: :created, location: @artist
  #   else
  #     render json: @artist.errors, status: :unprocessable_entity
  #   end
  # end

  # # PATCH/PUT /artists/1
  # # PATCH/PUT /artists/1.json
  # def update
  #   @artist = Artist.find(params[:id])

  #   if @artist.update(params[:artist])
  #     head :no_content
  #   else
  #     render json: @artist.errors, status: :unprocessable_entity
  #   end
  # end

  # # DELETE /artists/1
  # # DELETE /artists/1.json
  # def destroy
  #   @artist = Artist.find(params[:id])
  #   @artist.destroy

  #   head :no_content
  # end
end
