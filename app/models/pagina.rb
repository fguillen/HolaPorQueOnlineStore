class Pagina < ActiveRecord::Base
  default_scope :order => 'position asc'
  
  def to_param
    "#{self.id}-#{self.title.parameterize}"
  end
end
