require 'test_helper'

class PostLikesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @post_like = post_likes(:one)
  end

  test "should get index" do
    get post_likes_url, as: :json
    assert_response :success
  end

  test "should create post_like" do
    assert_difference('PostLike.count') do
      post post_likes_url, params: { post_like: { post_id: @post_like.post_id, user_id: @post_like.user_id } }, as: :json
    end

    assert_response 201
  end

  test "should show post_like" do
    get post_like_url(@post_like), as: :json
    assert_response :success
  end

  test "should update post_like" do
    patch post_like_url(@post_like), params: { post_like: { post_id: @post_like.post_id, user_id: @post_like.user_id } }, as: :json
    assert_response 200
  end

  test "should destroy post_like" do
    assert_difference('PostLike.count', -1) do
      delete post_like_url(@post_like), as: :json
    end

    assert_response 204
  end
end
