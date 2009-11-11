class Pedido < ActiveRecord::Base
  before_create :update_fecha
  
  validates_presence_of :usuarioNombre, :usuarioDireccion, :usuarioEmail, :usuarioPais, :usuarioCiudad, :usuarioCp
  
  # t.string   "usuarioNombre",                   :null => false
  # t.string   "usuarioDireccion"
  # t.string   "usuarioTelefono"
  # t.string   "usuarioEmail"
  # t.text     "usuarioComentario"
  # t.datetime "fecha",                                                           :null => false
  # t.string   "estado",            :limit => 50, :default => "sin estado",       :null => false
  # t.text     "lineasPedido"
  # t.integer  "gastosEnvio",                     :default => 0
  # t.integer  "total",                           :default => 0
  # t.integer  "subtotal",                        :default => 0,                  :null => false
  # t.boolean  "esBroma",
  
  def lineas_pedido_parseadas
    lineasPedidoParseadas = []
    
    return lineasPedidoParseadas  if lineasPedido.blank?
    
    for lineaPedido in lineasPedido.split(/\n/)
      logger.debug "lineaPedido: #{lineaPedido}"  
      lineasPedidoParseadas << Lineapedido.parsearLinea( lineaPedido )
    end
    lineasPedidoParseadas
  end
  
  def update_fecha
    self.fecha = Time.now
  end
  
end
