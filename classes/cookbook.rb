require 'csv'
require_relative 'recipe'

class Cookbook
  def initialize(csv_file_path)
    @csv_file_path = csv_file_path
    @repository = []
    read_csv
  end

  def all
    return @repository
  end

  CSV_OPTIONS = { col_sep: ',', force_quotes: true, quote_char: '"' }

  def add_recipe(recipe)
    @repository << recipe
    write_csv
  end

  def remove_recipe(recipe_index)
    @repository.delete_at(recipe_index)
    write_csv
  end

  def mark_done(recipe_index)
    @repository[recipe_index].done!
    write_csv
  end

  private

  def read_csv
    CSV.foreach(@csv_file_path) do |row|
      is_done = row[3] == "true"
      @repository << Recipe.new(row[0], row[1], row[2].to_i, is_done, row[4].to_i)
    end
  end

  def write_csv
    CSV.open(@csv_file_path, 'wb', CSV_OPTIONS) do |csv|
      @repository.each do |recipe|
        csv << [recipe.name, recipe.description, recipe.prep_time, recipe.done?, recipe.difficulty]
      end
    end
  end
end