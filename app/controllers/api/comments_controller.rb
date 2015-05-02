module Api
  class CommentsController < Api::ApplicationController

    before_action :http_authenticate_or_request, except: [:show, :index]
    before_action :http_authenticate_or_set_guest, only: [:show, :index]

    def show
      respond_with comment
    end

    def index
      respond_with article.comments.page(page)
    end

    def update
      authorize(comment)
      if comment.update(update_comment_params)
        render json: comment
      else
        render json: { errors: comment.errors.messages }, status: :unprocessable_entity
      end
    end

    def create
      comment = article.comments.new(create_comment_params.merge(user: user))
      authorize(comment)
      if comment.save
        render json: comment
      else
        render json: { errors: comment.errors.messages }, status: :unprocessable_entity
      end
    end

    def destroy
      authorize(comment)
      respond_with comment.destroy
    end

    private

    def comment
      @comment ||= article.comments.find(params[:id])
    end

    def article
      user.articles.find(params[:article_id])
    end

    def user
      User.find(params[:user_id])
    end

    def update_comment_params
      params.require(:comment).permit(:content, :user_id, :article_id)
    end

    def create_comment_params
      params.require(:comment).permit(:content)
    end
  end
end
