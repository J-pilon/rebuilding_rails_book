# frozen_string_literal: true

require "rulers/version"
require "rulers/routing"
require "rulers/util"
require "rulers/dependencies"
require "rulers/controller"
require "rulers/sqlite_model"
require "rulers/benchmark"

module Rulers
  class App
    def call(env)
      path_info = env["PATH_INFO"]

      if favicon_path?(path_info)
        return [404, {"Content-Type" => "text/html"}, []]
      end

      if root_path?(path_info)
        return [ 302, {"Content-Type" => "text/html", "Location" => "/quotes/a_quote"}, [] ]
      end

      begin
        klass, act = get_cont_and_act(env)
        cont = klass.new(env)
        cont.dispatch(act)
        res = cont.get_response

        raise "Invalid response" unless res

        [res.status, res.headers, [res.body].flatten]
      rescue => e
        [ 500, {"Content-Type" => "text/html"}, ["Error 500: #{e}"] ]
      end
    end

    def favicon_path?(path)
      path == "/favicon.ico"
    end

    def root_path?(path)
      path == "/"
    end

    def actionable_request?
      true
    end

    def redirect_to(path)
      if path.is_a?(Symbol)
        cont = self.class.to_s.gsub("Controller", "").downcase
        act = path.to_s
        path = "/#{cont}/#{act}"
      end

      [ 302, {"Content-Type" => "text/html", "Location" => path.to_s}, [] ]
    end
  end
end
