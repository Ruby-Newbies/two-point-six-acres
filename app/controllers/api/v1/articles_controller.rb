class Api::V1::ArticlesController < Api::V1::BaseController
  def index
    @articles = Article.all
  end

  def show
    @article = Article.find(params[:id])
    # 我们现在使用 app/views/api/v1/users/show.json.jbuilder
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
end