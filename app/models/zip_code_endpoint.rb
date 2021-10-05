ZIP_CODE_API_KEY = 'OPZ5C46YqxIfKbeJK4hDQwkzYn7T0743vSrXn4cBZR4vuo9lX9JEiwSVwwr37YGN'

class ZipCodeEndpoint
  class << self
    def get_zip_in_radius(zipcode, radius, units = "mile")
      # 1. Get list of ZIP codes in radius from starting zip code point
        extracted_zips_from_api = extract_zip_codes_from_api(zipcode, radius, units)
      return []
      #   return [] unless extracted_zips_from_api
    end

    def extract_zip_codes_from_api(zipcode, radius, units)
      zip_data = call_zip_codes_api(zipcode, radius, units)
      byebug
      return nil unless zip_data

      tmp_array_of_zips = { "zip_codes" => [], "zip_codes_with_distance" => {} }
      zip_data["zip_codes"].each do |item|
        tmp_array_of_zips["zip_codes"].push(item["zip_code"])
        tmp_array_of_zips["zip_codes_with_distance"][item["zip_code"]] = item["distance"]
      end
      tmp_array_of_zips
    end

    def call_zip_codes_api(zipcode, radius, units)
      url = "https://www.zipcodeapi.com/rest/#{ZIP_CODE_API_KEY}/radius.json/#{zipcode}/#{radius}/#{units}"
      zip_response = Faraday.send(:post, url)
      return nil unless zip_response.success?

      JSON.parse(zip_response.body)
    end
  end
end
