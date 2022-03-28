# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

users = [
  {name: 'one', email: 'one@one', password: 'koizumi'},
  {name: 'two', email: 'two@two', password: 'koizumi'},
  {name: 'three', email: 'three@three', password: 'koizumi'},
  {name: 'four', email: 'four@four', password: 'koizumi'},
  {name: 'five', email: 'five@five', password: 'koizumi'},
  {name: 'six', email: 'six@six', password: 'koizumi'}
]

users.each do |user|
  user_data = User.find_by(email: user[:email])
  if user_data.nil?
    User.create(
      name: user[:name],
      email: user[:email],
      password: user[:password]
    )
  end
end