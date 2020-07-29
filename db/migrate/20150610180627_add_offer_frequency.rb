class AddOfferFrequency < ActiveRecord::Migration[5.2]
  def change
    add_column(:courses, :offer_frequency, :string)
  end
end
