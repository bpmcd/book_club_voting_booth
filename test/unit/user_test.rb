require 'test_helper'

class UserTest < ActiveSupport::TestCase
  
  test "brian is an admin" do
    brian = User.new
    brian.email= 'brian_mcdevitt@cargill.com'
    assert brian.is_admin?, "#{brian.email} should be an admin"
    brian.email= 'brian_mcdevitt@cargill.com'.upcase
    assert brian.is_admin?, "#{brian.email} should be an admin"
  end

  test "bob is not an admin" do
    bob = User.new
    bob.email = 'bob_mcdevitt@cargill.com'
    refute bob.is_admin?, "#{bob.email} should not be an admin"
    bob.email = 'bob_mcdevitt@cargill.com'.upcase
    refute bob.is_admin?, "#{bob.email} should not be an admin"
  end
end
