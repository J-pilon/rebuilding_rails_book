# frozen_string_literal: true

require "rulers/version"
require "rulers/routing"
require "rulers/util"
require "rulers/dependencies"
require "rulers/controller"

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

    def favicon_path?(path)
      path == "/favicon.ico"
    end

    def root_path?(path)
      path == "/"
    end
  end
end
