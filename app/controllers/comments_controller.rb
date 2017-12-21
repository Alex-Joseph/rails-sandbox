class CommentsController < ApplicationController
    
    def new
        @article = Article.find(params[:id])
        @comment = Comment.new
    end
    
    def show
        @article = Article.find(params[:id])
        @comment = @article.comment
    end
    
    def create
        @article = Article.find(params[:article_id])
        @comment = @article.comments.create(comment_params)
        redirect_to article_path(@article)
    end
    
    private
    def comment_params
        params.require(:comment).permit(:commenter, :body)
    end
end
