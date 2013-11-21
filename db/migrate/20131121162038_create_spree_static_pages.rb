class CreateSpreeStaticPages < ActiveRecord::Migration
  def change
    create_table :spree_static_pages do |t|
      t.string :name
      t.string :path
      t.string :state
      t.datetime :active_on
      t.text :content

      t.timestamps
    end
  end
end
