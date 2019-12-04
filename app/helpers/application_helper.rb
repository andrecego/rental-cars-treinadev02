module ApplicationHelper
  def number_to_real(number)
    number_to_currency(number, :unit => "R$ ", :separator => ",", :delimiter => ".")
  end
end
