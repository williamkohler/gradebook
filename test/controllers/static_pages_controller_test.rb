require 'test_helper'

class StaticPagesControllerTest < ActionDispatch::IntegrationTest

  def setup
    @student = users(:student)
    @student_2 = users(:student_2)
    @teacher = users(:teacher)
    @admin = users(:admin)
    @bio = courses(:biology)
    @math = courses(:math)
  end

  test "admin should get get admin home" do
    log_in_as @admin
  end


end
