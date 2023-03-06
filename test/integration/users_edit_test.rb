require 'test_helper'

class UsersEditTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:michael)
  end

  test 'successul edit' do
    get edit_user_path(@user)
    assert_template 'users/edit'
    name = 'Foo'
    email = 'foo@bar.com'
    patch user_path(@user), params: { user: { name: name, email: email } }
    assert_not flash.empty?
    assert_redirected_to @user
    @user.reload
    assert_equal name, @user.name
    assert_equal email, @user.email
  end

  test 'unsuccessful edit' do
    get edit_user_path(@user)
    assert_template 'users/edit'
    patch user_path(@user), params: { user: { name: '', email: 'invalidemail' } }
    assert_template 'users/edit'
  end
end
