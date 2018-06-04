Rails.application.configure do
  config.lograge.enabled = true
  config.lograge.formatter = Lograge::Formatters::Logstash.new
  config.lograge.custom_options = lambda do |event|
    {
      exception: event.payload[:exception],
      exception_object: event.payload[:exception_object],
    }
  end
end
