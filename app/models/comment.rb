class Comment
	include Mongoid::Document
  include Mongoid::Timestamps

  field :body, type: String
  field :abusive, type: Boolean, default: false
	belongs_to :user
	belongs_to :post
	has_many :votes, after_add: :abusive_comment, dependent: :destroy
	scope :bad_votes, ->{ where(value: -1)} 

	def unlock_abusive_state
		update_attribute :abusive, false
	end

	def negative_value_counter
		self.votes.where(value: -1).count
	end
	
	def positive_value_counter
		self.votes.where(value: 1).count
	end

	def add_vote vote
		votes << vote
	end

	def contain_user_vote? user
		votes.map(&:user).include? user
	end

	private
		def abusive_comment(vote)
			 if vote.value - negative_value_counter  == -3 
			 	update_attribute :abusive, true 
			 end
		end
end
