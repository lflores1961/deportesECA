# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# Usuario especial NO DETERMINADO para efectos de administración
User.create!(name: "99 - NO DETERMINADO", email: "nomail@no.com", password: "0192837465",
              password_confirmation: "0192837465", admin: false, activated: true, activated_at: Time.zone.now)

User.create!(name:                   "Fernando Flores",
              email:                 "fernando.flores1961@gmail.com",
              password:              "foobar",
              password_confirmation: "foobar",
              admin:                 true,
              activated:             true,
              activated_at:          Time.zone.now)

=begin
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
=end

# Deporte INDETERMINADO para efectos administrativos
Deporte.create!(nombre: "99 - INDETERMINADO")
deportes = [ 'FUTBOL', 'HANDBALL', 'BASKETBOL', 'PORRA', 'TKD', 'SOFTBALL', 'BEISBOL', 'VOLEYBOL', 'TENIS DE MESA', 'BANDA DE GUERRA', 'NATACIÓN', 'BADMINGTON', 'GIMNASIA ARTÍSTICA', 'TOCHITO', 'AJEDRÉZ' ]
deportes.each do |dep|
  Deporte.create!(nombre: dep)
end

# Categoria no definida para efectos de administración
Categoria.create!(nombre: '99 - NO DEFINIDA', limInferior: "01/01/1900", limSuperior: "01/01/2030")

# Equipo NO DETERMINADO para efectos de administración
cat = Categoria.find_by(nombre: "99 - NO DEFINIDA")
entrenador = User.find_by(name: "99 - NO DETERMINADO")
deporte = Deporte.find_by(nombre: "99 - INDETERMINADO")
Equipo.create!(name: "99 - NO DETERMINADO", categoria: cat.id, user_id: entrenador.id,
                deporte: deporte.id, rama: "NO DEFINIDA")
