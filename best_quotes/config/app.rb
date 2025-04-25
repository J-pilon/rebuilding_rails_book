require "rulers"
$LOAD_PATH << File.join(__dir__, "..", "app", "controllers")
$LOAD_PATH << File.join(__dir__, "..", "app", "models")

module BestQuotes
  class App < Rulers::App
  end
end
