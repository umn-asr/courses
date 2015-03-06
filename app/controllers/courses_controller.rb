require_relative "../../lib/course_contract_tests/lib/reference_test"

class CoursesController < ApplicationController
  def index
    campus_repo = Repositories::CampusRepository.new
    term_repo = Repositories::TermRepository.new

    @campus = campus_repo.find(params[:campus_id])
    @term = term_repo.find(params[:term_id])

    @courses = [OpenStruct.new(type: "course", id: "2066",
      catalog_number: "1101W",
      subject: {type: "subject", id: "PHYS", description: "Physics"},
      description: "Fundamental principles of physics in the context of everyday world. Use of kinematics/dynamics principles and quantitative/qualitative problem solving techniques to understand natural phenomena. Lecture, recitation, lab.",
      title: "Intro College Phys I",
      attributes: [{type: "attribute", id: "CLE", values: ["WI", "PHYS"]}],
      sections: [""])]

    render
  end

  def create
    begin
      ReferenceTest.test_structure(params[:course])
    rescue
      render nothing: true, status: 400
    else
      campus_repo = Repositories::CampusRepository.new
      campus_attr = params[:course]["campus"].permit(:abbreviation, :type, :id)
      campus_repo.save(campus_repo.build(attributes: campus_attr))

      term_repo = Repositories::TermRepository.new
      term_attr = params[:course]["term"].permit(:strm, :type, :id)
      term_repo.save(term_repo.build(attributes: term_attr))

      render nothing: true
    end
  end
end
