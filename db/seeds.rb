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

Booking.destroy_all 
puts 'Destroying bookings'

Costume.destroy_all
puts 'Destroying costumes'

User.destroy_all
puts 'Destroying users'

@user1 = User.create(email: 'manon@gmail.com', password: '123456')
@user2 = User.create(email: 'laure@gmail.com', password: '123456')
@user3 = User.create(email: 'sami@gmail.com', password: '123456')

=begin url = 'https://www.costumesdepoque.net/catalogue-costumes-civils'
html_file = open(url).read
html_doc = Nokogiri::HTML(html_file)
puts 'Creating costumes'
html_doc.css('#TPASection_jsrook8y > div > div > div > div > section > div > ul > li').first(10).each do |element|
  costume = Costume.new(
    name: Faker::Music::Opera.bizet,
    description: element.search('._3RqKm > h3').text,
    price: element.search('._23ArP').text.to_i)
  file = URI.open(element.search("div[style*='background-image']")[0].to_s[/(https?:\/\/.*\.(?:png|jpg))/i])
  costume.photos.attach(io: file, filename: 'nes.png', content_type: 'image/png')
    # photo: element.search("div[style*='background-image']")[0].to_s[/(https?:\/\/.*\.(?:png|jpg))/i])
  # puts element.search('._23ArP').text.to_i
  # puts element.search('._3RqKm > h3').text
  # p element.search("div[style*='background-image']")[0].to_s[/(https?:\/\/.*\.(?:png|jpg))/i]
  costume.user = @user1
  costume.save
end 
=end

url = 'https://www.compagnie-du-costume.com/costumes/renaissance-xviie-siecle/'
html_file = open(url).read
html_doc = Nokogiri::HTML(html_file)
puts 'Creating costumes'
html_doc.search('.rollover-zoom').each do |element|
  puts element.attribute('href').value
end


=begin 
puts "#{Costume.all.length} costumes created"

puts 'Creating bookings'

Costume.all.first(5).each do |costume|
  begindate = Faker::Date.forward(days: 23)
  booking = Booking.create(beginning_date: begindate, ending_date: begindate + rand(3..7), user_id: @user1.id, costume_id: costume.id)
end

puts "#{Booking.all.length} bookings created" 

=end

# file = URI.open('https://giantbomb1.cbsistatic.com/uploads/original/9/99864/2419866-nes_console_set.png')
# article = Article.new(title: 'NES', body: "A great console")
# article.photo.attach(io: file, filename: 'nes.png', content_type: 'image/png')
# #puts Costume.all
# puts 'Finished'

# puts html_doc.css('#TPASection_jsrook8y > div > div > div > div > section > div > ul > li').first

# url = 'http://www.vertugadins.com/penderie'
# html_file = open(url).read
# html_doc = Nokogiri::HTML(html_file)

# html_doc.search('figcaption span').first(1).each do |element|
#   p element.text
# end
