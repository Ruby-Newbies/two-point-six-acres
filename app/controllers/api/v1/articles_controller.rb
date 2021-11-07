class Api::V1::ArticlesController < Api::V1::BaseController
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
      @article.update(article_params)
  end

  def destroy
    @article = Article.find(params[:id])
    @article.destroy
  end

  def article_params
    params.require(:article).permit(:title, :content, :author_id, :section_id)
  end

end