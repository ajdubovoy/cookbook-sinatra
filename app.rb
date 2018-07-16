require "sinatra"
require "sinatra/reloader" if development?
require "pry-byebug"
require "better_errors"
require "rubygems"
require "open-uri"

configure :development do
  use BetterErrors::Middleware
  BetterErrors.application_root = File.expand_path('..', __FILE__)
end

require_relative 'classes/cookbook'
require_relative 'classes/controller'
require_relative 'classes/view'

csv_file   = File.join(__dir__, 'classes/recipes.csv')
cookbook   = Cookbook.new(csv_file)
controller = Controller.new(cookbook)

get '/' do
  erb :index
  @cookbook = cookbook
end