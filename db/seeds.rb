# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
Category.destroy_all

cateogry_list = [
  { name: "文字" },
  { name: "圖片" },
  { name: "影片" }
]

cateogry_list.each do |category|
  Category.create( name: category[:name])
end

puts "Category created"