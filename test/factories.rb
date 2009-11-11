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
  # f.fecha Time.now
end