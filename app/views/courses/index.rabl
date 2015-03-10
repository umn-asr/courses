object @courses

node :campus do
  partial "campuses/show", object: @courses.campus
end

node :term do
  partial "terms/show", object: @courses.term
end

child :courses => :courses do
  extends "courses/show"
end
