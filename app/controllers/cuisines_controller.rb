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

    if @cuisine.save
      redirect_to @cuisine
      #redirect_to cuisine_path(@cuisine.id)
    else
      render :new
    end
    # redirect_to root_path
  end

  def edit
    id = params[:id]
    @cuisine = Cuisine.find(id)
  end

  def update
    id = params[:id]
    @cuisine = Cuisine.find(id)
    cuisine_params = params.require(:cuisine).permit(:name)

    if @cuisine.update(cuisine_params)
      redirect_to @cuisine
    else
      render :edit
    end
  end
end
