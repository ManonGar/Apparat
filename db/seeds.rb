require 'open-uri'
require 'nokogiri'
require 'faker'

Booking.destroy_all 
puts 'Destroying bookings'

Costume.destroy_all
puts 'Destroying costumes'

User.destroy_all
puts 'Destroying users'

@user0 = User.create(email: 'admin@gmail.com', password: 'admin007')
@user1 = User.create(email: 'manon@gmail.com', password: '123456')
@user2 = User.create(email: 'laure@gmail.com', password: '123456')
@user3 = User.create(email: 'sami@gmail.com', password: '123456')

url = 'https://www.costumesdepoque.net/catalogue-costumes-civils'
html_file = open(url).read
html_doc = Nokogiri::HTML(html_file)
puts 'Creating costumes'
html_doc.css('#TPASection_jsrook8y > div > div > div > div > section > div > ul > li').first(10).each do |element|
  costume = Costume.new(
    name: Faker::Music::Opera.bizet,
    description: element.search('._3RqKm > h3').text,
    price: element.search('._23ArP').text.to_i,
    category: ["Renaissance", "Antiquite & Moyen-Age", "XVIIesiecle", "XVIIIesiecle", "XIXesiecle", "XXesiecle", "Contemporain", "Uniformes"].sample)
  file = URI.open(element.search("div[style*='background-image']")[0].to_s[/(https?:\/\/.*\.(?:png|jpg))/i].delete_suffix('/'))
  costume.photos.attach(io: file, filename: 'nes.png', content_type: 'image/png')
    # photo: element.search("div[style*='background-image']")[0].to_s[/(https?:\/\/.*\.(?:png|jpg))/i])
  # puts element.search('._23ArP').text.to_i
  # puts element.search('._3RqKm > h3').text
  # p element.search("div[style*='background-image']")[0].to_s[/(https?:\/\/.*\.(?:png|jpg))/i]
  costume.user = @user0
  costume.save
end 

=begin
url = 'https://www.compagnie-du-costume.com/costumes/renaissance-xviie-siecle/'
html_file = open(url).read
html_doc = Nokogiri::HTML(html_file)
puts 'Creating costumes'
html_doc.search('.rollover-zoom').each do |element|
   costume = Costume.new(
    name: Faker::Music::Opera.bizet,
    description: element.attribute('title').to_s[/\s(.*)/i].lstrip,
    price: rand(100..1000),
    category: element.attribute('title').to_s.split.first)
    file = URI.parse(element.attribute('href').to_s[/(https?:\/\/.*\.(?:png|jpg))/i].delete_suffix('/'))
    costume.photos.attach(io: file, filename: 'costume.png', content_type: 'image/png')
    costume.user = @user0
    costume.save
end
=end

puts "#{Costume.all.length} costumes created"

=begin
puts 'Creating bookings'

Costume.all.first(5).each do |costume|
  begindate = Faker::Date.forward(days: 23)
  booking = Booking.create(beginning_date: begindate, ending_date: begindate + rand(3..7), user_id: @user1.id, costume_id: costume.id)
end

puts "#{Booking.all.length} bookings created" 
=end

puts 'Finished'
