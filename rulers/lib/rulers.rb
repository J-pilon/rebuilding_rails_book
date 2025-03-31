# frozen_string_literal: true

require_relative "rulers/version"
# require "rulers/routing"
require "rulers/array"

module Rulers
  class App
    def call(env)
      path_info = env["PATH_INFO"]

      if favicon_path?(path_info)
        return [404, {"Content-Type": "text/html"}, []]
      end

      if root_path?(path_info)
        return [ 302, {"Content-Type" => "text/html", "Location" => "/quotes/a_quote"}, [] ]
      end

      begin
        klass, act = get_cont_and_act(env)
        cont = klass.new(env)
        text = cont.send(act)
        [ 200, {"Content-Type" => "text/html"}, [text] ]
      rescue => e
        [500, {"Content-Type" => "text/html"}, ["Error 500: #{e}"]]
      end
    end

    def get_cont_and_act(env)
      _, cont, act, after = env["PATH_INFO"].split("/", 4)

      cont = cont.capitalize
      cont += "Controller"
      [Object.const_get(cont), act]
    end

    def favicon_path?(path)
      path == "/favicon.ico"
    end

    def root_path?(path)
      path == "/"
    end
  end

  class Controller
    def initialize(env)
      @env = env
    end

    def env
      @env
    end
  end
end
