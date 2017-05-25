require 'roo'

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
  'SmallWorld', 'Smash Up', 'Pięć Klanów'
].each do |title|
  Title.create!(
    name: title,
    accepted: true,
    score_type: ['Rocket League', 'FIFA'].include?(title) ? 1 : 0
  )
end

fav_file = Roo::Spreadsheet.open(Rails.root.join('public', 'fav_seeds.xlsx').to_s)
sheet = fav_file.sheet(0)
(1..sheet.last_row).each do |i|
  row = sheet.row(i)
  Favorite.create!(user_id: row.first, title_id: row.last)
end

games_file = Roo::Spreadsheet.open(Rails.root.join('public', 'games_seeds.xlsx').to_s)
sheet = games_file.sheet(0)
(2..sheet.last_row).each do |i|
  row = sheet.row(i).reject(&:blank?)
  if row.length == 2
    if @game
      @game.score = @score
      @game.result = @result
      @game.additional_info = @info
      @game.played_at = Time.current - (0..24).to_a.sample.days
      @game.save!
    end

    @score = {}
    @result = {}
    @info = {}
    @game = Game.new(user_id: row.first, title_id: row.last)
  else
    @score[row[0]] = row[1] || ''
    @result[row[0]] = row[2] || ''
    @info[row[0]] = row[3] || ''
  end
end

@game.score = @score
@game.result = @result
@game.additional_info = @info
@game.played_at = Time.current - (0..24).to_a.sample.days
@game.save!
