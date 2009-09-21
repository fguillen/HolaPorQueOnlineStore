# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  def precio ( camisetaId, modeloCamiseta )
  	@camiseta = Camiseta.find( camisetaId )
  	@precio = 0
  	for modelo in @camiseta.modelos
  		if modelo.index( modeloCamiseta ) == 0
  			@precio = Modelo.new(modelo).precio
  		end
  	end
  	@precio
  end
  
   def cantidad ( camisetaId, modeloCamiseta )
  	@camiseta = Camiseta.find( camisetaId )
  	@cantidad = 0
  	for modelo in @camiseta.modelos
  		if modelo.index( modeloCamiseta ) == 0
  			@cantidad = Modelo.new(modelo).cantidad
  		end
  	end
  	@cantidad
  end
  
  def todas_las_camisetas
  	logger.debug( "helper: todas las camisetas" )
  	camisetas = Camiseta.find(:all)
  	logger.debug( "numero de camisetas:#{camisetas.length}" )
  	camisetas
  end
  
  def todas_las_categorias
	camisetas = Camiseta.find(:all)
  	categorias = Array.new
  	for camiseta in camisetas
  		if camiseta.categorias
	  		for categoria in camiseta.categorias.split(/,|\n/)
	  			categorias << categoria.strip
			end
		end
  	end
  	categorias.uniq.sort{ |k,e| k.downcase <=> e.downcase }
  end
  
  def dinero_en_carrito
  	carritos = session[:carrito]
  	total = 0
  	if carritos
  		for carrito in carritos
  			total += ( carrito.precio.to_i * carrito.cantidad.to_i )
  		end
  		total += 10 # gastos de envio
	end
	total
  end
  
  def render_categorias
    return read_menu_categorias[0..-2]
  end
  
  def render_ver_todas
    return read_menu_categorias.last
  end
  
  def read_menu_categorias
    menu_elements = []
        
    File.read( "#{RAILS_ROOT}/config/categorias.txt" ).split("\n").map do |e|
      menu_element = e.gsub("\r", '')
      menu_elements << menu_element  if !menu_element.blank?
    end
    
    return menu_elements
  end
end
