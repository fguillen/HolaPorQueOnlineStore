# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20091111220050) do

  create_table "camisetas", :force => true do |t|
    t.string "clave",                                :null => false
    t.string "nombre",     :default => "sin nombre"
    t.text   "texto"
    t.text   "modelos"
    t.text   "fotos"
    t.text   "categorias"
  end

  create_table "pedidos", :force => true do |t|
    t.string   "usuarioTelefono",                 :default => "sin telefono"
    t.text     "usuarioComentario"
    t.datetime "fecha",                                                       :null => false
    t.string   "estado",            :limit => 50, :default => "sin estado",   :null => false
    t.text     "lineasPedido"
    t.integer  "gastosEnvio",                     :default => 0
    t.integer  "total",                           :default => 0
    t.integer  "subtotal",                        :default => 0,              :null => false
    t.boolean  "esBroma",                         :default => false,          :null => false
    t.string   "usuarioCiudad",                                               :null => false
    t.string   "usuarioPais",                                                 :null => false
    t.string   "usuarioCp",                                                   :null => false
    t.string   "usuarioNombre",                                               :null => false
    t.string   "usuarioDireccion",                                            :null => false
    t.string   "usuarioEmail",                                                :null => false
    t.string   "tipoEnvio",                                                   :null => false
  end

end
