# frozen_string_literal: true

ENV['RACK_ENV'] ||= 'development'

require 'bundler/setup'
Bundler.require(:default, ENV['RACK_ENV'])

OTR::ActiveRecord.configure_from_file! File.expand_path('database.yml', __dir__)
