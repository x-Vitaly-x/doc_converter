class CreateDataFiles < ActiveRecord::Migration[5.1]
  def change
    create_table :data_files do |t|
      t.string :name
      t.binary :contents

      t.timestamps
    end
  end
end
