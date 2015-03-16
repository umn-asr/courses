class CreateAttributesTable < ActiveRecord::Migration
  def change
    create_table :course_attributes do |t|
      t.string :attribute_id
      t.string :family
    end
  end
end
