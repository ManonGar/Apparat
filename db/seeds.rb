require 'open-uri'
require 'nokogiri'
require 'faker'

Booking.destroy_all
puts 'Destroying bookings'

Costume.destroy_all
puts 'Destroying costumes'

User.destroy_all
puts 'Destroying users'

puts 'Creating Users'

@user1 = User.create(email: 'nastasia@gmail.com', password: '123456', first_name: 'Nastasia', last_name: 'Fourcade')
avatar1 = File.open('app/assets/images/marieantoinette.jpg')
@user1.photos.attach(io: avatar1, filename: 'avatar.png', content_type: 'image/png')

@user2 = User.create(email: 'manon@gmail.com', password: '123456', first_name: 'Manon', last_name: 'Garnier')
avatar2 = File.open('app/assets/images/jeune_femme.jpg')
@user2.photos.attach(io: avatar2, filename: 'avatar.png', content_type: 'image/png')

@user3 = User.create(email: 'laure@gmail.com', password: '123456', first_name: 'Laure', last_name: 'Curallucci de Peretti')
avatar3 = File.open('app/assets/images/femme_xix.jpg')
@user3.photos.attach(io: avatar3, filename: 'avatar.png', content_type: 'image/png')

@user4 = User.create(email: 'sami@gmail.com', password: '123456', first_name: 'Sami', last_name: 'Ziani')
avatar4 = File.open('app/assets/images/homme_xviii.jpg')
@user4.photos.attach(io: avatar4, filename: 'avatar.png', content_type: 'image/png')

puts "#{User.all.length} users created"


puts 'Creating costumes'

url = 'https://www.costumesdepoque.net/catalogue-costumes-civils'
html_file = open(url).read
html_doc = Nokogiri::HTML(html_file)
html_doc.css('#TPASection_jsrook8y > div > div > div > div > section > div > ul > li').first(10).each do |element|
  costume = Costume.new(
    name: Faker::Music::Opera.bizet,
    description: element.search('._3RqKm > h3').text,
    price: element.search('._23ArP').text.to_i,
    category: ["Renaissance", "Antiquite & Moyen-Age", "XVIIesiecle", "XVIIIesiecle", "XIXesiecle", "XXesiecle", "Contemporain", "Uniformes"].sample)
  file = URI.open(element.search("div[style*='background-image']")[0].to_s[/(https?:\/\/.*\.(?:png|jpg))/i].delete_suffix('/'))
  costume.photos.attach(io: file, filename: 'nes.png', content_type: 'image/png')
  costume.user = @user1
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

puts 'Creating bookings'

Costume.all.first(5).each do |costume|
  begindate = Faker::Date.forward(days: 23)
  booking = Booking.create(beginning_date: begindate, ending_date: begindate + rand(3..7), user_id: @user2.id, costume_id: costume.id)
end

puts "#{Booking.all.length} bookings created" 

puts 'Finished'
