require 'nokogiri'
require 'open-uri'

html_file = URI.parse("http://www.letscookfrench.com/recipes/recipe_strawberry-wine_341951.aspx").open.read
html_doc = Nokogiri::HTML(html_file)

difficulty = html_doc.css('.m_content_recette_breadcrumb').to_s.chomp
p difficulty