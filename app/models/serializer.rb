module JsonSerializer
  Oj.default_options = {:mode => :compat}
  def self.serialize(content)
    Oj.dump(content)
  end
end

module XmlSerializer
  def self.serialize(content)
    content.to_xml
  end
end

module Serializer
  def self.serialize(content, format)
    serialization_class(format).serialize(content)
  end

  private
  def self.serialization_class(format)
    format == 'json' ? JsonSerializer : XmlSerializer
  end
end
