module Rulers
  class App
    def get_cont_and_act(env)
      _, cont, act, after = env["PATH_INFO"].split("/", 4)

      cont = cont.capitalize
      cont += "Controller"
      [Object.const_get(cont), act]
    end
  end
end
