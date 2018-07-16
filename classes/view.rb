require_relative 'recipe'

class View
  def display_recipes(recipes)
    recipes.each_with_index do |recipe, index|
      checkmark = recipe.done? ? "[X]" : "[ ]"
      puts "- #{index + 1} #{checkmark} #{recipe.name} (#{recipe.prep_time} min & #{recipe.how_difficult?}): #{recipe.description}"
    end
  end

  def ask_for_recipe_name
    puts "What's the name of the recipe?"
    return gets.chomp
  end

  def ask_for_recipe_description
    puts "What's the description of the recipe?"
    return gets.chomp
  end

  def ask_for_index
    puts "Which recipe? (number)"
    return gets.chomp.to_i - 1
  end

  def confirmation_destroy_message
    puts "The recipe has been destroyed"
  end

  def ask_for_search
    puts "What ingredient would you like a recipe for?"
    return gets.chomp
  end

  def ask_for_difficulty
    puts "What difficulty level? (0 for all or 1-4 for easy-hard)"
    return gets.chomp.to_i
  end

  def searching_message(ingredient)
    puts "Looking for \"#{ingredient}\" on LetsCookFrench..."
  end

  def display_result(title, index)
    puts "#{index + 1}. #{title}"
  end

  def which_to_import
    puts "Which recipe would you like to import? (enter index)"
    input = gets.chomp.to_i - 1
  end

  def importing_message(title)
    puts "Importing \"#{title}\"..."
  end

  def list_done(recipes)
    recipes.each_with_index do |recipe, index|
      checkmark = recipe.done? ? "[X]" : "[ ]"
      puts "- #{index + 1} #{checkmark} #{recipe.name} (#{recipe.prep_time}"
    end
  end
end