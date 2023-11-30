# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2017_01_26_193550) do

  create_table "campuses", force: :cascade do |t|
    t.string "abbreviation"
    t.index ["abbreviation"], name: "index_campuses_on_abbreviation", unique: true
  end

  create_table "combined_sections", force: :cascade do |t|
    t.integer "section_id", precision: 38
    t.string "catalog_number"
    t.string "subject_id"
    t.string "section_number"
    t.index ["section_id"], name: "index_combined_sections_on_section_id"
  end

  create_table "course_attributes", force: :cascade do |t|
    t.string "attribute_id"
    t.string "family"
  end

  create_table "course_attributes_courses", id: false, force: :cascade do |t|
    t.integer "course_id", precision: 38
    t.integer "course_attribute_id", precision: 38
    t.index ["course_attribute_id"], name: "index_course_attributes_courses_on_course_attribute_id"
    t.index ["course_id"], name: "index_course_attributes_courses_on_course_id"
  end

  create_table "courses", force: :cascade do |t|
    t.string "course_id"
    t.string "title"
    t.string "description"
    t.string "catalog_number"
    t.integer "subject_id", precision: 38
    t.integer "equivalency_id", precision: 38
    t.string "repeatable"
    t.string "units_repeat_limit"
    t.string "repeat_limit"
    t.string "offer_frequency"
    t.string "credits_minimum"
    t.string "credits_maximum"
    t.integer "grading_basis_id", precision: 38
    t.index ["equivalency_id"], name: "index_courses_on_equivalency_id"
    t.index ["grading_basis_id"], name: "index_courses_on_grading_basis_id"
    t.index ["subject_id"], name: "index_courses_on_subject_id"
  end

  create_table "days", force: :cascade do |t|
    t.string "name"
    t.string "abbreviation"
  end

  create_table "days_meeting_patterns", id: false, force: :cascade do |t|
    t.integer "day_id", precision: 38
    t.integer "meeting_pattern_id", precision: 38
    t.index ["day_id"], name: "index_days_meeting_patterns_on_day_id"
    t.index ["meeting_pattern_id"], name: "index_days_meeting_patterns_on_meeting_pattern_id"
  end

  create_table "equivalencies", force: :cascade do |t|
    t.string "equivalency_id"
  end

  create_table "grading_bases", force: :cascade do |t|
    t.string "grading_basis_id"
    t.string "description"
  end

  create_table "instruction_modes", force: :cascade do |t|
    t.string "instruction_mode_id"
    t.string "description"
  end

  create_table "instructor_contacts", force: :cascade do |t|
    t.string "name"
    t.string "email"
  end

  create_table "instructor_roles", force: :cascade do |t|
    t.string "abbreviation"
  end

  create_table "instructors", force: :cascade do |t|
    t.integer "instructor_contact_id", precision: 38
    t.integer "section_id", precision: 38
    t.integer "instructor_role_id", precision: 38
    t.string "print"
    t.index ["instructor_contact_id"], name: "index_instructors_on_instructor_contact_id"
    t.index ["instructor_role_id"], name: "index_instructors_on_instructor_role_id"
    t.index ["section_id"], name: "index_instructors_on_section_id"
  end

  create_table "locations", force: :cascade do |t|
    t.string "location_id"
    t.string "description"
  end

  create_table "meeting_patterns", force: :cascade do |t|
    t.integer "section_id", precision: 38
    t.string "start_time"
    t.string "end_time"
    t.datetime "start_date", precision: 6
    t.datetime "end_date", precision: 6
    t.integer "location_id", precision: 38
    t.index ["location_id"], name: "index_meeting_patterns_on_location_id"
    t.index ["section_id"], name: "index_meeting_patterns_on_section_id"
  end

  create_table "sections", force: :cascade do |t|
    t.integer "course_id", precision: 38
    t.string "class_number"
    t.string "number"
    t.string "component"
    t.string "location"
    t.text "notes"
    t.integer "instruction_mode_id", precision: 38
    t.string "enrollment_cap"
    t.string "status"
    t.string "print"
    t.index ["course_id"], name: "index_sections_on_course_id"
    t.index ["instruction_mode_id"], name: "index_sections_on_instruction_mode_id"
  end

  create_table "subjects", force: :cascade do |t|
    t.string "subject_id"
    t.string "description"
    t.integer "campus_id", precision: 38
    t.integer "term_id", precision: 38
    t.index ["campus_id"], name: "index_subjects_on_campus_id"
    t.index ["term_id"], name: "index_subjects_on_term_id"
  end

  create_table "terms", force: :cascade do |t|
    t.string "strm"
    t.index ["strm"], name: "index_terms_on_strm", unique: true
  end

end
