class GastosEnvio < Struct.new( :nombre, :precio )
  def self.all
    gastos_envio = [] 
    File.read( "#{RAILS_ROOT}/config/gastos_envio.txt" ).split("\n").map do |line|
      gastos_envio << GastosEnvio.new( line.split(',')[0].strip, line.split(',')[1].strip.to_i )
    end
    
    return gastos_envio
  end
  
  def self.find( nombre )
    GastosEnvio.all.map do |e|
      return e  if e.nombre == nombre
    end
  end
end