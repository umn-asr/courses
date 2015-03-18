class CreateSections < ActiveRecord::Migration
  def change
    create_table :sections do |t|
      t.belongs_to :course, index: true
      t.string :class_number
      t.string :number
      t.string :component
      t.string :location
      t.string :credits_minimum
      t.string :credits_maximum
      t.text :notes
    end
  end
end
