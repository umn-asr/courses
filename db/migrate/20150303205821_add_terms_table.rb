class AddTermsTable < ActiveRecord::Migration[5.2]
  def change
    create_table :terms do |t|
      t.string :strm
    end
    add_index :terms, :strm, :unique => true
  end
end
