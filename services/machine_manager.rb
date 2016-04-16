module MachineManager
  class InsufficientAmountError < RuntimeError; end

  extend Forwardable
  extend self

  def_delegator :machine, :coins

  DOLLAR = '100'.freeze
  HALF   =  '50'.freeze
  QUATER =  '25'.freeze
  PENNY  =   '1'.freeze

  def exchange(required_amount)
    raise InsufficientAmountError, 'Not enough money' if required_amount.to_i > available_amount

    change_set = ::ChangeSetService.change_set(required_amount)

    descrease_amount(change_set)

    { change_set: change_set, remainig_amount: "$#{available_amount}" }
  end

  def machine
    @machine ||= Machine.first_or_create
  end

  def update_machine(attributes)
    machine.update_attributes!(attributes)
  end

  def descrease_amount(change_set)
    attributes = {
      coins: {
        HALF => coins[HALF] - change_set[HALF],
        QUATER => coins[QUATER] - change_set[QUATER]
      }
    }

    update_machine(attributes)
  end

  def available_amount
    available_amount = coins.inject(0) do |result, (nominal, amount)|
      result + nominal.to_i * amount
    end

    ::SizeUtils.to_dollars(available_amount, PENNY)
  end

  def available_halfs
    coins[HALF]
  end

  def available_quaters
    available_quaters = coins[QUATER]

    # quaters amount in a change set always must be even
    available_quaters.even? ? available_quaters : available_quaters.pred
  end
end
