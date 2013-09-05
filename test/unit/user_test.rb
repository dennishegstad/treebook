require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test "a user should enter a first name" do 
  	user = User.new
  	assert !user.save
  	assert !user.errors[:first_name].empty?
  end

  test "a user should enter a last name" do 
  	user = User.new
  	assert !user.save
  	assert !user.errors[:last_name].empty?
  end

  test "a user should enter a profile name" do 
  	user = User.new
  	assert !user.save
  	assert !user.errors[:profile_name].empty?
  end

  test "a user should have a unique profile name" do
  	user = User.new
  	user.email = "dennishegstad@gmail.com"
  	user.profile_name = users(:dennish).profile_name
  
  	assert !user.save
  	assert !user.errors[:profile_name].empty?
  end

  test "a user should have a profile name without space" do
  	user = User.new(first_name: 'dennis', last_name: 'hegstad', email: 'dennis2@testing.com')
    user.password = user.password_confirmation = 'letmein123'
    
  	user.profile_name = "My Profile With Spaces"

  	assert !user.save
  	assert user.errors[:profle_name].empty?
  	assert user.errors[:profile_name].include?("Must be formatted correctly.")
  end

  test "a user can have a correctly formatted profile name" do
    user = User.new(first_name: 'dennis', last_name: 'hegstad', email: 'dennis2@testing.com')
    user.password = user.password_confirmation = 'letmein123'

    user.profile_name = 'dennisheg'
    assert user.valid?
  end
end
