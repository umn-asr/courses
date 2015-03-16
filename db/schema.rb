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

ActiveRecord::Schema.define(version: 20150316203631) do

  create_table "campuses", force: :cascade do |t|
    t.string "abbreviation"
  end

  add_index "campuses", ["abbreviation"], name: "index_campuses_on_abbreviation", unique: true

  create_table "course_attributes", force: :cascade do |t|
    t.string "attribute_id"
    t.string "family"
  end

  create_table "course_attributes_courses", id: false, force: :cascade do |t|
    t.integer "course_id"
    t.integer "course_attribute_id"
  end

  add_index "course_attributes_courses", ["course_attribute_id"], name: "index_course_attributes_courses_on_course_attribute_id"
  add_index "course_attributes_courses", ["course_id"], name: "index_course_attributes_courses_on_course_id"

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

  create_table "sections", force: :cascade do |t|
    t.integer "course_id"
    t.string  "class_number"
    t.string  "number"
    t.string  "component"
    t.string  "location"
    t.string  "credits_minimum"
    t.string  "credits_maximum"
    t.text    "notes"
  end

  add_index "sections", ["course_id"], name: "index_sections_on_course_id"

  create_table "terms", force: :cascade do |t|
    t.string "strm"
  end

  add_index "terms", ["strm"], name: "index_terms_on_strm", unique: true

end
