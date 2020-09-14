class ArticlesController < ApplicationController
  before_action :set_article, only: %i[show edit destroy update]
  before_action :require_user, except: %i[show index]
  before_action :require_same_user, only: %i[update edit destroy]

  # Estos realmente no estan vacios, hay un before_action que llama un metodo privado, eso basicamente limpia el codigo
  def show; end

  def index
    @articles = Article.paginate(page: params[:page], per_page: 5)
  end

  def new
    @article = Article.new
  end

  def edit; end

  def destroy
    @article = Article.find(params[:id])
    @article.destroy
    flash[:notice] = 'Article deleted succesfully'
    redirect_to articles_path
  end

  def create
    @article = Article.new(article_params)
    @article.user = current_user
    if @article.save
      flash[:notice] = 'Article saved succesfully'
      redirect_to @article
    else
      render 'edit'
    end
  end

  def update
    if @article.update(article_params)
      flash[:notice] = 'Article update succesfully'
      redirect_to @article
    else
      render 'edit'
    end
  end

  # El private es para definir metodos los cuales son solo accesibles para el servidor
  private

  # Settea el articulo seguns los params del URI
  def set_article
    @article = Article.find(params[:id])
  end

  # Hace un whitelist de los parametros que necesitamos asi con eso no escribimos el codigo muchas veces, solamente llamamos al metodo
  def article_params
    params.require(:article).permit(:title, :description)
  end

  # Valida que el usuario sea el mismo, del articulo para poder permitir las acciones
  def require_same_user
    if current_user != @article.user
      flash[:alert] = 'You are not allowed to do that'
      redirect_to @article
    end
  end
end
