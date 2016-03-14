class CommentsController < ApplicationController
	before_action :authenticate_user!

	def create
		@article = Article.find(params[:article_id])
		@comment = Comment.new(comment_params)
		@comment.article = @article
		@comment.user = current_user
		authorize @comment
		if @comment.save
			@author = @article.user
			@comment.create_activity action: 'new', recipient: @author, owner: current_user
		end
		redirect_to article_path(@article)
	end

	def destroy
		@article = Article.find(params[:article_id])
		@comment = @article.comments.find(params[:id])
		authorize @comment
		@comment.destroy
		redirect_to article_path(@article)
	end

	private
	def comment_params
		params.require(:comment).permit(:body)
	end
end
