class AddParentIdToDataFiles < ActiveRecord::Migration[5.1]
  def change
    add_column :data_files, :parent_id, :integer
  end
end
