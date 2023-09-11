# frozen_string_literal: true

shared_examples 'redirects to new_user_session_path' do
  it 'redirects to new_user_session_path' do
    get(action, params:)
    expect(response).to redirect_to(new_user_session_path)
  end
end

shared_examples 'has http success' do
  it 'responds with success' do
    get(action, params:)
    expect(response).to have_http_status(:success)
  end
end

shared_examples 'unprocessable_entity status' do
  it 'responds with unprocessable_entity status' do
    get(action, params:)
    expect(response).to have_http_status(:unprocessable_entity)
  end
end
