module Api
  module V1
    class ProductsController < ApplicationController
      include ActionController::HttpAuthentication::Basic::ControllerMethods

      before_action :set_product, only: [:show, :update, :destroy]
      before_action :authenticate, only: [:create, :update, :destroy]

      def index
        @products = Product.all
        render json: @products
      end

      def show
        render json: @product
      rescue ActiveRecord::RecordNotFound
        render json: { error: 'Product not found' }, status: :not_found
      end

      def create
        @product = Product.new(product_params)
        if @product.save
          render json: @product, status: :created
        else
          render json: @product.errors, status: :unprocessable_entity
        end
      end

      def update
        if @product.update(product_params)
          render json: @product
        else
          render json: @product.errors, status: :unprocessable_entity
        end
      end

      def destroy
        @product.destroy
        render json: { message: 'Product deleted successfully' }, status: :ok
      rescue ActiveRecord::RecordNotFound
        render json: { error: 'Product not found' }, status: :not_found
      end

      private

      def set_product
        @product = Product.find(params[:id])
      end

      def product_params
        params.require(:product).permit(:name, :description, :price)
      end

      def authenticate
        authenticate_or_request_with_http_basic do |username, password|
          username == 'admin' && password == 'password' # This is usually stored in environment variables, but since this is a proof of concept it is not enforced.
        end
      end
    end
  end
end
