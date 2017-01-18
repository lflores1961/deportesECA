class CategoriasController < ApplicationController
  before_action :logged_in_user, only: [:index, :edit, :update, :create, :destroy]
  before_action :set_categoria, only: [:show, :edit, :update, :destroy]

  # GET /categorias
  # GET /categorias.json
  def index
    @categorias = Categoria.paginate(page: params[:page])

    respond_to do |format|
      format.html
      format.csv { send_data @categorias.to_csv }
      format.xls
    end
  end

  # POST /categorias/import
  def import
    Categoria.import(params[:file])
    flash[:success] = "Categorías importadas a la base de datos."
    redirect_to categorias_path
  end

  # GET /categorias/1
  # GET /categorias/1.json
  def show
  end

  # GET /categorias/new
  def new
    @categoria = Categoria.new
  end

  # GET /categorias/1/edit
  def edit
  end

  # POST /categorias
  # POST /categorias.json
  def create
    @categoria = Categoria.new(categoria_params)

    if @categoria.save
      flash[:success] = 'Se inserto exitosamente la nueva categoría.'
      redirect_to categorias_path
    else
      render 'new'
    end
  end

  # PATCH/PUT /categorias/1
  # PATCH/PUT /categorias/1.json
  def update
    if @categoria.update(categoria_params)
      flash[:success] = 'Se actualizó exitosamente la Categoría.'
      redirect_to categorias_path
    else
      render 'edit'
    end
  end

  # DELETE /categorias/1
  # DELETE /categorias/1.json
  def destroy
    @categoria.destroy
    flash[:success] = 'Se eliminó correctamente la categoría.'
    redirect_to categorias_url
  end

  private

    # Use callbacks to share common setup or constraints between actions.
    def set_categoria
      @categoria = Categoria.find(params[:id])
    end

    # Never trust the internet. Only allow the white list through.
    def categoria_params
      params.require(:categoria).permit(:nombre, :limInferior, :limSuperior)
    end

end
