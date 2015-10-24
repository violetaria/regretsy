require "regretsy/version"
require "sinatra/base"
require "etsy"

require "pry"

module Regretsy
  class Dapper < Sinatra::Base
    include Etsy
    set :logging, true
    set :auth_key, "#{ENV["AUTH_KEY"]}"

    get "/search" do
      if params["q"]
        Etsy.api_key = "#{settings.auth_key}"
        response = Etsy::Request.get("/listings/active",
                                     :includes => ["Images", "Shop"],
                                     :keywords => params["q"])

        erb :index, locals: { data: response.result,
                              search_term: params["q"],
                              results_count: response.to_hash["count"].to_s }
      else
        status 204
        { message: "You must supply search query." }
      end

#      binding.pry

    end

    run! if app_file == $0
  end
end

