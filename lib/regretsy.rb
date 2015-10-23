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
      Etsy.api_key = "#{settings.auth_key}"
      response = Etsy::Request.get('/listings/active',
                                   :includes => ['Images', 'Shop'],
                                   :keywords => 'whiskey')

      #binding.pry
      erb :index, locals: { data: response.result }
    end

    run! if app_file == $0
  end
end

