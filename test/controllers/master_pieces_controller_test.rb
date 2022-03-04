require "test_helper"

class MasterPiecesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get master_pieces_index_url
    assert_response :success
  end

  test "should get show" do
    get master_pieces_show_url
    assert_response :success
  end

  test "should get edit" do
    get master_pieces_edit_url
    assert_response :success
  end

  test "should get search" do
    get master_pieces_search_url
    assert_response :success
  end
end
