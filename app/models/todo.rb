# frozen_string_literal: true

class Todo < ActiveRecord::Base
  validates :title, presence: true, allow_blank: false
  scope :active, -> { where done: false }
end
