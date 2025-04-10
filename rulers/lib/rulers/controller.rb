require "erubis"
require "rulers/file_model"

module Rulers
  class Controller
    include Rulers::Model

    def initialize(env)
      @env = env
      @rendered = false
    end

    def env
      @env
    end

    def request
      @request ||= Rack::Request.new(env)
    end

    def params
      request.params
    end

    def response(text, status = 200, headers = {})
      raise "Already responded!" if @response

      headers["Content-Type"] = "text/html"
      a = [text].flatten
      @response = Rack::Response.new(a, status, headers)
    end

    def get_response
      @response
    end

    def render(view_name, locals = {}, b = binding())      @rendered = true
      response(render_view(view_name, locals))
    end

    def render_view(view_name, locals = {})
      filename = File.join("app", "views", controller_name, "#{view_name}.html.erb")
      template = File.read(filename)
      eruby = Erubis::Eruby.new(template)
      eruby.result(locals.merge(:env => env))
    end

    def dispatch(action_name)
      result = send(action_name)

      unless @rendered
        render(action_name.to_s)
      else
        result
      end
    end

    def default_view_name
      "#{self.class.name.sub("Controller", "").downcase}/#{caller_locations(2,1)[0].label}"
    end

    def controller_name
      klass = self.class
      klass = klass.to_s.gsub(/Controller$/, "")
      Rulers.to_underscore(klass)
    end
  end
end
