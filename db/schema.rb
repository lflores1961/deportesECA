# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20161201171521) do

  create_table "asistencias", force: :cascade do |t|
    t.integer  "evento_id"
    t.integer  "player_id"
    t.string   "tipo"
    t.text     "comment"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["evento_id"], name: "index_asistencias_on_evento_id"
    t.index ["player_id"], name: "index_asistencias_on_player_id"
  end

  create_table "categorias", force: :cascade do |t|
    t.string   "nombre"
    t.datetime "limInferior"
    t.datetime "limSuperior"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "equipos", force: :cascade do |t|
    t.string   "name"
    t.integer  "categoria"
    t.string   "deporte"
    t.string   "rama"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_equipos_on_user_id"
  end

  create_table "eventos", force: :cascade do |t|
    t.date     "fecha"
    t.string   "tipoEvento"
    t.integer  "equipo_id"
    t.string   "comment"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["equipo_id", "fecha"], name: "index_eventos_on_equipo_id_and_fecha"
    t.index ["equipo_id"], name: "index_eventos_on_equipo_id"
  end

  create_table "players", force: :cascade do |t|
    t.string   "apellidoPaterno"
    t.string   "apellidoMaterno"
    t.string   "nombres"
    t.date     "fechaNacimiento"
    t.integer  "equipo_id"
    t.string   "seccion"
    t.string   "grupo"
    t.string   "genero"
    t.boolean  "beca",            default: false
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
    t.index ["apellidoPaterno", "apellidoMaterno"], name: "index_players_on_apellidoPaterno_and_apellidoMaterno"
    t.index ["equipo_id"], name: "index_players_on_equipo_id"
  end

  create_table "users", force: :cascade do |t|
    t.string   "name"
    t.string   "email"
    t.string   "phone"
    t.datetime "created_at",                        null: false
    t.datetime "updated_at",                        null: false
    t.string   "password_digest"
    t.string   "remember_digest"
    t.boolean  "admin",             default: false
    t.string   "activation_digest"
    t.boolean  "activated",         default: false
    t.datetime "activated_at"
    t.string   "reset_digest"
    t.datetime "reset_sent_at"
    t.index ["email"], name: "index_users_on_email", unique: true
  end

end
