class ReviewsController < ApplicationController

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

  private

  def review_params
    params.require(:review).permit(:description, :rating)
  end 

end
