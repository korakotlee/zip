class CreatePartnerClinics < ActiveRecord::Migration[6.1]
  def change
    create_table :partner_clinics do |t|
      t.string :name
      t.string :address
      t.string :city
      t.string :state
      t.string :tier
      t.string :contact_email
      t.string :contact_name

      t.timestamps
    end
  end
end
