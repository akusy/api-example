module Api
  class ArticlesController < Api::ApplicationController

    before_action :http_authenticate_or_request, except: [:show, :index]
    before_action :http_authenticate_or_set_guest, only: [:show, :index]

    def show
      respond_with article
    end

    def index
      respond_with user.articles.page(page)
    end

    def update
      if article.update(update_article_params)
        render json: article
      else
        render json: { errors: article.errors.messages }, status: :unprocessable_entity
      end
    end

    def create
      article = user.articles.new(create_article_params)
      if article.save
        render json: article
      else
        render json: { errors: article.errors.messages }, status: :unprocessable_entity
      end
    end

    def destroy
      respond_with article.destroy
    end

    private

    def article
      user.articles.find(params[:id])
    end

    def user
      User.find(params[:user_id])
    end

    def update_article_params
      params.require(:article).permit(:email, :name, :content, :user_id)
    end

    def create_article_params
      params.require(:article).permit(:email, :name, :content)
    end
  end
end
