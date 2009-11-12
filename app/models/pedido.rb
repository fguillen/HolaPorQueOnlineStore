class Pedido < ActiveRecord::Base
  before_create :update_fecha
  
  serialize :paypal_notify_params
  serialize :paypal_complete_params
  serialize :paypal_errors
  
  STATUS = {
    :ON_SESSION       => 'On Session',
    :COMPLETED        => 'Completed',
    :NOT_NOTIFIED     => 'Not Notified by PayPal',
    :PAYPAL_ERROR     => 'PayPal Error',
    :WAIT_TRANSFER    => 'Pending confirmation of transfer'
  }
  
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
  
  def paypal_encrypted( return_url, notify_url )
    values = {
      :business       => CONFIG[:paypal_seller],
      :cmd            => '_cart',
      :upload         => 1,
      :return         => return_url,
      :invoice        => self.id,
      :notify_url     => notify_url,
      :currency_code  => 'EUR',
      :cert_id        => CONFIG[:paypal_cert_id],
      :lc             => 'US'
    }
    
    last_index = 0;
    
    self.lineas_pedido_parseadas.each_with_index do |linea, index|
      values.merge!({
        "amount_#{index+1}"       => "#{linea.precio}.00",
        "item_name_#{index+1}"    => "#{linea.camisetaNombre}, #{linea.camisetaModelo}",
        "item_number_#{index+1}"  => linea.camisetaId,
        "quantity_#{index+1}"     => linea.cantidad
      })
      
      last_index = index+1
    end
    
    values.merge!({
      "amount_#{last_index+1}"        => "#{self.gastosEnvio}.00",
      "item_name_#{last_index+1}"     => "#{self.tipoEnvio}",
      "item_number_#{last_index+1}"   => "gastos envio",
      "quantity_#{last_index+1}"      => 1
    })

    Pedido.encrypt_for_paypal(values)
  end

  PAYPAL_CERT_PEM = File.read("#{Rails.root}/certs/paypal_cert.pem")
  APP_CERT_PEM = File.read("#{Rails.root}/certs/app_cert.pem")
  APP_KEY_PEM = File.read("#{Rails.root}/certs/app_key.pem")

  def self.encrypt_for_paypal(values)
    signed = OpenSSL::PKCS7::sign(OpenSSL::X509::Certificate.new(APP_CERT_PEM), OpenSSL::PKey::RSA.new(APP_KEY_PEM, ''), values.map { |k, v| "#{k}=#{v}" }.join("\n"), [], OpenSSL::PKCS7::BINARY)
    OpenSSL::PKCS7::encrypt([OpenSSL::X509::Certificate.new(PAYPAL_CERT_PEM)], signed.to_der, OpenSSL::Cipher::Cipher::new("DES3"), OpenSSL::PKCS7::BINARY).to_s.gsub("\n", "")
  end
  
  def paypal_notificate( params )
    self.paypal_notify_params  = params
    self.paypal_status         = params[:payment_status]
    self.transaction_id        = params[:txn_id]
    
    self.paypal_errors = []
    self.paypal_errors << "status not equal: #{Pedido::STATUS[:COMPLETED]}, #{params[:payment_status]}"           if params[:payment_status] != Pedido::STATUS[:COMPLETED]  
    self.paypal_errors << "secret not equal: #{CONFIG[:paypal_secret]}, #{params[:secret]}"                       if params[:secret]         != CONFIG[:paypal_secret]  
    self.paypal_errors << "receiver_email not equal: #{CONFIG[:paypal_seller]}, #{params[:receiver_email]}"       if params[:receiver_email] != CONFIG[:paypal_seller] 
    self.paypal_errors << "mc_gross not equal: #{self.total_precio}.00, #{params[:mc_gross]}"                     if params[:mc_gross]       != "#{self.total_precio}.00"
    self.paypal_errors << "mc_currency not equal: EUR, #{params[:mc_currency]}"                                   if params[:mc_currency]    != "EUR"

    if self.paypal_errors.empty?
      self.paypal_errors  = nil
      self.purchased_at   = Time.now
      self.estado         = Pedido::STATUS[:COMPLETED]
    else
      self.estado         = Pedido::STATUS[:PAYPAL_ERROR]
    end
    
    self.save!
    
    #
    # enviar email
    #
    Notificacion.deliver_enviar_pedido( self )
  end
  
  def total_precio
    total = 0
    self.lineas_pedido_parseadas.map do |linea|
      total += linea.total
    end
    
    total += self.gastosEnvio
    
    return total
  end
  
end
