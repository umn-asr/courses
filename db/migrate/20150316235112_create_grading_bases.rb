class CreateGradingBases < ActiveRecord::Migration[5.2]
  def change
    create_table :grading_bases do |t|
      t.string :grading_basis_id
      t.string :description
    end
  end
end
