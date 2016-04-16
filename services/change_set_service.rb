class ChangeSetService
  extend Forwardable

  def_delegator ::MachineManager, :available_halfs
  def_delegator ::MachineManager, :available_quaters
  def_delegator ::SizeUtils, :to_halfs
  def_delegator ::SizeUtils, :to_quaters

  attr_reader :required_amount

  def self.change_set(required_amount)
    new(required_amount).change_set
  end

  def initialize(required_amount)
    @required_amount = required_amount.to_i
  end

  def change_set
    return to_set(suitable_halfs, suitable_quaters) if suitable_set_available?

    # there is a shortfall of halfs or quaters unless suitable set is available
    halfs = halfs_shotrfall? ? available_halfs : quaters_shortfall
    quaters = quaters_shortfall? ? available_quaters : halfs_shotrfall

    to_set(halfs, quaters)
  end

  private

  def quaters_shortfall
    to_halfs(required_amount, ::MachineManager::DOLLAR) -
      to_halfs(available_quaters, ::MachineManager::QUATER)
  end

  def halfs_shotrfall
    to_quaters(required_amount, ::MachineManager::DOLLAR) -
      to_quaters(available_halfs, ::MachineManager::HALF)
  end

  def to_set(halfs, quaters)
    {
      ::MachineManager::HALF   => halfs.to_i,
      ::MachineManager::QUATER => quaters.to_i
    }
  end

  def suitable_set_available?
    !(halfs_shotrfall? || quaters_shortfall?)
  end

  # one half per 1 dollar
  def suitable_halfs
    required_amount
  end

  def halfs_shotrfall?
    suitable_halfs >= available_halfs
  end

  # two quarters per 1 dollar
  def suitable_quaters
    required_amount * 2
  end

  def quaters_shortfall?
    suitable_quaters >= available_quaters
  end
end
