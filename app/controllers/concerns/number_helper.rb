module NumberHelper
  def is_integer?(string)
    num = string.to_i
    num.to_s == string && num.is_a?(Integer)
  end
end
