require "rulers"
$LOAD_PATH << File.join(__dir__, "..", "app", "controllers")
require "quotes_controller"
require "home_controller"

module BestQuotes
  class App < Rulers::App
  end
end
