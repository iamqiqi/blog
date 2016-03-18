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

	# def edit
	# 	@article = Article.find(params[:article_id])
	# 	@comment = @article.comments.find(params[:id])
	# 	authorize @comment
	# end

	def update
		@article = Article.find(params[:article_id])
		@comment = @article.comments.find(params[:id])
		authorize @comment
		respond_to do |format|
			format.js {
				if @comment.update(comment_params)
					render js: "window.location.href='#{article_path(@article)}'"
				else
					format.js
				end
			}
		end
	end

	private

	def comment_params
		params.require(:comment).permit(:body)
	end
end
