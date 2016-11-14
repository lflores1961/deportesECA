# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
User.create!(name:                   "Fernando Flores",
              email:                 "fernando.flores1961@gmail.com",
              password:              "foobar",
              password_confirmation: "foobar",
              admin:                 true,
              activated:             true,
              activated_at:          Time.zone.now)

40.times do |n|
  name = Faker::Name.name
  email = "example-#{n+1}@railstutorial.org"
  password = "password"
  User.create!(name:                  name,
               email:                 email,
               password:              password,
               password_confirmation: password,
               activated:             true,
               activated_at:          Time.zone.now)
end

conadeipNom = ['Infantil Menor', 'Infantil Mayor', 'Juvenil A', 'Juvenil B', 'Juvenil C', 'Primera Fuerza']
conadeipNom.each do |cate|
  nombre = cate
  limiteIn = Date.today.strftime("%d/%m/%Y")
  limiteSu = Date.today.strftime("%d/%m/%Y")
  Categoria.create!(nombre: nombre, limInferior: limiteIn, limSuperior: limiteSu)
end

users = User.order(:created_at).take(5)
cat = 0
users.each do |user|
  cat += 1
  2.times do
    name = Faker::Lorem.word
    rama = Faker::Lorem.word
    depo = Faker::Lorem.word
    user.equipos.create!(name: name, categoria: cat, deporte: depo, rama: rama)
  end
end
