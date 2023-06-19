require "rails_helper"

describe AuthenticationTokenService do
  describe '.call' do

    let(:token) { described_class.call(1) }

    it 'returns an authentication token' do

        token = described_class.call
        decoded_token = JWT.decode(
            token, 
            described_class.call::HMAC_SECRET,
            true,
            { algorithm: described_class::ALGORITHM_TYPE }
        )

        expect(decoded_token).to eq(
            [
                { "user_id" => "blah" },
                { "alg" => "HS256" }
            ]
        )

    end
  end
end