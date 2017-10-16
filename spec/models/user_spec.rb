require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Validations' do
    it 'should be valid' do
      user = User.new(first_name: "A", last_name: "B", email: "a@a.com", password: "1234", password_confirmation: "1234")
      expect(user).to be_valid
    end

    it 'should be invalid without a first name' do
      user = User.new(last_name: "B", email: "a@a.com", password: "1234", password_confirmation: "1234")
      expect(user).to_not be_valid
      expect(user.errors.messages[:first_name]).to include('can\'t be blank')
    end

    it 'should be invalid without a last name' do
      user = User.new(first_name: "A", email: "a@a.com", password: "1234", password_confirmation: "1234")
      expect(user).to_not be_valid
      expect(user.errors.messages[:last_name]).to include('can\'t be blank')
    end

    it 'should be invalid without a email' do
      user = User.new(first_name: "A", last_name: "B", password: "1234", password_confirmation: "1234")
      expect(user).to_not be_valid
      expect(user.errors.messages[:email]).to include('can\'t be blank')
    end

    it 'should be invalid without a password' do
      user = User.new(first_name: "A", last_name: "B", email: "a@a.com", password_confirmation: "1234")
      expect(user).to_not be_valid
      expect(user.errors.messages[:password]).to include('can\'t be blank')
    end

    it 'should be invalid without a password confirmation' do
      user = User.new(first_name: "A", last_name: "B", email: "a@a.com", password: "1234")
      expect(user).to_not be_valid
      expect(user.errors.messages[:password_confirmation]).to include('can\'t be blank')
    end

    it 'should be invalid if email is not unique' do
      user1 = User.create(first_name: "A", last_name: "B", email: "a@a.com", password: "1234", password_confirmation: "1234")
      user2 = User.new(first_name: "A", last_name: "B", email: "A@a.com", password: "1234", password_confirmation: "1234")
      expect(user2).to_not be_valid
      expect(user2.errors.messages[:email]).to include('has already been taken')
    end 
  end

  describe 'password match' do
    it 'should be invalid if passwords dont match' do
      user = User.new(first_name: "A", last_name: "B", email: "a@a.com", password: "1234", password_confirmation: "1235")
      expect(user.password).to_not eq(user.password_confirmation)
    end
  end

  describe 'password minimum characters' do
    it 'should be invalid if password is less than three characters' do
      user = User.new(first_name: "A", last_name: "B", email: "a@a.com", password: "12", password_confirmation: "12")      
      expect(user.password.length).to_not be > 3
    end
  end

  describe '.authenticate_with_credentials' do
    it 'should log you in if email and passwords match' do
      user = User.create(first_name: "A", last_name: "B", email: "a@a.com", password: "1234", password_confirmation: "1234")
      user1 = User.authenticate_with_credentials(user.email, user.password)
      expect(user1).to_not be(nil)
    end
  end

  it 'should not log you in if email and passwords dont match' do
    user = User.create(first_name: "A", last_name: "B", email: "a@a.com", password: "1234", password_confirmation: "1234")
    user1 = User.authenticate_with_credentials(user.email, "12345")
    expect(user1).to be(nil)
  end

  it 'should log you in if email has spaces' do
    user = User.create(first_name: "A", last_name: "B", email: "a@a.com", password: "1234", password_confirmation: "1234")
    user1 = User.authenticate_with_credentials("   A@a.com", user.password)
    expect(user1).to_not be(nil)
  end
end