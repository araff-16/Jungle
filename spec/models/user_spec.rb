require 'rails_helper'

RSpec.describe User, type: :model do
  
  describe 'validations' do

    it "should save if password and password_authentication are the same" do
      @user = User.new
      @user.first_name = "Toby"
      @user.last_name = "Mcquire"
      @user.email = "test@test.com"
      @user.password = "test123445"
      @user.password_confirmation = "test123445"
      @user.save

      expect(@user.errors.messages).not_to be_present
    end

    it "should not save if password and password_authentication are not the same" do
      @user = User.new
      @user.first_name = "Toby"
      @user.last_name = "Mcquire"
      @user.email = "test@test.com"
      @user.password = "test123445"
      @user.password_confirmation = "test1"
      @user.save

      expect(@user.errors.messages).to be_present
    end

    it "should not save if password is nil" do
      @user = User.new
      @user.first_name = "Toby"
      @user.last_name = "Mcquire"
      @user.email = "test@test.com"
      @user.password = nil
      @user.password_confirmation = "test123445"
      @user.save

      expect(@user.errors.messages).to be_present
    end

    it "should not save if password_confirmation is nil" do
      @user = User.new
      @user.first_name = "Toby"
      @user.last_name = "Mcquire"
      @user.email = "test@test.com"
      @user.password = "test123445"
      @user.password_confirmation = nil
      @user.save

      expect(@user.errors.messages).to be_present
    end

    it "should not save if password_confirmation and password is nil" do
      @user = User.new
      @user.first_name = "Toby"
      @user.last_name = "Mcquire"
      @user.email = "test@test.com"
      @user.password = nil
      @user.password_confirmation = nil
      @user.save

      expect(@user.errors.messages).to be_present
    end

    it "should not save if first_name is nil" do
      @user = User.new
      @user.first_name = nil
      @user.last_name = "Mcquire"
      @user.email = "test@test.com"
      @user.password = "test123445"
      @user.password_confirmation = "test123445"
      @user.save

      expect(@user.errors.messages).to be_present
    end

    it "should not save if last_name is nil" do
      @user = User.new
      @user.first_name = "Toby"
      @user.last_name = nil
      @user.email = "test@test.com"
      @user.password = "test123445"
      @user.password_confirmation = "test123445"
      @user.save

      expect(@user.errors.messages).to be_present
    end

    it "should not save if email is nil" do
      @user = User.new
      @user.first_name = "Toby"
      @user.last_name = "Mcquire"
      @user.email = nil
      @user.password = "test123445"
      @user.password_confirmation = "test123445"
      @user.save

      expect(@user.errors.messages).to be_present
    end

    it "email sensitivity" do
      @user = User.new
      @user.first_name = "Toby"
      @user.last_name = "Mcquire"
      @user.email = "test@hotmail.com"
      @user.password = "test123445"
      @user.password_confirmation = "test123445"
      @user.save

      @user1 = User.new
      @user1.first_name = "BOOBY"
      @user1.last_name = "Brown"
      @user1.email = "TEST@hotmail.com"
      @user1.password = "test123445"
      @user1.password_confirmation = "test123445"
      @user1.save

      expect(@user1.errors.messages).to be_present
    end

    it "should fail if password is too short" do 
      @user = User.new
      @user.first_name = "Toby"
      @user.last_name = "Mcquire"
      @user.email = "test@hotmail.com"
      @user.password = "test"
      @user.password_confirmation = "test"
      @user.save

      expect(@user.errors.messages).to be_present
    end

  end

  describe '.authenticate_with_credentials' do
    it "should return user if email and password are correct" do 
      @user = User.new
      @user.first_name = "Toby"
      @user.last_name = "Mcquire"
      @user.email = "test@hotmail.com"
      @user.password = "testtest"
      @user.password_confirmation = "testtest"
      @user.save

      authUser = User.authenticate_with_credentials("test@hotmail.com", "testtest")

      expect(authUser).to be_present
      expect(authUser).to eq(@user)


    end

    it "should not return user if email and password are icorrect" do 
      @user = User.new
      @user.first_name = "Toby"
      @user.last_name = "Mcquire"
      @user.email = "test@hotmail.com"
      @user.password = "testtest"
      @user.password_confirmation = "testtest"
      @user.save

      authUser = User.authenticate_with_credentials("test@hotmail.com", "testtest12")
      expect(authUser).not_to be_present

      authUser1 = User.authenticate_with_credentials("test12@hotmail.com", "testtest")
      expect(authUser1).not_to be_present
      expect(authUser1).not_to eq(@user)

    end

    it "should return user if email has spaces or different charaters" do 

      @user = User.new
      @user.first_name = "Toby"
      @user.last_name = "Mcquire"
      @user.email = "test@hotmail.com"
      @user.password = "testtest"
      @user.password_confirmation = "testtest"
      @user.save

      authUser = User.authenticate_with_credentials("   test@hotmail.com  ", "testtest")
      expect(authUser).to be_present
      expect(authUser).to eq(@user)

      authUser1 = User.authenticate_with_credentials("Test@Hotmail.Com", "testtest")
      expect(authUser1).to be_present
      expect(authUser1).to eq(@user)
    end

  end



end
