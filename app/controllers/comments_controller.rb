class CommentsController < ApplicationController

	def mark_as_not_abusive
		@post = Post.find(params[:post_id])
		@comment = Comment.find(params[:id])
		@comment.update_attributes(abusive: false)
		redirect_to @post
	end

	def vote_up
		@post = current_user.posts.find(params[:post_id])
		@comment = @post.comments.find(params[:id])
		if @comment.votes.empty?
			@comment.votes.create(value: 1).save
		end
		redirect_to @post
	end
end