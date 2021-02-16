# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'open-uri'
require 'nokogiri'
require 'faker'

# #Costume.destroy_all
# puts 'Cleaning database'
# sleep(2)

# url = 'https://www.costumesdepoque.net/catalogue-costumes-civils'
# html_file = open(url).read
# html_doc = Nokogiri::HTML(html_file)

html_doc.css('#TPASection_jsrook8y > div > div > div > div > section > div > ul > li').first(3).each do |element|
  costume = Costume.new(
    name: Faker::Coffee.blend_name,
    description: element.search('._3RqKm > h3').text,
    price: element.search('._23ArP').text.to_i,
    photo: element.search("div[style*='background-image']")[0].to_s[/(https?:\/\/.*\.(?:png|jpg))/i])
  puts element.search('._23ArP').text.to_i
  puts element.search('._3RqKm > h3').text
  p element.search("div[style*='background-image']")[0].to_s[/(https?:\/\/.*\.(?:png|jpg))/i]
  costume.save
end

# #puts Costume.all
# puts 'Finished'

# puts html_doc.css('#TPASection_jsrook8y > div > div > div > div > section > div > ul > li').first

url = 'http://www.vertugadins.com/penderie'
html_file = open(url).read
html_doc = Nokogiri::HTML(html_file)

html_doc.search('figcaption span').first(1).each do |element|
  p element.text
end
