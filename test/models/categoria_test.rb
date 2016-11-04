require 'test_helper'

class CategoriaTest < ActiveSupport::TestCase

  def setup
    @categoria = Categoria.new(nombre: "Pewee", limInferior: Date.today, limSuperior: Date.today)
  end

  test "should be valid" do
    assert @categoria.valid?
  end

  test "nombre should be present" do
    @categoria.nombre = nil
    assert_not @categoria.valid?
  end

  test "limInferior must be present" do
    @categoria.limInferior = nil
    assert_not @categoria.valid?
  end

  test "limSuperior must be present" do
    @categoria.limSuperior = nil
    assert_not @categoria.valid?
  end

end
