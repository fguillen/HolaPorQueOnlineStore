class Modelo
  def initialize( modeloCamiseta )
    @modelo = modeloCamiseta.split(/,/)[0].strip 
    @cantidad = modeloCamiseta.split(/,/)[1].strip 
    @precio = modeloCamiseta.split(/,/)[2].strip
  end
  
  
  def modelo
    @modelo
  end
  
  def cantidad
    @cantidad
  end
  
  def precio
    @precio
  end
end
