require 'rails_helper'

RSpec.describe "Api::V1::Products", type: :request do
  let(:valid_attributes) {
    { name: 'Product 1', description: 'A sample product', price: 100.0 }
  }

  let(:invalid_attributes) {
    { name: nil, description: 'A sample product', price: 100.0 }
  }

  let(:valid_headers) {
    {
      "Authorization" => ActionController::HttpAuthentication::Basic.encode_credentials('admin', 'password'),
      "Content-Type" => "application/json"
    }
  }

  describe "GET /index" do
    it "returns a success response" do
      Product.create! valid_attributes
      get api_v1_products_url, headers: valid_headers
      expect(response).to be_successful
    end
  end

  describe "GET /show" do
    it "returns a success response" do
      product = Product.create! valid_attributes
      get api_v1_product_url(product), headers: valid_headers
      expect(response).to be_successful
    end

    it "returns a not found response when product does not exist" do
      get api_v1_product_url(id: 0), headers: valid_headers
      expect(response).to have_http_status(:not_found)
    end
  end

  describe "POST /create" do
    context "with valid parameters" do
      it "creates a new Product" do
        expect {
          post api_v1_products_url,
               params: { product: valid_attributes }.to_json,
               headers: valid_headers
        }.to change(Product, :count).by(1)
      end

      it "renders a JSON response with the new product" do
        post api_v1_products_url,
             params: { product: valid_attributes }.to_json,
             headers: valid_headers
        expect(response).to have_http_status(:created)
        expect(response.content_type).to include('application/json')
      end
    end

    context "with invalid parameters" do
      it "renders a JSON response with errors for the new product" do
        post api_v1_products_url,
             params: { product: invalid_attributes }.to_json,
             headers: valid_headers
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to include('application/json')
      end
    end
  end

  describe "PATCH /update" do
    context "with valid parameters" do
      let(:new_attributes) {
        { name: 'Product 2', description: 'An updated product', price: 150.0 }
      }

      it "updates the requested product" do
        product = Product.create! valid_attributes
        patch api_v1_product_url(product),
              params: { product: new_attributes }.to_json,
              headers: valid_headers
        product.reload
        expect(product.name).to eq('Product 2')
      end

      it "renders a JSON response with the product" do
        product = Product.create! valid_attributes
        patch api_v1_product_url(product),
              params: { product: valid_attributes }.to_json,
              headers: valid_headers
        expect(response).to be_successful
        expect(response.content_type).to include('application/json')
      end
    end

    context "with invalid parameters" do
      it "renders a JSON response with errors for the product" do
        product = Product.create! valid_attributes
        patch api_v1_product_url(product),
              params: { product: invalid_attributes }.to_json,
              headers: valid_headers
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to include('application/json')
      end
    end
  end

  describe "DELETE /destroy" do
    it "destroys the requested product" do
      product = Product.create! valid_attributes
      expect {
        delete api_v1_product_url(product), headers: valid_headers
      }.to change(Product, :count).by(-1)
    end

    it "returns a success response" do
      product = Product.create! valid_attributes
      delete api_v1_product_url(product), headers: valid_headers
      expect(response).to have_http_status(:ok)
    end

    it "returns a not found response when product does not exist" do
      delete api_v1_product_url(id: 0), headers: valid_headers
      expect(response).to have_http_status(:not_found)
    end
  end
end
