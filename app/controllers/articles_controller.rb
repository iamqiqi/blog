class ArticlesController < ApplicationController
	before_action :authenticate_user!, except: [:index, :show]
	before_action :load_activities, only: [:index, :show, :new, :edit]

	def index
		@articles = Article.all
	end

	def show
		@article = Article.find(params[:id])
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

	def load_activities
		@activities = PublicActivity::Activity.order('created_at DESC').limit(20)
	end
end
