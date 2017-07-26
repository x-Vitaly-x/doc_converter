class DataFilesController < ApplicationController
  protect_from_forgery except: [:index, :create]

  def index
    render json: {docs: DataFile.all.collect { |df| {
      id: df.id,
      name: df.name,
      original: DataFile.server_name + "/data_files/" + df.id.to_s,
      converted_files: df.converted_files.collect { |f| df.web_path + f }
    } }}
  end

  def create
    df = DataFile.create(name: params[:data_file].original_filename, contents: params[:data_file].read)
    df.convert
    #redirect_to "/data_files/" + df.id.to_s + "/converted"
    render json: {
      id: df.id,
      name: df.name,
      original: DataFile.server_name + "/data_files/" + df.id.to_s,
      converted_files: df.converted_files.collect { |f| df.web_path + f }
    }
  end

  def show
    df = DataFile.find(params[:id])
    send_data df.contents, filename: df.name, disposition: :inline
  end

  def destroy
    df = DataFile.find(params[:data_file_id])
    df.destroy!
    render json: {ok: "ok"}
  end

  def converted
    df = DataFile.find(params[:data_file_id])
    render json: {
      id: df.id,
      name: df.name,
      original: DataFile.server_name + "/data_files/" + df.id.to_s,
      converted_files: df.converted_files.collect { |f| df.web_path + f }
    }
  end
end
