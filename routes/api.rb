class API < Cuba; end

API.define do
  res.headers['Content-Type'] = 'application/json'

  on get do
    on 'exchange' do
      on param('amount') do |required_amount|
        res.write JSON.dump(MachineManager.exchange(required_amount))
      end

      on true do
        res.write JSON.dump(error: 'You must pass `amount` param')
      end
    end

    on 'available_amount' do
      res.write JSON.dump(available_amount: "$#{MachineManager.available_amount}")
    end

    on 'fill' do
      on param(MachineManager::HALF), param(MachineManager::QUATER) do |half, quarter|
        attributes = {
          coins: { MachineManager::HALF => half.to_i, MachineManager::QUATER => quarter.to_i }
        }

        MachineManager.update_machine(attributes)

        res.write JSON.dump(available_coins: MachineManager.coins)
      end

      on true do
        res.write JSON.dump(error: 'You must pass amounts for half and quater coins as params')
      end
    end
  end
end
