require 'rails_helper'

RSpec.feature "Add to cart when Add button is clicked", type: :feature, js: true do
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
  end

  scenario "It should update cart in navbar when Add button is clicked" do
    visit root_path

    first('article.product').find_link('Add').click

    visit root_path

    expect(page).to have_content "My Cart (1)"

    save_screenshot "cart.png"

  end
end
