class Comment
	include Mongoid::Document
  include Mongoid::Timestamps

  field :body, type: String
  field :abusive, type: Boolean, default: false
	belongs_to :user
	belongs_to :post
	has_many :votes, after_add: :abusive_comment
	scope :bad_votes, ->{ where(value: -1)} 

	def unlock_abusive_state
		self.abusive = false

	end

	def display_for_post_author
		
	end

	def positive_value? (value)
		value > 0
	end

	private
		def abusive_comment(vote)
			 if vote.value - self.votes.where("value = -1 ").count  == -3 
			 	update_attribute 'abusive', true 
			 end
		end


end
