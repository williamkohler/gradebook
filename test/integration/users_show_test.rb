require 'test_helper'

class UsersShowTest < ActionDispatch::IntegrationTest

  def setup
    @student = users(:student)
    # @student_2 = users(:student_2)
    @teacher = users(:teacher)
    @admin = users(:admin)
    # @bio = courses(:biology)
    # @math = courses(:math)
  end

  test 'should show admin dashboard' do
    log_in_as @admin
    assert_redirected_to @admin
    follow_redirect!
    assert_template 'users/show'
    assert_template partial: "users/_admin_dashboard"
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
