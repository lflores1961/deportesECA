class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def hello
    render html: "Escuela de la Ciudad de Aguascalientes"
    render html: "         work in progress "
  end
end
