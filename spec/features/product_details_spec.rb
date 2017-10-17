require 'rails_helper'

RSpec.feature "Users can navigate to product details page", type: :feature, js: true  do
  
  before :each do
    @category = Category.create! name: 'Apparel'

    10.times do |n|
      @category.products.create!(
        name:  Faker::Hipster.sentence(3),
        description: Faker::Hipster.paragraph(4),
        image: open_asset('apparel1.jpg'),
        quantity: 10,
        price: 64.99
      )
    end

    @user = User.create!(
      first_name: "Bugle",
      last_name: "Jones",
      email: "bugle@jones.com",
      password: "123456",
      password_confirmation: "123456",
    )
  end

  scenario "They see all product details" do
    visit root_path

    first('article.product').find_link('Details').click

    expect(page).to have_content "Name", "Description"

  end

end
