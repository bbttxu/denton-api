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
			# {name: "Courtyard Stage"},
			# {name: "Roving River Stage"},
			# {name: "University of North Texas"},
			# {name: "Showcase Stage"},
			# {name: "Festival Stage"},
			# {name: "Celebration Stage"},
			# {name: "Center Stage"}
  	]
 

 		stages.each do |stage|
 			puts stage

	    venue = Venue.find_or_create_by name: stage['name']
	    venue.phone = " "
	    venue.address = " "
	    venue.save
      url = "http://www.dentonjazzfest.com/stages/#{stage[:url]}.shtml"

	    html = Nokogiri::HTML( open( url ) )

	    shows = Show.destroy_all :venue_id => venue.id


	    dates = html.css('.sbrMid .sbrLCol .content .unify').each do |h6|
	    	date = h6.text
	    
	    	h6.next_element.css('.stageListing').each do |listing|
	    		time = listing.css('.stageTime').text

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
	    		artist = artist.gsub(time, "")

	    		artist = Artist.find_or_create_by name: artist.slugify
          artist.save

          gig = Gig.new
          gig.artist_id = artist.id
          gig.show_id = show.id
          gig.position = 1
          gig.save
          

	    	end


	    end

	    puts dates

	    # html.css('.sbrMid .sbrLCol .content .unify').collect do |h6|
	    # 	h6.text
	    # end


	    # html.css("#calendar article.show").each do |gig|
	    #   date = gig.css("header").text.split("-")[0].split(",").collect{|x|x.strip}.slice(1,2).join(", ")
	    #   time = gig.css("ul.details li")[1].text.split(" ")[0]
	    #   price = gig.css("ul.details li")[0].text
	    #   source = ''
	    #   admittance = ''

	    #   doors_at = gig.css("ul.details li")[1].text.split(' ')[0]

	    #   Chronic.time_class = Time.zone
	    #   full_date = Chronic.parse("#{date}, #{time}")
	    #   show = Show.new
	    #   show.starts_at = full_date
	    #   show.doors_at = full_date
	    #   show.source = "http://rubberglovesdentontx.com/calendar/"
	    #   show.time_is_uncertain = false
	    #   show.venue_id = venue.id
	    #   show.price= price
	    #   show.save
	    #   position = 1
	    #   gig.css("div.show-text header").text.split(",").collect{|x|x.gsub(/\s+/, ' ')}.each do |band_name|
	    #     cleansed_band_name = band_name.gsub(/(.*)(p|P)resents(:?)/, '').downcase
	    #     full_name = cleansed_band_name.split(' ').collect{ | x | x.capitalize}
	    #     full_name = full_name.join( " " )
	    #     band_key = band_name.strip.downcase.gsub(/\s/,'-').gsub(/[!]/, '').gsub('.','')
	    #     # # puts full_name
	    #     artist = Artist.find_or_create_by name: full_name
	    #     artist.save

	    #     gig = Gig.new
	    #     gig.artist_id = artist.id
	    #     gig.show_id = show.id
	    #     gig.position = position
	    #     gig.save

	    #     show.gigs << gig

	    #     position += 1
	    #   end
	    # end

 		end

  end
end
