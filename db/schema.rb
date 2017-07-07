# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20170707143338) do

  create_table "campuses", force: :cascade do |t|
    t.string "abbreviation"
  end

  add_index "campuses", ["abbreviation"], name: "index_campuses_on_abbreviation", unique: true

  create_table "combined_sections", force: :cascade do |t|
    t.integer "section_id",     precision: 38
    t.string  "catalog_number"
    t.string  "subject_id"
    t.string  "section_number"
  end

  create_table "course_attributes", force: :cascade do |t|
    t.string "attribute_id"
    t.string "family"
  end

  create_table "course_attributes_courses", id: false, force: :cascade do |t|
    t.integer "course_id",           precision: 38
    t.integer "course_attribute_id", precision: 38
  end

  add_index "course_attributes_courses", ["course_attribute_id"], name: "i_cou_att_cou_cou_att_id"
  add_index "course_attributes_courses", ["course_id"], name: "i_cou_att_cou_cou_id"

  create_table "courses", force: :cascade do |t|
    t.string  "course_id"
    t.string  "title"
    t.string  "description",        limit: 4000
    t.string  "catalog_number"
    t.integer "subject_id",                      precision: 38
    t.integer "equivalency_id",                  precision: 38
    t.string  "repeatable"
    t.string  "units_repeat_limit"
    t.string  "repeat_limit"
    t.string  "offer_frequency"
    t.string  "credits_minimum"
    t.string  "credits_maximum"
    t.integer "grading_basis_id",                precision: 38
  end

  add_index "courses", ["equivalency_id"], name: "i_courses_equivalency_id"
  add_index "courses", ["subject_id"], name: "index_courses_on_subject_id"

  create_table "days", force: :cascade do |t|
    t.string "name"
    t.string "abbreviation"
  end

  create_table "days_meeting_patterns", id: false, force: :cascade do |t|
    t.integer "day_id",             precision: 38
    t.integer "meeting_pattern_id", precision: 38
  end

  add_index "days_meeting_patterns", ["day_id"], name: "i_days_meeting_patterns_day_id"
  add_index "days_meeting_patterns", ["meeting_pattern_id"], name: "i_day_mee_pat_mee_pat_id"

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
    t.integer "section_id",            precision: 38
    t.integer "instructor_role_id",    precision: 38
    t.string  "print"
  end

  add_index "instructors", ["instructor_contact_id"], name: "i_ins_ins_con_id"
  add_index "instructors", ["instructor_role_id"], name: "i_ins_ins_rol_id"
  add_index "instructors", ["section_id"], name: "i_instructors_section_id"

  create_table "locations", force: :cascade do |t|
    t.string "location_id"
    t.string "description"
  end

  create_table "meeting_patterns", force: :cascade do |t|
    t.integer  "section_id",  precision: 38
    t.string   "start_time"
    t.string   "end_time"
    t.datetime "start_date",  precision: 6
    t.datetime "end_date",    precision: 6
    t.integer  "location_id", precision: 38
  end

  create_table "sections", force: :cascade do |t|
    t.integer "course_id",           precision: 38
    t.string  "class_number"
    t.string  "number"
    t.string  "component"
    t.string  "location"
    t.text    "notes"
    t.integer "instruction_mode_id", precision: 38
    t.string  "enrollment_cap"
    t.string  "status"
    t.string  "print"
  end

  add_index "sections", ["course_id"], name: "index_sections_on_course_id"

  create_table "subjects", force: :cascade do |t|
    t.string  "subject_id"
    t.string  "description"
    t.integer "campus_id",   precision: 38
    t.integer "term_id",     precision: 38
  end

  add_index "subjects", ["campus_id"], name: "index_subjects_on_campus_id"
  add_index "subjects", ["term_id"], name: "index_subjects_on_term_id"

  create_table "terms", force: :cascade do |t|
    t.string "strm"
  end

  add_index "terms", ["strm"], name: "index_terms_on_strm", unique: true

  add_foreign_key "subjects", "campuses"
  add_foreign_key "subjects", "terms"
end
