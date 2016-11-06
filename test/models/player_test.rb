require 'test_helper'

class PlayerTest < ActiveSupport::TestCase

  def setup
    @equipo = equipos(:osos)
    @player = @equipo.players.build(apellidoPaterno: "Felix", apellidoMaterno: "Hernandez", nombres: "Juan",
                          fechaNacimiento: '2016-11-04', seccion: 'Primaria',
                          grupo: "3A", genero: 'Masc', beca: false)
  end

  test "should be valid" do
    assert @player.valid?
  end

  test "user_id should be present" do
    @player.equipo_id = nil
    assert_not @player.valid?
  end

  test "apellido paterno should be present" do
    @player.apellidoPaterno = nil
    assert_not @player.valid?
  end

  test "fecha de nacimiento should be present" do
    @player.fechaNacimiento = nil
    assert_not @player.valid?
  end

  test "order should show alphabetic ascending" do
    assert_equal players(:alba), Player.first
  end

end
