class Zip
  include Mongoid::Document

  field :id,         type: String
  field :city,       type: String
  field :state,      type: String
  field :population, type: Integer
  field :loc,        type: Array
end
