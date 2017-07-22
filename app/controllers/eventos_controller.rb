class EventosController < ApplicationController
  before_action :logged_in_user,  only: [:index, :edit, :update, :create, :destroy]
  before_action :set_evento,      only: [:show, :edit, :update, :destroy]
  before_action :set_equipos,     only: [:show, :new, :edit, :create, :update]
  before_action :set_tiposEvento,  only: [:new, :edit, :create, :update, :evento_players]

  # GET /eventos
  def index
    @eventos = Evento.paginate(page: params[:page])

    respond_to do |format|
      format.html
      format.csv { send_data @eventos.to_csv }
      format.xls
    end
  end

  # GET /eventos/calendario
  def calendario
    @user = current_user
    @eventos = Evento.all
  end

  # GET /eventos/1
  def show
		@user = current_user
    @equipo = @evento.equipo
    @jugadores = @equipo.players
    # @asistencias = @evento.asistencias
  end

  # GET /eventos/new
  def new
    @evento = Evento.new
  end

  # GET /eventos/1/edit
  def edit
  end

  # POST /eventos
  def create
    @evento = Evento.new(evento_params)

    if @evento.save
      flash[:success] = "Se insertó exitosamente el evento."
      redirect_to eventos_path
    else
      render 'new'
    end
  end

  # GET /eventos/:id/players as: :eventoPlayers
  def evento_players
    @evento = Evento.find(params[:id])
    @equipo = Equipo.find(@evento.equipo_id)
    @jugadores = @equipo.players
    p @jugadores
    @tiposAsistencia = ['asistió', 'falta', 'retardo', 'médico']

    @jugadores.each { |n| @evento.asistencias.build(player_id:n.id) }

  end

  # PATCH/PUT /eventos/1
  def update

    if @evento.update(evento_params)
      flash[:success] = "Se actualizó exitosamente el evento."
      redirect_to root_path
    else
      render 'edit'
    end
  end

  # DELETE /eventos/1
  def destroy
    @evento.destroy
    flash[:success] = "Se eliminó exitosamente el evento."
    redirect_to eventos_url
  end


  # GET /eventos/forma_prog
  def forma_prog
    @entrenadores = User.all
    @dias = %w[Dom Lun Mar Mie Jue Vie Sab]
    @evento = Evento.new
  end

  # POST /eventos/programa
  def programa
    entrenador = User.find(params[:entrenador])
    inicio = Date.parse(params[:inicio])
    final = Date.parse(params[:final])
    dias = params[:dias].map! {|ele| ele.to_i }
    @tipoEvento = "Entrenamiento"

    entrenador.equipos.each do |equipo|
      for @fecha in (inicio..final) do
        if dias.include?(@fecha.wday)
          @equipo_id = equipo.id
          @evento = Evento.new(parametros_evento)
          if !@evento.save
            flash[:error] = "No ha sido posible crear los eventos."
            redirect_to root_path
          else
            flash[:success] = "Se han creado exitosamente los eventos."
          end
        end
      end
    end
    redirect_to eventos_path
  end

  # GET /eventos/form_borrar
  def form_borrar

  end

  # POST /eventos/borrar
  def borra
    inicio = Date.parse(params[:inicio])
    final = Date.parse(params[:final])
    even = Evento.where("fecha > '#{inicio}' AND fecha < '#{final}'")
    even.destroy_all
    flash[:success] = "Se eliminaron exitosamente los eventos."
    redirect_to eventos_url
  end

  private

    # Use callbacks to share common setup or constraints between actions.
    def set_evento
      @evento = Evento.find(params[:id])
    end

    # Set options to select from forms
    def set_equipos
      @equipos = Equipo.all
    end

    def set_tiposEvento
      @tiposEvento = ['Entrenamiento', 'Partido', 'Topes', 'Competencia', 'Ligas']
    end

    # Never trust big bad internet, always use strong params
    def evento_params
      params.require(:evento).permit(:fecha, :tipoEvento, :equipo_id, :comment, :registrado, :asistencias_attributes => [:evento_id, :player_id, :tipo, :comment])
    end

    # Alternate parameter assemble
    def parametros_evento
      evento = { :fecha => @fecha,
                  :tipoEvento => @tipoEvento,
                  :equipo_id => @equipo_id,
                  :comment => "",
                  :registrado => false
                }
    end
end
