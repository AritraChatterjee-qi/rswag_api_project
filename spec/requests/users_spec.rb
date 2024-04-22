require 'swagger_helper'

RSpec.describe 'users', type: :request do

  path '/users' do

    get('list users') do
      response(200, 'successful') do

        after do |example|
          example.metadata[:response][:content] = {
            'application/json' => {
              example: JSON.parse(response.body, symbolize_names: true)
            }
          }
        end
        run_test!
      end
    end

    post('create user') do
      response(200, 'successful') do

        after do |example|
          example.metadata[:response][:content] = {
            'application/json' => {
              example: JSON.parse(response.body, symbolize_names: true)
            }
          }
        end
        run_test!
      end
    end
  end

  path '/users/{id}' do
    # You'll want to customize the parameter types...
    parameter name: 'id', in: :path, type: :string, description: 'id'

    get('show user') do
      response(200, 'successful') do
        let(:id) { '123' }

        after do |example|
          example.metadata[:response][:content] = {
            'application/json' => {
              example: JSON.parse(response.body, symbolize_names: true)
            }
          }
        end
        run_test!
      end
    end

    patch('update user') do
      response(200, 'successful') do
        let(:id) { '123' }

        after do |example|
          example.metadata[:response][:content] = {
            'application/json' => {
              example: JSON.parse(response.body, symbolize_names: true)
            }
          }
        end
        run_test!
      end
    end

    put('update user') do
      response(200, 'successful') do
        let(:id) { '123' }

        after do |example|
          example.metadata[:response][:content] = {
            'application/json' => {
              example: JSON.parse(response.body, symbolize_names: true)
            }
          }
        end
        run_test!
      end
    end

    delete('delete user') do
      response(200, 'successful') do
        let(:id) { '123' }

        after do |example|
          example.metadata[:response][:content] = {
            'application/json' => {
              example: JSON.parse(response.body, symbolize_names: true)
            }
          }
        end
        run_test!
      end
    end
  end

  path '/users/{id}/change_status' do
    patch('change status') do
      tags 'Status'
      consumes 'application/json'
      parameter name: :data, in: :body, schema: {
        type: :object,
        properties: {
          id: { type: :string },
          user_id: { type: :string },
          status: { type: :string }
        },
        required: [ 'id', 'user_id', 'status' ]
      }
      parameter name: :data, in: :path, schema: {
        type: :integer,
        required: [ 'id' ]
      }

      response '404', 'user not found' do
        let(:data) { { user_id: '123456', status: 'true' } }
        run_test! do |response|
          data = JSON.parse(response.body)
          expect(data["error"]).to eq("status value is not provided")
          expect(response).to have_http_status(404)
        end
      end

      response '422', 'invalid request, status not provided' do
        let(:data) { { user_id: '123456' } }
        run_test! do |response|
          data = JSON.parse(response.body)
          expect(data["error"]).to eq("status value is not provided")
          expect(response).to have_http_status(422)
        end
      end

      response '202', 'user status updated succesfully' do
        user = User.create
        let(:data) { { user_id: user.id, status: 'true' } }
        run_test! do |response|
          data = JSON.parse(response.body)
          expect(response).to have_http_status(204)
        end
      end
    end
  end
end
