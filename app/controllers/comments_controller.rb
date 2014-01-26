class CommentsController < ApplicationController

	def create
		@comment = Comment.new(comment_params)
		@comment.post_id = params[:post_id]
		@comment.save
		current_user.comments << @comment
		redirect_to @comment.post
	end

	def mark_as_not_abusive
		@comment = Comment.find(params[:id])
		@comment.unlock_abusive_state
		redirect_to @comment.post
	end

	def vote_up
		vote 1
	end

	def vote_down
		vote -1
	end

	private
		def vote(value)
			@comment = Comment.find(params[:id])
			unless @comment.votes.map(&:user).include? current_user
				vote = Vote.create(user: current_user, value: -1)
			 	@comment.votes << vote
			end
			redirect_to @comment.post
		end

		def comment_params
			params.require(:comment).permit(:post_id,:user_id,:body)
		end
end