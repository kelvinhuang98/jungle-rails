require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'Validations' do
    context 'given 4 correct field inputs' do
      it 'will successfully save' do
        category = Category.new(name: 'Flowers')
        product = Product.new(name: 'Peony', price: 10, quantity: 50, category: category)

        expect(product).to be_valid
      end
    end

    context 'not given a name' do
      it "gives an error saying name can't be nil" do
        category = Category.new(name: 'Flowers')
        product = Product.new(price: 10, quantity: 50, category: category)
        product.save

        expect(product.errors.full_messages).to include("Name can't be blank")
      end
    end

    context 'not given a price' do
      it "gives an error saying price can't be nil" do
        category = Category.new(name: 'Flowers')
        product = Product.new(name: 'Peony', quantity: 50, category: category)
        product.save

        expect(product.errors.full_messages).to include("Price can't be blank")
      end
    end

    context 'not given a quantity' do
      it "gives an error saying quantity can't be nil" do
        category = Category.new(name: 'Flowers')
        product = Product.new(name: 'Peony', price: 10, category: category)
        product.save

        expect(product.errors.full_messages).to include("Quantity can't be blank")
      end
    end

    context 'not given a category' do
      it "gives an error saying category can't be nil" do
        category = Category.new(name: 'Flowers')
        product = Product.new(name: 'Peony', price: 10, quantity: 50)
        product.save

        expect(product.errors.full_messages).to include("Category can't be blank")
      end
    end
  end
end
