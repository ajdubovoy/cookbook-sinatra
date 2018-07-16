require_relative 'recipe.rb'
require "nokogiri"

class Scraper
  attr_reader :name, :description, :prep_time, :difficulty

  def intiialize
    @name = ''
    @description = ''
    @prep_time = 0
    @dificulty = 0
  end

  def search_for_recipe(ingredient, difficulty, view)
    difficulty_url = (difficulty == 0) ? '' : "&dif=#{difficulty}"
    html_file = URI.parse("http://www.letscookfrench.com/recipes/find-recipe.aspx?type=all&aqt=#{ingredient}#{difficulty_url}").open.read
    html_doc = Nokogiri::HTML(html_file)

    index = 0
    options = []
    html_doc.search('.m_titre_resultat').each do |element|
      title = element.to_s.gsub(/<[^>]*>|\n|\r/, '').strip
      link = element.to_s.strip
      link = /href=".*"/.match(link)[0].to_s.gsub(/(href="|")/, '')
      view.display_result(title, index)
      options << link
      break if index >= 4
      index +=1
    end
    return options
  end

  def import(recipe_link)
    html_file = URI.parse("http://www.letscookfrench.com/#{recipe_link}").open.read
    html_doc = Nokogiri::HTML(html_file)

    name = html_doc.search('.item').to_s.gsub(/<[^>]*>/, '').strip

    description = html_doc.search('.m_content_recette_todo').to_s.gsub(/(<[^>]*>|\n|\r)/, '').gsub(/Method :\s*/, '').strip

    prep_time = html_doc.search('.preptime')[0].to_s.gsub(/<[^>]*>/, '').strip.to_i

    difficulty_css = html_doc.css('.m_content_recette_breadcrumb').to_s
    difficulty = convert_difficulty(difficulty_css)

    return Recipe.new(name, description, prep_time, false, difficulty)
  end

  private

  def convert_difficulty(difficulty_css)
    if difficulty_css.include? "Very Easy"
      return 1
    elsif difficulty_css.include? "Easy"
      return 2
    elsif difficulty_css.include? "Moderate"
      return 3
    elsif difficulty_css.include? "Difficult"
      return 4
    else
      return 1
    end
  end
end