class Vote
	include Mongoid::Document
	field :value, type: Integer
	belongs_to :user
	belongs_to :comment
end
