require 'cuba'
require 'mongoid'
require 'json'

require './models/machine'
require './utils/size_utils'
require './services/machine_manager'
require './services/change_set_service'
require './routes/api'

ENV['RACK_ENV'] ||= 'development'
Mongoid.load!("#{Dir.pwd}/config/mongoid.yml")

Cuba.define do
  on 'api' do
    run API
  end
end
