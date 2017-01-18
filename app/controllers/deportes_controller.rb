class DeportesController < ApplicationController
  before_action :set_deporte, only: [:show, :edit, :update, :destroy]

  # GET /deportes
  # GET /deportes.json
  def index
    @deportes = Deporte.paginate(page: params[:page])

    respond_to do |format|
      format.html
      format.csv { send_data @deportes.to_csv }
      format.xls
    end
  end

  # POST /deportes/import
  def import
    Deporte.import(params[:file])
    flash[:success] = 'Se ha importado exitosamente el archivo de deportes a la base de datos.'
    redirect_to deportes_path
  end

  # GET /deportes/1
  # GET /deportes/1.json
  def show
  end

  # GET /deportes/new
  def new
    @deporte = Deporte.new
  end

  # GET /deportes/1/edit
  def edit
  end

  # POST /deportes
  # POST /deportes.json
  def create
    @deporte = Deporte.new(deporte_params)

    if @deporte.save
      flash[:success] = 'Registro de deporte ha sido creado exitosamente'
        redirect_to deportes_path
    else
        render 'new'
    end
  end

  # PATCH/PUT /deportes/1
  # PATCH/PUT /deportes/1.json
  def update

    if @deporte.update(deporte_params)
      flash[:success] = 'Se ha actualizado exitosamente el registro de Deporte.'
      redirect_to @deporte
    else
      render 'edit'
    end
  end

  # DELETE /deportes/1
  # DELETE /deportes/1.json
  def destroy
    @deporte.destroy
    flash[:success] = 'Se ha eliminado exitosamente el registro de Deporte.'
    redirect_to deportes_url
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_deporte
      @deporte = Deporte.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def deporte_params
      params.require(:deporte).permit(:nombre)
    end
end
