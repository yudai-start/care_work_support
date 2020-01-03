# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.create!(
  [
    {
      name:  "管理者",
      email: "admin@mail.com",
      password:  "999999",
      password_confirmation: "999999",
      role: 99
    },
    {
      email: 'aaa@mail.com',
      password: 'aaaaaa',
      password_confirmation: "aaaaaa",
      name: 'あああ',
    },
    {
      email: 'bbb@mail.com',
      password: 'bbbbbb',
      password_confirmation: "bbbbbb",
      name: 'いいい',
    }
  ]
)