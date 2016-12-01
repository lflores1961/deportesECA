class AsistenciasController < ApplicationController
  def new
  end

  def create
    @asiste = Asistencia.new(asistencia_params)

    if @asiste.save
      flash[:success] = "Se registró exitosamente la asistencia"
      redirect_back eventoPlayers_url
    else

    end
  end

  private

    def asistencia_params
      params.require(:asistencia).permit(:evento_id, :player_id, :tipo, :comment)
    end
end
