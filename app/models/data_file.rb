class DataFile < ApplicationRecord
  belongs_to :parent, class_name: "DataFile", foreign_key: :parent_id, optional: true
  has_many :converted_files, class_name: "DataFile", foreign_key: :parent_id

  def self.server_name
    "http://c10e8b52.ngrok.io"
  end

  def file_path
    Rails.root + "public/" + self.name
  end

  def images_path
    (Rails.root + ("public/data_file_" + self.id.to_s)).to_s
  end

  def convert
    # temp file
    File.open(self.file_path, "wb") { |f| f.write(self.contents) }
    Dir.mkdir self.images_path rescue 0
    Docsplit.extract_images(self.file_path, format: [:png], output: self.images_path)
    self
  end

  def web_path
    DataFile.server_name + "/data_file_" + self.id.to_s + "/"
  end

  def converted_files
    Dir.entries(self.images_path).select { |f| !File.directory? f }
  end
end
