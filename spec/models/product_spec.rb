require 'rails_helper'

RSpec.describe Product, type: :model do
  it 'has a valid factory' do
    expect(build(:product)).to be_valid
  end

  it 'is invalid without a name' do
    product = build(:product, name: nil)
    expect(product).to_not be_valid
    expect(product.errors[:name]).to include("can't be blank")
  end

  it 'is invalid without a description' do
    product = build(:product, description: nil)
    expect(product).to_not be_valid
    expect(product.errors[:description]).to include("can't be blank")
  end

  it 'is invalid without a price' do
    product = build(:product, price: nil)
    expect(product).to_not be_valid
    expect(product.errors[:price]).to include("can't be blank")
  end

  it 'is invalid with a non-numeric price' do
    product = build(:product, price: 'abc')
    expect(product).to_not be_valid
    expect(product.errors[:price]).to include("is not a number")
  end

  it 'is invalid with a negative price' do
    product = build(:product, price: -10)
    expect(product).to_not be_valid
    expect(product.errors[:price]).to include("must be greater than or equal to 0")
  end
end
