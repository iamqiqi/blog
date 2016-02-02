class CommentsController < ApplicationController
	before_action :authenticate_user!
	before_action :load_activities

	def create
		@article = Article.find(params[:article_id])
		@comment = Comment.new(comment_params)
		@comment.article = @article
		@comment.user = current_user
		authorize @comment
		@comment.save
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

	def load_activities
		@activities1 = PublicActivity::Activity.order('created_at DESC').limit(20)
	end
end
