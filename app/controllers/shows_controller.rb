class ShowsController < ApplicationController

  skip_before_filter :authenticate_user!, only: [ :index, :show, :day, :today ]
  before_filter :do_caching

  def do_caching
    expires_in 5.minutes, :public => true
  end

  def index
    @shows = Show.upcoming.ordered

    render json: @shows, callback: params[:callback]
  end

  # GET /shows/1
  # GET /shows/1.json
  def show
    now = Time.zone.parse( "#{params[:id]} 2:00am" )
    tomorrow = now + 24 * 60 * 60
    @shows = Show.after(now).before(tomorrow).ordered

    render json: @shows, callback: params[:callback]
    # respond_to do |format|
    #   format.json { render json: @shows, callback: params[:callback] }
    # end
  end
end
