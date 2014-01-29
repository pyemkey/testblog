class CommentsController < ApplicationController

	def create
		@comment = Comment.new(comment_params)
		@comment.post_id = params[:post_id]
		@comment.save
		current_user.add_comment @comment
		redirect_to @comment.post
	end

	def mark_as_not_abusive
		comment.unlock_abusive_state
		redirect_to comment.post
	end

	def vote_up
		vote 1
	end

	def vote_down
		vote -1
	end

	private
		def vote(value)
			unless comment.contain_user_vote? current_user
				vote = Vote.create(user: current_user, value: value)	
			 	comment.add_vote vote
			end
			redirect_to comment.post
		end

		def comment
			@_comment ||= Comment.find(params[:id])
		end

		def comment_params
			params.require(:comment).permit(:user_id,:body)
		end
end