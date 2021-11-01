class Api::V1::ArticlesController < Api::V1::BaseController
  before_action :set_default_request_format
  def index
    @articles = Article.all
  end

  def show
    @article = Article.find(params[:id])
  end

  def create
    @article = Article.new(article_params)
    @article.save
  end

  def update
      @article = Article.find(params[:id])
      @article.update_attributes(article_params)
  end

  def destroy
    @article = Article.find(params[:id])
    @article.destroy
  end

  def article_params
    params.require(:article).permit(:title, :content, :author_id)
  end

  def set_default_request_format
    request.format = :json unless params[:format]
  end

end