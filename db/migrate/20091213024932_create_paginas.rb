class CreatePaginas < ActiveRecord::Migration
  def self.up
    create_table :paginas do |t|
      t.string    :title,       :null => false
      t.text      :text,        :null => false
      t.boolean   :is_link,     :default => false
      t.integer   :position,    :default => 0

      t.timestamps
    end
  end

  def self.down
    drop_table :paginas
  end
end
