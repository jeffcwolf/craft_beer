require 'open-uri'
require 'json'

class BrewerydbsController < ApplicationController

  def index
  end

  def api

    @endpoint = "locations"
    @parameter = "postalCode"
    @value = "60647"

    @brewerydb_api_url = "http://api.brewerydb.com/v2/#{@endpoint}?key=f9848bef7e3c482cdd315510fc1ba1db&format=json&#{@parameter}=#{@value}"

    @raw_results = open(@brewerydb_api_url).read

    @parsed_results = JSON.parse(@raw_results)

    # @name = @parsed_results["data"][0]["name"]
    # @description = @parsed_results["data"][0]["description"]
    # @parameter_results = @parsed_results["data"][0]["#{@parameter}"]
  end

  def location
    @user_address = params[:address]
    @url_safe_address = URI.encode(@user_address)

    geocoding_api_url = "http://maps.googleapis.com/maps/api/geocode/json?address=#{@url_safe_address}"

    raw_results = open(geocoding_api_url).read

    parsed_results = JSON.parse(raw_results)

    @latitude = parsed_results["results"][0]["geometry"]["location"]["lat"]
    @longitude = parsed_results["results"][0]["geometry"]["location"]["lng"]
  end

end
