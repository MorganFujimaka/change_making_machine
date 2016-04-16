module SizeUtils
  extend self

  def to_dollars(amount, nominal)
    amount * nominal.to_i.fdiv(100)
  end

  def to_halfs(amount, nominal)
    amount * nominal.to_i.fdiv(50)
  end

  def to_quaters(amount, nominal)
    amount * nominal.to_i.fdiv(25)
  end
end
