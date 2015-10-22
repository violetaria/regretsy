require "pry"
require "httparty"

module Regretsy
  class Etsy
    include HTTParty
    base_uri "https://openapi.etsy.com/v2"

    def initialize
      @headers = { "auth_key" => "#{ENV["AUTH_KEY"]}"}
    end

    def search_listings(term)
      response = self.class.get("/listings/active/?api_key=#{ENV["AUTH_KEY"]}")
  #                              query: @headers)
      binding.pry
      response
    end

  end
end

test = Regretsy::Etsy.new

binding.pry