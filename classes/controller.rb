require_relative 'view.rb'
require_relative 'scraper.rb'

class Controller
  def initialize(cookbook)
    @cookbook = cookbook
    @view = View.new
  end

  def list
    @view.display_recipes(@cookbook.all)
  end

  def create
    name = @view.ask_for_recipe_name
    description = @view.ask_for_recipe_description
    @cookbook.add_recipe(Recipe.new(name, description))
  end

  def destroy
    recipe_index = @view.ask_for_index
    @cookbook.remove_recipe(recipe_index)
  end

  def search
    scraper = Scraper.new
    ingredient = @view.ask_for_search
    difficulty = @view.ask_for_difficulty.to_i
    @view.searching_message(ingredient)
    options = scraper.search_for_recipe(ingredient, difficulty, @view)
    index = @view.which_to_import
    recipe = scraper.import(options[index])
    @cookbook.add_recipe(recipe)
    @view.importing_message(recipe.name)
  end

  def mark_done
    @view.list_done(@cookbook.all)
    index = @view.ask_for_index
    @cookbook.mark_done(index)
  end
end