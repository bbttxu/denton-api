class GigsController < ApplicationController
  # GET /gigs
  # GET /gigs.json
  def index
    @gigs = Gig.all

    render json: @gigs
  end

  # GET /gigs/1
  # GET /gigs/1.json
  def show
    @gig = Gig.find(params[:id])

    render json: @gig
  end

  # POST /gigs
  # POST /gigs.json
  def create
    @gig = Gig.new(params[:gig])

    if @gig.save
      render json: @gig, status: :created, location: @gig
    else
      render json: @gig.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /gigs/1
  # PATCH/PUT /gigs/1.json
  def update
    @gig = Gig.find(params[:id])

    if @gig.update(params[:gig])
      head :no_content
    else
      render json: @gig.errors, status: :unprocessable_entity
    end
  end

  # DELETE /gigs/1
  # DELETE /gigs/1.json
  def destroy
    @gig = Gig.find(params[:id])
    @gig.destroy

    head :no_content
  end
end
