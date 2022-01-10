require 'rails_helper'

RSpec.describe Product, type: :model do
  
  describe 'validations' do

    before(:all) do
      @category = Category.new
      @category.name = 'testCategory'
      @category.save!
    end
   

    it 'should save if all four fields are set' do
      
      @product = Product.new
      @product.name = "Space Gloves"
      @product.price = 40000
      @product.quantity = 44
      @product.category = @category
      # we use bang here b/c we want our spec to fail if save fails (due to validations)
      # we are not testing for successful save so we have to assume it will be successful
      @product.save

      expect(@product.errors.messages).not_to be_present
      puts @product.errors.messages
    end
  

    it 'name must be present for successful save' do 
      @category = Category.new
      @category.name = 'testCategory'
      @category.save!

      @product = Product.new
      @product.name = nil
      @product.price = 40000
      @product.quantity = 44
      @product.category = @category
      @product.save

      expect(@product.errors.messages).to be_present
      puts @product.errors.messages
      
    end

    it 'price must be present for successful save' do 
      @category = Category.new
      @category.name = 'testCategory'
      @category.save!

      @product = Product.new
      @product.name = "Space Gloves"
      @product.price = nil
      @product.quantity = 44
      @product.category = @category
      @product.save

      expect(@product.errors.messages).to be_present
      puts @product.errors.messages
      
    end

    it 'quantity must be present for successful save' do 
      @category = Category.new
      @category.name = 'testCategory'
      @category.save!

      @product = Product.new
      @product.name = "Space Gloves"
      @product.price = 40000
      @product.quantity = nil
      @product.category = @category
      @product.save

      expect(@product.errors.messages).to be_present
      puts @product.errors.messages
      
    end

    it 'category must be present for successful save' do 
      @category = Category.new
      @category.name = 'testCategory'
      @category.save!

      @product = Product.new
      @product.name = "Space Gloves"
      @product.price = 40000
      @product.quantity = 44
      @product.category = nil
      @product.save

      expect(@product.errors.messages).to be_present
      puts @product.errors.messages
      
    end
  end

end
