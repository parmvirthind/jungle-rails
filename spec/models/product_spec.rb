require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'Validations' do

    it 'should be valid' do
      category = Category.new(name: 'a')
      product = category.products.new(name: 'A', price_cents: 200, quantity: 5)
      expect(product).to be_valid
    end

    it 'should be invalid without a name' do
      category = Category.new(name: 'b')
      product = category.products.new(price_cents: 200, quantity: 5)
      expect(product).to_not be_valid
      expect(product.errors.messages[:name]).to include('can\'t be blank')
    end

    it 'should be invalid without a price' do
      category = Category.new(name: 'c')
      product = category.products.new(name: 'B', quantity: 5)
      expect(product).to_not be_valid
      expect(product.errors.messages[:price]).to include('can\'t be blank')
    end

    it 'should be invalid without a quantity' do
      category = Category.new(name: 'd')
      product = category.products.new(name: 'C', price_cents: 200)
      expect(product).to_not be_valid
      expect(product.errors.messages[:quantity]).to include('can\'t be blank')
    end

    it 'should be invalid without a category' do
      product = Product.new(name: 'D', price_cents: 200, quantity: 5)
      expect(product).to_not be_valid
      expect(product.errors.messages[:category]).to include('can\'t be blank')
    end

  end
end
