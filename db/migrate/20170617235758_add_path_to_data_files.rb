class AddPathToDataFiles < ActiveRecord::Migration[5.1]
  def change
    add_column :data_files, :path, :text
  end
end
