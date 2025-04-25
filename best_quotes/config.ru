require "./config/app"

use Rack::ContentType

# use Benchmark, 10_000

run BestQuotes::App.new # Call this object for every request
