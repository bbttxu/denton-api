# jazzfest.rb
#!/usr/bin/env ruby -wKU
require 'rubygems'
require 'open-uri'
require 'nokogiri'
require 'chronic'

# worker to scrape data from the following venue
class JazzFest < Scraper
  @queue = :jazzfest

  def self.perform

  	stages = [
			{
				name: "Jazz Stage", 
				url: "jazzStage"
			},
      {
        name: "Courtyard Stage",
        url: "courtyardStage"
      },
      {
        name: "Roving River Stage",
        url: "rovingRiverStage"
      },
			{
        name: "University of North Texas Showcase Stage",
        url: "untShowcaseStage"
      },
			{
        name: "Festival Stage",
        url: "festivalStage"
      },
			{
        name: "Celebration Stage",
        url: "celebrationStage"
      },
			{
        name: "Center Stage",
        url: "centerStage"
      }
  	]
 

 		stages.each_with_index do |stage, index|
 			puts stage

	    venue = Venue.find_or_create_by name: stage[:name]
	    venue.phone = "940-565-0931 #{index}"
	    venue.address = "#{index} Quakertown Park, Denton TX"
	    venue.save

      venue.errors.each do |error|
        puts error
      end

      url = "http://www.dentonjazzfest.com/stages/#{stage[:url]}.shtml"

	    html = Nokogiri::HTML( open( url ) )

	    shows = Show.destroy_all :venue_id => venue.id


	    dates = html.css('.sbrMid .sbrLCol .content .unify').each do |h6|
	    	date = h6.text
	    
	    	h6.next_element.css('.stageListing').each do |listing|
	    		time = listing.css('.stageTime').text

          # Chronic.time_class = Time.zone
          full_date = Chronic.parse( [date, time].collect{|x| x.strip}.join(" ") )

          show = Show.new
          show.starts_at = full_date
          show.doors_at = full_date
          show.source = url
          show.time_is_uncertain = false
          show.venue_id = venue.id
          show.price = "FREE!!!"
          show.save

	    		artist = listing.text
	    		# artist comes back with time included, so we gsub it out
	    		artist = artist.gsub(time, "").slugify

	    		artist = Artist.find_or_create_by name: artist.deslugify
          artist.save

          gig = Gig.new
          gig.artist_id = artist.id
          gig.show_id = show.id
          gig.position = 1
          gig.save
          
	    	end
	    end
 		end
  end
end
