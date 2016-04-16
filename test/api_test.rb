require 'cuba/test'
require './app'

scope do
  test 'fill' do
    get '/api/fill?50=4&25=10'

    expected_response = {
      'available_coins' => { '50' => 4, '25' => 10 }
    }

    assert_equal expected_response, JSON.parse(last_response.body)
  end

  test 'available_amount' do
    get 'api/available_amount'

    expected_response = {
      'available_amount' => '$4.5'
    }

    assert_equal expected_response, JSON.parse(last_response.body)
  end

  test 'exchange' do
    get 'api/exchange?amount=4'

    expected_response = {
      'change_set' => { '50' => 4, '25' => 8 },
      'remainig_amount' => '$0.5'
    }

    assert_equal expected_response, JSON.parse(last_response.body)
  end
end