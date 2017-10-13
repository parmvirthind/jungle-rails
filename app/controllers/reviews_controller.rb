class ReviewsController < ApplicationController

  before_filter :authorize

  def create

    @review = Review.new(review_params)
    @product = Product.find(params[:product_id])
    @review.product = @product
    @review.user_id = current_user.id

    if @review.save
      redirect_to @product, notice: 'Review created!'
    else
      redirect_to :back
    end
  end

  def destroy
    @review = Review.find(params[:id])
    @product = Product.find(@review.product_id)
    @user = @review.user_id
    if @user == current_user.id
      @review.destroy
     redirect_to :back
    else
      redirect_to :back
    end
  end

  private

  def review_params
    params.require(:review).permit(:description, :rating)
  end 

end
