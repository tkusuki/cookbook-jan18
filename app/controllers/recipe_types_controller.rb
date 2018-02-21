class RecipeTypesController < ApplicationController
  def show
    id = params[:id]
    @recipe_type = RecipeType.find(id)
  end
end
