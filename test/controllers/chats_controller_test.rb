require 'test_helper'

class ChatsControllerTest < ActionDispatch::IntegrationTest
  def setup
    @michael = users(:michael)
    @archer = users(:archer)
    @example_group = groups(:example_group)
    @another_group = groups(:another_group)
    @one_chat = chats(:one)
    @two_chat = chats(:two)
  end

  test 'should create chat when logged in' do
    log_in_as(@michael)
    assert_difference 'Chat.count', 1 do
      post group_chats_path(@example_group), params: { chat: { text: 'Hello, world!' } }
    end
    assert_redirected_to group_path(@example_group)
    follow_redirect!
    assert_select 'div.alert-info'
  end

  test 'should not create chat when not logged in' do
    assert_no_difference 'Chat.count' do
      post group_chats_path(@example_group), params: { chat: { text: 'Hello, world!' } }
    end
    assert_redirected_to login_path
  end

  test 'should destroy chat when logged in and correct user' do
    log_in_as(@michael)
    assert_difference 'Chat.count', -1 do
      delete group_chat_path(@example_group, @one_chat)
    end
    assert_redirected_to group_path(@example_group)
    follow_redirect!
    assert_select 'div.alert-info'
  end

  test 'should not destroy chat when logged in as wrong user' do
    log_in_as(@archer)
    assert_no_difference 'Chat.count' do
      delete group_chat_path(@another_group, @one_chat)
    end
    assert_redirected_to root_url
  end
end
