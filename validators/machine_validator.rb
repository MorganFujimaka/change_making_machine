class MachineValidator < ActiveModel::Validator
  attr_reader :machine

  def validate(machine)
    @machine = machine

    validate_coins
  end

  private

  def validate_coins
    unless machine.coins.values.all? { |value| value >= 0 }
      machine.errors.add(:coins, "Quantity of coins can't be negative")
    end
  end
end
