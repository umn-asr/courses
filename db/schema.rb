# encoding: UTF-8
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

ActiveRecord::Schema.define(version: 20150316191611) do

  create_table "campuses", force: :cascade do |t|
    t.string "abbreviation"
  end

  add_index "campuses", ["abbreviation"], name: "index_campuses_on_abbreviation", unique: true

  create_table "courses", force: :cascade do |t|
    t.integer "campus_id"
    t.integer "term_id"
    t.string  "course_id"
    t.string  "title"
    t.string  "description"
    t.string  "catalog_number"
  end

  add_index "courses", ["campus_id"], name: "index_courses_on_campus_id"
  add_index "courses", ["term_id"], name: "index_courses_on_term_id"

  create_table "courses_subjects", id: false, force: :cascade do |t|
    t.integer "course_id"
    t.integer "subject_id"
  end

  add_index "courses_subjects", ["course_id"], name: "index_courses_subjects_on_course_id"
  add_index "courses_subjects", ["subject_id"], name: "index_courses_subjects_on_subject_id"

  create_table "subjects", force: :cascade do |t|
    t.string "subject_id"
    t.string "description"
  end

  create_table "terms", force: :cascade do |t|
    t.string "strm"
  end

  add_index "terms", ["strm"], name: "index_terms_on_strm", unique: true

end
