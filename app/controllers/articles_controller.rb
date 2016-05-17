class ArticlesController < ApplicationController
	before_action :authenticate_user!, except: [:index, :show]

	def index
		@articles = Article.all
	end

	def show
		@article = Article.find(params[:id])
		@text = @article.text
		authorize @article
	end

	def new
		@article = Article.new
		authorize @article
	end

	def edit
		@article = Article.find(params[:id])
		authorize @article
	end

	def create
		@article = Article.new(article_params)
		authorize @article
		@article.user = current_user
		if @article.save
			@followers = Relationship.where(followee_id: current_user.id)
			@followers.each do |follower|
				@fan = User.find(follower.follower_id)
				@article.create_activity action: 'new', recipient: @fan, owner: current_user, parameters: {article: @article.id}
				UserMailer.article_notification_email(@fan.username, current_user, @article).deliver_now
			end
			redirect_to @article
		else
			render 'new'
		end
	end

	def update
		@article = Article.find(params[:id])
		authorize @article
		if @article.update(article_params)
			redirect_to @article
		else
			render 'edit'
		end
	end

	def destroy
		@article = Article.find(params[:id])
		authorize @article

		@article.destroy
		redirect_to articles_path
	end

private
	def article_params
		params.require(:article).permit(:title, :text)
	end
end
