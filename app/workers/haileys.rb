#!/usr/bin/env ruby -wKU
require 'rubygems'
require 'open-uri'
require 'nokogiri'
require 'chronic'

# worker to scrape data from the following venue
class Haileys < Scraper
  @queue = :haileys

  @shows_urls = "http://smokingmouse.com/haileys/special-events/"

  def self.site
    open( @shows_urls )
  end

  def self.shows
    doc = Nokogiri::HTML(site())
    doc.css("li.gig")
  end

  def self.parseSource(show)
    {
      source: [@shows_urls, show.attr("id")].join('#')
    }
  end

  def self.parseStartsAt(show)
    attribute = show.css('time.datetime').attr('datetime').text
    datetime = attribute.split("T")
    starts_at = Chronic.parse( [datetime[0], datetime[1]].join(" ") ).localtime
    time_is_uncertain = datetime[1].length <= 1 ? true : false
    {
      starts_at: starts_at,
      time_is_uncertain: time_is_uncertain
    }
  end

  def self.parsePrice(show)
    prices = show.css('.entry p')
    prices = prices.collect {|price| price.inner_text }
    # prices = prices.map {|price| price.text}
    prices = prices.select do |price|
      price && price.include?("$")
    end

    price = prices[0] ? prices[0] : "???"
    {
      price: price
    }
  end

  def self.perform()
    puts "updating Hailey's"

    haileys = Venue.find_or_create_by name: "Hailey's Club"
    haileys.phone = "(940) 323-1159"
    haileys.address = "122 Mulberry Street, Denton, TX"
    haileys.save


    html = Nokogiri::HTML( open( 'http://haileysclub.com/contact/' ) )
    shows = Show.destroy_all :venue_id => haileys.id


    shows().each do |showHTML|
      show = {}
      show = show.merge parseSource(showHTML)
      show = show.merge parseStartsAt(showHTML)
      show = show.merge parsePrice(showHTML)
      puts show
    end


    # doc.css("div.show").each do |show|
    #   bands = show.css('div.band')
    #   show_title = show.css('div.show-title')

    #   # puts bands.text
    #   # puts show_title.text

    #   if (bands.text() == "")
    #     bands = show_title
    #   end

    #   # puts bands.text

    #   time = show.at_css('ul.event-info li:first')
    #   event_info = show.css('ul.event-info li')
    #   price = Nokogiri::HTML( event_info[1].to_s ).text

    #   unless time.nil?
    #     time = time ? time.text : 'Doors at 1:23PM,'
    #     time.gsub!('Doors at','').gsub!(',','')
    #   end

    #   date = show.at_css('span.date-display-single')
    #   date = date ? date.text.split('-')[1] : '12.12'
    #   date.gsub!('.','/')
    #   parts = date.split('/')
    #   month = parts[0]
    #   month = Date::MONTHNAMES[month.to_i]
    #   date_of_month = parts[1]
    #   date = month + " " + date_of_month
    #   time = show.css('ul.event-info li:first').text.gsub("Doors at", "")
    #   doors_at = time

    #   # Chronic.time_class = Time.zone
    #   doors_at = Chronic.parse(date.to_s + ", " + time.to_s)

    #   show = Show.new
    #   show.source = shows_url.to_s
    #   show.time_is_uncertain = false

    #   show.doors_at = doors_at
    #   show.starts_at = doors_at.localtime
    #   show.venue_id = haileys.id
    #   show.save

    #   position = 0
    #   bands.each do | band |
    #     band_name = Nokogiri::HTML( band.to_s ).text

    #     puts band_name

    #     cleansed_band_name = band_name.downcase

    #     position += 1
    #     full_name = cleansed_band_name.split(' ').collect{ | x | x.capitalize}
    #     full_name = full_name.join( " " )

    #     artist = Artist.find_or_create_by name: full_name
    #     artist.save

    #     gig = Gig.new
    #     gig.artist_id = artist.id
    #     gig.show_id = show.id
    #     gig.position = position
    #     gig.save
    #     show.gigs << gig
    #   end
    #   show.save

    #   puts show
    # end


  end
end
