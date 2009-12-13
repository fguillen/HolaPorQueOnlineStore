class Camiseta < ActiveRecord::Base
  
  default_scope :order => 'position asc'
  
  def lista_modelos
    #modelosCamiseta = [ Modelo.new( "Elige un modelo,0,0" ) ]
    modelosCamiseta = []
    
    return modelosCamiseta  if modelos.blank?
    
    for modeloCamiseta in modelos.split(/\n/)
      modelosCamiseta << Modelo.new( modeloCamiseta )
    end
    modelosCamiseta
  end
  
  def foto_principal
    return ''  if fotos.blank?
    return fotos.split[0]
  end
  
  def fotos_secundarias
    return ''  if fotos.blank?
    return fotos.split[1..10000] # espero que nadie ponga más de 10mil fotosfotos.split[0]
  end
  
  def precio_max
    precio_max = 0
    if self.lista_modelos
      for modelo in self.lista_modelos
        if modelo.precio.to_i > precio_max.to_i
          precio_max = modelo.precio
        end
      end
    end
    precio_max
  end
  
  def precio_min
    precio_min = 1000000 #tiene que ser mayor al mínimo
    if self.lista_modelos
      for modelo in self.lista_modelos
        logger.debug( modelo.modelo + ':' + modelo.precio )
        if modelo.precio.to_i < precio_min.to_i
          precio_min = modelo.precio
        end
      end
    end
    precio_min
  end  
end
