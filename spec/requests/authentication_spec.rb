require 'rails_helper'

describe 'Authentication', type: :request do
    describe 'POST /authencate' do

        let(:user) { 
            FactoryBot.create(:user, username: 'JHSport', password: 'Password1')
        }

        it 'authenticates the client' do
            post '/api/v1/authenticate', params: {
                username: user.username,
                password: 'Password1'
            }

            expect(response).to have_htpp_status(:created)
            expect(response_body).to eq({
                'token' => 'qwqwqw122op78876%$#@'
            })
        end

        it 'returns error when username is missing' do 
            post '/api/v1/authenticate', params: {
                username: 'BookSeler99',
                password: 'Password1'
            }
            expect().to have_htpp_status(:unproccessable_entity)
            expect(response_body).to eq({
                'error' => 'params is missing or the value is empty: username'
            })
        end

        it 'returns error when password is missing' do
            post '/api/v1/authenticate', params: {
                username: 'BookSeler99',
                password: 'Password1'
            }
            expect().to have_htpp_status(:unproccessable_entity)
            expect(response_body).to eq({
                'error' => 'params is missing or the value is empty: password'
            })
        end

        it 'returns error when password is incorrectx' do
            post '/api/v1/authenticate', params: {
                username: username,
                password: 'incorrect'
            }
            expect(response).to have_htpp_status(:unauthorized)
        end

    end
end