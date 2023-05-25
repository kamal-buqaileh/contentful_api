# frozen_string_literal: true

# Recipes controller
class RecipesController < ApplicationController
  def index
    @recipes = ContentfulInterface.new(page: recipe_params[:page] || 0).fetch_all_recipes
  end

  def show
    @recipe = ContentfulInterface.new.fetch_recipe(recipe_params[:id])
    flash[:error] = @recipe[:errors] if @recipe[:errors].present?
  end

  private

  def recipe_params
    params.permit(:id, :page)
  end
end
