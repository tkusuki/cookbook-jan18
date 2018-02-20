class CuisinesController < ApplicationController
  def show
    id = params[:id]
    @cuisine = Cuisine.find(id)
  end

  def new
    @cuisine = Cuisine.new
  end

  def create
    cuisine_params = params.require(:cuisine).permit(:name)
    @cuisine = Cuisine.new(cuisine_params)

    if @cuisine.valid?
      @cuisine.save
      redirect_to cuisine_path(@cuisine.id)
    else
      render :new
    end
    # redirect_to root_path
  end
end
