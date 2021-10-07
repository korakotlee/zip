require "rails_helper"

VCR.configure do |config|
  config.cassette_library_dir = "fixtures/vcr_cassettes"
  config.hook_into :webmock
end

describe ZipCodeEndpoint, type: :model do
  fixtures :partner_clinic
  before do
    @zipcode = "85022"
    @radius = 5
  end
  it "get zip code form api" do
    VCR.use_cassette("zip") do
      @zips_api = ZipCodeEndpoint.send(:extract_zip_codes_from_api, @zipcode, @radius, "mile")
      expect(@zips_api.length).to be > 0
    end
    partner_clinics = ZipCodeEndpoint.send(:extract_zip_codes_from_db, @zips_api["zip_codes"]).to_a
    expect(partner_clinics.length).to eq(4)
  end

  it "get zip codes and sort" do
    VCR.use_cassette("zip") do
      @out = ZipCodeEndpoint.get_zip_in_radius(@zipcode, @radius, "mile")
    end
    puts "\n\n"
    puts @out
    expect(@out.map {|r| r[:name]}).to eq(["Clinic 4", "Clinic 1", "Clinic 3", "Clinic 2"])
  end
end
