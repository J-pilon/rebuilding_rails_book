module Rulers
  def self.to_underscore(s)
    s.gsub(
      /([A-Z]+)([A-Z][a-z])/,
      '\1_\2').gsub(
      /([a-z\d])([A-Z])/,
      '\1_\2').downcase
  end
end
