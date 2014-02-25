class ShowsController < ApplicationController

  skip_before_filter :authenticate_user!, only: [ :index, :show, :day, :today ]
  before_filter :do_caching

  def do_caching
    expires_in 5.minutes, :public => true
  end

  # GET /shows.json
  def index
    @shows = Show.by_day
    render json: @shows.to_json, callback: params[:callback]
  end

  # GET /shows/yyyy-mm-dd.json
  def show
    now = Time.zone.parse( "#{params[:id]} 2:00am" )
    tomorrow = now + 24 * 60 * 60
    @shows = Show.after(now).before(tomorrow).ordered

    render json: @shows, callback: params[:callback]
  end
end
