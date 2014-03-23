#!/usr/bin/env ruby -wKU
require 'rubygems'
require 'open-uri'
require 'nokogiri'
require 'chronic'
# require 'ri_cal'
# require 'httparty'

class Banter < Scraper
  @queue = :banter
  def self.perform()
    puts "updating banter"

    banter = Venue.find_or_create_by name: "Banter"
    banter.phone = "(940) 565-1638"
    banter.address = "219 W Oak, Denton, TX 76201-4223"
    banter.save
    shows = Show.delete_all :venue_id => banter.id




    url = "https://www.google.com/calendar/ical/dentonbanter%40gmail.com/public/basic.ics"
    response = HTTParty.get(url).response
    puts response
  	cals = Icalendar.parse(response.body)

  	cals.each do |cal|
  		cal.events.each do |event|
        # date = DateTime.parse(event.dtstart)
        if event.dtstart.future?
          show = Show.new
          show.starts_at = event.dtstart
          show.doors_at = event.dtstart
          show.source = url
          show.venue_id = banter.id
          show.time_is_uncertain = false
          show.price = "?"
          show.save

          position = 1

          event.summary.split("/").each do |band_name|
            cleansed_band_name = band_name.gsub(/(.*)(p|P)resents(:?)/, '').downcase
            full_name = cleansed_band_name.split(' ').collect{ | x | x.capitalize}
            full_name = full_name.join( " " )
            band_key = band_name.strip.downcase.gsub(/\s/,'-').gsub(/[!]/, '').gsub('.','')
            # # puts full_name
            artist = Artist.find_or_create_by name: full_name
            puts artist.name
            artist.save

            gig = Gig.new
            gig.artist_id = artist.id
            gig.show_id = show.id
            gig.position = position
            gig.save

            puts gig
            show.gigs << gig

            position += 1

          end

  				# puts "start date-time: #{event.dtstart}"
  				# puts "start date-time timezone: #{event.dtstart.icalendar_tzid}" if event.dtstart.is_a?(DateTime)
  				# puts "summary: #{event.summary}"
        end
  		end
  	end
  end
end
