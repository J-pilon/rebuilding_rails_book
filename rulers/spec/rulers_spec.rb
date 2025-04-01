# frozen_string_literal: true

class TestController < Rulers::Controller
  def index
    "Hello World!"
  end
end

class TestApp < Rulers::App
  def get_cont_and_act(env)
    [TestController, "index"]
  end
end

RSpec.describe Rulers do
  it "has a version number" do
    expect(Rulers::VERSION).not_to be nil
  end

  def app
    TestApp.new
  end

  it "GET / responds with status ok" do
    get "/"
    expect(last_response.redirect?).to be(true)
  end

  it "GET / responds with status redirect" do
    get "/"
    expect(last_response.location).to be("/quotes/a_quote")
  end

  it "GET /favicon.ico responds with status not_found" do
    get "/favicon.ico"
    expect(last_response.not_found?).to be(true)
  end

  it "GET /quotes/a_quote" do
    get "/quotes/a_quote"
    body = last_response.body
    expect(body).to eq("Hello World!")
  end
end
