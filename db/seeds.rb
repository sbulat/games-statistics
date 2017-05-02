# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

if User.where(email: 'admin@admin.pl').first.nil?
  u = User.new(email: 'admin@admin.pl', role: 1)
  u.password = 'testtest'
  u.save!
end

%w[Alkochińczyk Alkokalambury Alko-Dixit Alkostatki].each_with_index do |title, i|
  Title.create!(name: title, accepted: i != 3)
end
