require 'test_helper'

class CommentLikesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @comment_like = comment_likes(:one)
  end

  test "should get index" do
    get comment_likes_url, as: :json
    assert_response :success
  end

  test "should create comment_like" do
    assert_difference('CommentLike.count') do
      post comment_likes_url, params: { comment_like: { comment_id: @comment_like.comment_id, user_id: @comment_like.user_id } }, as: :json
    end

    assert_response 201
  end

  test "should show comment_like" do
    get comment_like_url(@comment_like), as: :json
    assert_response :success
  end

  test "should update comment_like" do
    patch comment_like_url(@comment_like), params: { comment_like: { comment_id: @comment_like.comment_id, user_id: @comment_like.user_id } }, as: :json
    assert_response 200
  end

  test "should destroy comment_like" do
    assert_difference('CommentLike.count', -1) do
      delete comment_like_url(@comment_like), as: :json
    end

    assert_response 204
  end
end
