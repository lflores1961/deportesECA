require 'test_helper'

class EquipoTest < ActiveSupport::TestCase

  def setup
    @user = users(:michael)
    @equipo = @user.equipos.build(name: "Osos", categoria: 1, deporte: "football", rama: "Varonil")
  end

  test "should be valid" do
    assert @equipo.valid?
  end

  test "user_id should be present" do
    @equipo.user_id = nil
    assert_not @equipo.valid?
  end

end
