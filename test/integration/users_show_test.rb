require 'test_helper'

class UsersShowTest < ActionDispatch::IntegrationTest

  def setup
    @student = users(:student)
    @teacher = users(:teacher)
    @admin = users(:admin)
  end

  test 'admin should be redirected to courses index' do
    log_in_as @admin
    follow_redirect!
    assert_template 'courses/index'
  end

  test 'should show teacher dashboard' do
    log_in_as @teacher
    assert_redirected_to @teacher
    follow_redirect!
    assert_template 'users/show'
    assert_template partial: "users/_teacher_dashboard"
  end

  test 'should show student dashboard' do
    log_in_as @student
    assert_redirected_to @student
    follow_redirect!
    assert_template 'users/show'
    assert_template partial: "users/_student_dashboard"
  end

end
