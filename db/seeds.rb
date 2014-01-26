# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
# Environment variables (ENV['...']) are set in the file config/application.yml.
# See http://railsapps.github.com/rails-environment-variables.html
require 'faker'
puts 'DEFAULT USERS'
user = User.create! :name => ENV['ADMIN_NAME'].dup, :email => ENV['ADMIN_EMAIL'].dup, :password => ENV['ADMIN_PASSWORD'].dup, :password_confirmation => ENV['ADMIN_PASSWORD'].dup
puts 'user: ' << user.name

5.times do

	name = Faker::Name.name
	email = Faker::Internet.email
	password = "haslo123"
	user = User.create! name: name, email: email, password: password, password_confirmation: password

	3.times do 
		body = Faker::Lorem.paragraphs(4..8).join(' ')
		title = Faker::Lorem.words(num=4..7).join(' ')
		created_at = rand(1.month).from_now
		p = Post.create! body: body, title: title, created_at: created_at
		user.posts << p
	end
end