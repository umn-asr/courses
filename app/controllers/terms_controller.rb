class TermsController < ApplicationController
  def index
    format = params.fetch(:format, 'json')
    content = {terms: Term.all.map { |x| x.to_h}}
    render format.to_sym => Serializer.serialize(content, format)
  end
end
