require 'open-uri'
require 'nokogiri' 
namespace :import do
  desc "Import HTML page details"
  task html_info: :environment do
	html = open('https://www.latlong.net/category/cities-102-15.html')
	doc = Nokogiri::HTML(html)
	table = doc.at('table')
	table_data = []
	table.search('tr').each do |tr|
		row_data = []
		tr.search('td').each do |td|
			row_data << td.text
		end
		table_data << row_data
	end
	table_data.each do |city|
		city_details = city[0].to_s.split(",")
		city_info = City.find_or_initialize_by(name: city_details[0..-3].join(','), country: city_details[-2], state: city_details[-1], latitude: city[1], longitude: city[2])
		city_info.save
	end
	puts "Data imported successfully."
  end
end