class CreateGradingBases < ActiveRecord::Migration
  def change
    create_table :grading_bases do |t|
      t.string :grading_basis_id
      t.string :description
    end
  end
end
