class EquiposController < ApplicationController
  before_action :logged_in_user, only: [:index, :edit, :update, :create, :destroy]
  before_action :set_equipo,    only: [:show, :edit, :update, :destroy, :eventos_feed]
  before_action :set_deportes,  only: [:new, :edit, :create]
  before_action :set_categorias, only: [:new, :show, :edit, :update, :create]
  before_action :set_ramas,      only: [:new, :show, :edit, :update, :create]

  # GET /equipos
  # GET /equipos.json
  def index
    @equipos = Equipo.paginate(page: params[:page])

    respond_to do |format|
      format.html
      format.csv { send_data @equipos.to_csv }
      format.xls
    end
  end

  # POST /equipos/import
  def import
    Equipo.import(params[:file])
    flash[:success] = 'Se ha importado exitosamente el archivo de equipos a la base de datos.'
    redirect_to equipos_path
  end

  # GET /equipos/1
  # GET /equipos/1.json
  def show
    @entrenador = User.find(@equipo.user_id)
    @categoria = Categoria.find(@equipo.categoria)
    @players = @equipo.players
  end

  # GET /equipos/new
  def new
    @equipo = Equipo.new
    @usuarios = User.all
  end

  # GET /equipos/1/edit
  def edit
    @usuarios = User.all
  end

  # POST /equipos
  # POST /equipos.json
  def create
    @equipo = Equipo.new(equipo_params)

    if @equipo.save
      flash[:success] = "Se ha registrado exitosamente el nuevo equipo."
      redirect_to equipos_path
    else
      render 'new'
    end
  end

  # PATCH/PUT /equipos/1
  # PATCH/PUT /equipos/1.json
  def update

    if @equipo.update(equipo_params)
      flash[:success] = 'Se actualizó exitosamente el equipo.'
      redirect_to equipos_path
    else
      render 'edit'
    end
  end

  # DELETE /equipos/1
  # DELETE /equipos/1.json
  def destroy
    # In order to guard Player dependency on Equipo and avoid the system to crash
    # Execute player.seguro for all players associated to this team first
    #
    safeTeam = Equipo.find_by(name: "99 - NO DETERMINADO")
    @equipo.players.each do |plyr|
      plyr.seguro safeTeam.id
    end

    @equipo.destroy
    flash[:success] = 'Se eliminó correctamente el equipo.'
    redirect_to equipos_url
  end

  # GET /equipos/1/eventos_feed
  def eventos_feed
    @feed_eventos = @equipo.eventos
  end

  # GET /equipos/forma_rep
  def forma_rep
    @equipo = Equipo.new
    @entrenadores = User.all
  end

  # PUT /equipos/reporte_asist
  def reporte_asist

    if params[:entrenador]
      @entrenador = User.find(params[:entrenador].to_i)
      @inicio = Time.parse(params[:inicio])
      @final = Time.parse(params[:final])
      @equipos = @entrenador.equipos
      @eventos = reporte(@entrenador.id, @inicio, @final)
    else
      @entrenador = current_user
      @equipos = @entrenador.equipos
      @equipos.each do |equi|
        @eventos << equi.eventos
      end
    end

    # Setup Vertical asistencias as horizontal for each evento
    # Creating a two dimensional array @reporte_rows indexed
    @reporte_rows = []
    # First row is type of events
    # Second row is evento dat
    first_row = ["Evento:"]
    second_row = ["Fecha:"]
    
    respond_to do |format|
      format.html
      format.xls
    end

  end

  private

  # Find correct set of eventos for user's teams
  def reporte entrena, inicio, final
    entrenador = User.find(entrena)
    equipos = entrenador.equipos

    @events = []
    equipos.each do |equipo|

      equipo.eventos.each do |event|

        if (event.fecha >= inicio) && (event.fecha <= final)
          @events << event
        end

      end
    end
    return @events
  end

  # Set @deportes to select from in form.
  def set_deportes
    @deportes = Deporte.all
    # @deportes = [ 'FUTBOL', 'HANDBALL', 'BASKETBOL', 'PORRA', 'TKD', 'SOFTBALL', 'BEISBOL', 'VOLEYBOL', 'TENIS DE MESA', 'BANDA DE GUERRA', 'NATACIÓN', 'BADMINGTON', 'GIMNASIA ARTÍSTICA', 'TOCHITO', 'AJEDRÉZ' ]
  end

  def set_ramas
    #@ramas = { 1 => 'Varonil', 2 => 'Femenil', 3 => 'Mixto' }
    @ramas = ['VARONIL', 'FEMENIL', 'MIXTO']
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_equipo
    @equipo = Equipo.find(params[:id])
  end

  def set_categorias
    @categorias = Categoria.all
  end

  def equipo_params
    params.require(:equipo).permit(:name, :categoria, :deporte, :rama, :user_id)
  end
end
