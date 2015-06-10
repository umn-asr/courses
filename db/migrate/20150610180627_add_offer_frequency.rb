class AddOfferFrequency < ActiveRecord::Migration
  def change
    add_column(:courses, :offer_frequency, :string)
  end
end
