Factory.define :camiseta do |f|
  f.sequence(:clave) { |n| "clave_#{n}"}
  f.sequence(:nombre) { |n| "nombre_#{n}" }
end

# t.string   "usuarioNombre",                   :default => "sin nombre",       :null => false
# t.string   "usuarioDireccion",                :default => "sin direcciÃ³n"
# t.string   "usuarioTelefono",                 :default => "sin telefono"
# t.string   "usuarioEmail",                    :default => "sin email"
# t.text     "usuarioComentario"
# t.datetime "fecha",                                                           :null => false
# t.string   "estado",            :limit => 50, :default => "sin estado",       :null => false
# t.text     "lineasPedido"
# t.integer  "gastosEnvio",                     :default => 0
# t.integer  "total",                           :default => 0
# t.integer  "subtotal",                        :default => 0,                  :null => false
# t.boolean  "esBroma",                         :default => false,              :null => false

Factory.define :pedido do |f|
  f.usuarioNombre "User Name"
  f.usuarioDireccion "User Address"
  f.usuarioEmail "user@user.com"
  f.usuarioCiudad "User City"
  f.usuarioCp "12345"
  f.usuarioPais "User Country"
  f.tipoEnvio "Tipo envío"
  # f.fecha Time.now
end


Factory.define :pagina do |f|
  f.title "Page title"
  f.text "Page text"
end