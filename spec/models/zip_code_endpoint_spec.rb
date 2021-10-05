require 'rails_helper'

RSpec.describe ZipCodeEndpoint, type: :model do
  it "get zip code form api" do
    zipcode = '85022'
    radius = 5
    zip = ZipCodeEndpoint.get_zip_in_radius(zipcode, radius)
    expect(zip.length).to be > 0
  end
end
