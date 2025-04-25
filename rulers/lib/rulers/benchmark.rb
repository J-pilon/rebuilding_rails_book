class Benchmark
  def initialize(app, runs = 100)
    @app = app
    @runs = runs
  end

  def call(env)
    t = Time.now

    result = nil
    @runs.times { result = @app.call(env)}
    t2 = Time.now - t
    STDERR.puts <<~OUTPUT
      Benchmark:
      #{@runs} runs
      #{t2.to_f} seconds total
      #{t2.to_f * 1000.0 / @runs} millisec/run
    OUTPUT

    result
  end
end
