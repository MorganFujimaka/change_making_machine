require './validators/machine_validator'

class Machine
  include Mongoid::Document

  field :coins, type: Hash, default: { '50' => 0, '25' => 0 }

  validates_with ::MachineValidator
end