class ShowsController < ApplicationController

  skip_before_filter :authenticate_user!, only: [ :index, :show, :calendar, :day]
  before_filter :do_caching

  def do_caching
    expires_in 5.minutes, :public => true
  end

  # GET /shows.json
  def index
    @shows = Show.upcoming.ordered
    render json: @shows, callback: params[:callback]
  end



  # GET /shows/calendar.json
  def calendar
    @shows = Show.upcoming.soon.by_day
    render json: @shows.to_json, callback: params[:callback]
  end

  # GET /shows/yyyy-mm-dd.json
  def day
    now = Time.zone.parse( "#{params[:date]}" ).localtime.beginning_of_day()
    tomorrow = now + 24 * 60 * 60 - 1
    @shows = Show.after(now).before(tomorrow).ordered

    render json: @shows, callback: params[:callback]
  end
end
