class AddNameToChildren < ActiveRecord::Migration[6.0]
  def change
    add_column :children, :name, :string
  end
end
