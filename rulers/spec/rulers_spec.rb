# frozen_string_literal: true

class TestApp < Rulers::App
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
    body = last_response.body
    expect(last_response.ok?).to be(true)
    expect(body).to be("Hello, World!")
  end
end
