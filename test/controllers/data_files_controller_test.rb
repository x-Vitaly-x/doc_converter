require 'test_helper'

class DataFilesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get data_files_index_url
    assert_response :success
  end

  test "should get create" do
    get data_files_create_url
    assert_response :success
  end

end
