# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

pass = 'testtest'

u = User.new(email: 'admin@admin.pl', role: 1)
u.password = pass
u.save!

%w[janek slawek szczepan wojtek].each do |name|
  u = User.new(email: "#{name}@test.pl", display_name: name.capitalize)
  u.password = pass
  u.save!
end

[
  'Carcassonne', 'Dixit', 'Rocket League', 'FIFA', 'Wsiąść do Pociągu',
  'Puerto Rico', 'Agricola', 'Dolina Kupców', 'Królestwo w Budowie',
  'SmallWorld', 'Smash Up', 'Pięć Klanów', 'Splendor', 'Sabotażysta', 'BANG!'
].each do |title|
  Title.create!(
    name: title,
    accepted: true,
    score_type: ['Rocket League', 'FIFA'].include?(title) ? 1 : 0
  )
end
