class CreateEquivalencies < ActiveRecord::Migration
  def change
    create_table :equivalencies do |t|
      t.string :equivalency_id
    end
  end
end
