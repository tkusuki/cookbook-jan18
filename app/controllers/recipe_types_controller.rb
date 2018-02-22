class RecipeTypesController < ApplicationController
  def show
    id = params[:id]
    @recipe_type = RecipeType.find(id)
  end
  def new
    @recipe_type = RecipeType.new
  end

  def create
    recipe_type_name = params[:recipe_type][:name]
    @recipe_type = RecipeType.new(name: recipe_type_name)

    @recipe_type.save
    redirect_to @recipe_type
  end
end
