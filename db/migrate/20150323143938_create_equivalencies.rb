class CreateEquivalencies < ActiveRecord::Migration[5.2]
  def change
    create_table :equivalencies do |t|
      t.string :equivalency_id
    end
  end
end
