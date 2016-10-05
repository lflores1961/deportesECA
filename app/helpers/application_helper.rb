module ApplicationHelper
  class Programmer
  end

  class Fernando_Flores < Programmer
         attr_reader :email, :phone, :web
    def initialize
      @email = %[ fernando.flores1961@gmail.com ]
      @phone = { :mobile  => '(449) 264 6604',
                 :home    => '(449) 915 9633' }
      @web   = %[ http://luisflores.wordpress.com ]
    end
  end

  $luis = Fernando_Flores.new

  # Returns the full title on a per-page basis.
  def full_title(page_title = '')
    base_title = "Deportes ECA"
    if page_title.empty?
      base_title
    else
      page_title + " | " + base_title
    end
  end
end
