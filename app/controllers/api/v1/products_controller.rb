class Api::V1::ProductsController < ApplicationController
  before_action :set_product, only: %i[show update destroy]
  before_action :check_login, only: [:create]
  before_action :check_owner, only: %i[update destroy]

  def index
    render json: Product.all
  end

  def show
    render json: @product
  end

  def create
    product = current_user.products.new(product_params)

    if product.save
      render json: product, status: :created
    else
      render json: { errors: product.errors }, status: :unprocessable_entity
    end
  end

  def update
    if @product.update(product_params)
      render json: @product, status: :ok
    else
      render json: { errors: @product.errors }, status: :unprocessable_entity
    end
  end

  def destroy
    @product.destroy
    head :no_content
  end

  private

  def set_product
    @product = Product.find(params[:id])
  end

  def product_params
    params.require(:product).permit(:title, :price, :published )
  end

  def check_owner
    head :unauthorized unless @product.user == current_user
  end
end
