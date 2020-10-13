# frozen_string_literal: true

require File.expand_path('config/application', __dir__)

use OTR::ActiveRecord::ConnectionManagement

run Application
