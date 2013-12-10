class ChangeContentToText < ActiveRecord::Migration
  def change
    rename_column :spree_static_pages, :content, :text
  end
end
