class Api::V1::ArticlesController < Api::V1::BaseController
  ARTICLES_PER_PAGE = 2
  def index
    # http://localhost:3000/api/v1/articles?page=1
    @page = params.fetch(:page,0).to_i
    @articles = Article.offset(@page * ARTICLES_PER_PAGE).limit(ARTICLES_PER_PAGE)
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