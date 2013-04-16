class Candidate < ActiveRecord::Base
  has_and_belongs_to_many :elections

  attr_accessible :description, :info_url, :name
end
