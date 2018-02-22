class RecipeTypesController < ApplicationController
  def show
    id = params[:id]
    @recipe_type = RecipeType.find(id)
  end
  def new
    @recipe_type = RecipeType.new
  end

  def create

    recipe_type_name = params.require(:recipe_type).permit(:name)
    @recipe_type = RecipeType.new(recipe_type_name)

    if @recipe_type.save
      redirect_to @recipe_type
    else
      flash[:error] = "Você deve informar o nome do tipo de receita"
      render :new
    end
  end
end
