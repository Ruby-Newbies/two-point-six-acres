class Api::V1::ArticlesController < Api::V1::BaseController
  def index
    # http://localhost:3000/api/v1/articles?page=0&author_id=1&section_id=1
    @page = params.fetch(:page,0).to_i
    @article_per_page = params.fetch(:limit,2).to_i
    @section_to_show = params[:section_id]
    @author_id_to_show = params[:author_id]
    @articles = Article.with_section(@section_to_show).with_author(@author_id_to_show).offset(@page * @article_per_page).limit(@article_per_page)
    @total = Article.with_section(@section_to_show).with_author(@author_id_to_show).length()
    render json: {:page=>@page, :limit=>@article_per_page, :total=>@total, :articles=>@articles}.to_json
  end

  def show
    @article = Article.find(params[:id])
  end

  def create
    @article = Article.new(article_params)
    @current_user = Article.authorize(request)
    if @current_user.nil?
      render json: { error: 'unauthorized create' }, status: :unauthorized_create
      return
    end
    if @article.author_id == @current_user.id
      @article.save
    else
      render json: { error: 'unauthorized create' }, status: :unauthorized_create
    end
    # @article.save
  end

  def update
      @article = Article.find(params[:id])
      @current_user = Article.authorize(request)
      if @current_user.nil?
        render json: { error: 'unauthorized update' }, status: :unauthorized_update
        return
      end
      if @article.author_id == @current_user.id
        if params[:author_id].nil?
          @article.update(article_params)
          return
        end
        if params[:author_id]!=@current_user.id
          render json: { error: 'cannot update' }, status: :unauthorized_update
        end
        @article.update(article_params)
      else
        render json: { error: 'unauthorized update' }, status: :unauthorized_update
      end
  end

  def destroy
    begin
      @article = Article.find(params[:id])
    rescue ActiveRecord::RecordNotFound => exception
      render json: { errors: exception.message }, status: :unauthorized
      return
    end
    @current_user = Article.authorize(request)

    if @current_user.nil?
      render json: { error: 'unauthorized destroy' }, status: :unauthorized_destroy
      return
    end
    if @current_user.role=="admin" || @current_user.id == @article.author_id
      @article.destroy
    else
      render json: { error: 'unauthorized to delete' }, status: :unauthorized_delete
    end
  end

  def article_params
    params.require(:article).permit(:title, :content, :author_id, :section_id,)
  end

end
