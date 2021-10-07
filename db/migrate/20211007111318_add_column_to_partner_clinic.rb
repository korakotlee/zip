class AddColumnToPartnerClinic < ActiveRecord::Migration[6.1]
  def change
    add_column :partner_clinics, :zipcode, :string
  end
end
