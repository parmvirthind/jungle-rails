require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Validations' do

    it 'should be valid' do
      user = User.new(first_name: "A", last_name: "B", email: "a@a.com", password: "1234")
      expect(user).to be_valid
    end

    it 'should be invalid without a first name' do
      user = User.new(last_name: "B", email: "a@a.com", password: "1234")
      expect(user).to_not be_valid
      expect(user.errors.messages[:first_name]).to include('can\'t be blank')
    end

    it 'should be invalid without a last name' do
      user = User.new(first_name: "A", email: "a@a.com", password: "1234")
      expect(user).to_not be_valid
      expect(user.errors.messages[:last_name]).to include('can\'t be blank')
    end

    it 'should be invalid without a email' do
      user = User.new(first_name: "A", last_name: "B", password: "1234")
      expect(user).to_not be_valid
      expect(user.errors.messages[:email]).to include('can\'t be blank')
    end

  end
end