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
end