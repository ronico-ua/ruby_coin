# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Posts::Search do
  describe '#call' do
    context 'when the query is blank' do
      it 'returns nil' do
        expect(described_class.call({})).to be_nil
      end
    end

    context 'when the query is present' do
      let!(:ruby_post) { create(:post, title: 'Ruby', description: 'Rails') }
      let!(:rails_post) { create(:post, title: 'Rails', description: 'Ruby') }
      let!(:ruby_on_rails_post) { create(:post, title: 'Ruby on Rails', description: 'May the Force be with you') }
      let!(:inactive_post) { create(:post, title: 'Ruby on Rails', description: 'Ruby on Rails', status: 'inactive') }

      search_scopes = {
        all: {
          Ruby: '[ruby_post, rails_post, ruby_on_rails_post]',
          Rails: '[ruby_post, rails_post, ruby_on_rails_post]',
          'Ruby on Rails': '[ruby_post, rails_post, ruby_on_rails_post]'
        },
        title: {
          Ruby: '[ruby_post, ruby_on_rails_post]',
          Rails: '[rails_post, ruby_on_rails_post]',
          'Ruby on Rails': '[ruby_post, rails_post, ruby_on_rails_post]'
        },
        description: {
          Ruby: '[rails_post]',
          Rails: '[ruby_post]',
          'Ruby on Rails': '[ruby_post, rails_post]'
        },
        nil: {
          Ruby: '[ruby_post, rails_post, ruby_on_rails_post]',
          Rails: '[ruby_post, rails_post, ruby_on_rails_post]',
          'Ruby on Rails': '[ruby_post, rails_post, ruby_on_rails_post]'
        }
      }

      search_scopes.each do |scope, params|
        context "when pg_scope is #{scope}" do
          params.each do |query, collection|
            it "returns results with query #{query}" do
              expect(described_class.call({ query:, search_in: scope.to_s }).count).to eq(eval(collection).count)
            end
          end
        end
      end
    end
  end
end
