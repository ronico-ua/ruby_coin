# frozen_string_literal: true

require 'rails_helper'

describe Admin::PostsController do
  describe 'GET #index' do
    let(:action) { :index }
    let(:params) { {} }

    context 'when admin is signed in' do
      before do
        admin_user = create(:user, role: :admin)
        sign_in(admin_user)
      end

      it_behaves_like 'has http success'
    end

    context 'when admin is not signed in' do
      it_behaves_like 'redirects to new_user_session_path'
    end
  end

  describe 'GET #show' do
    let(:test_post) { create(:post) }
    let(:action) { :show }
    let(:params) { { id: test_post.id } }

    context 'when admin is signed in' do
      before do
        admin_user = create(:user, role: :admin)
        sign_in(admin_user)
      end

      it_behaves_like 'has http success'
    end

    context 'when admin is not signed in' do
      it_behaves_like 'redirects to new_user_session_path'
    end
  end

  describe 'GET #new' do
    let(:action) { :new }
    let(:params) { {} }

    context 'when admin is signed in' do
      before do
        admin_user = create(:user, role: :admin)
        sign_in(admin_user)
      end

      it_behaves_like 'has http success'
    end

    context 'when admin is not signed in' do
      it_behaves_like 'redirects to new_user_session_path'
    end
  end

  describe 'GET #edit' do
    let(:test_post) { create(:post) }
    let(:action) { :edit }
    let(:params) { { id: test_post.id } }

    context 'when admin is signed in' do
      before do
        admin_user = create(:user, role: :admin)
        sign_in(admin_user)
      end

      it_behaves_like 'has http success'
    end

    context 'when admin is not signed in' do
      it_behaves_like 'redirects to new_user_session_path'
    end
  end

  describe 'PUT #update' do
    let(:test_post) { create(:post) }
    let(:action) { :update }
    let(:new_title) { 'Updated Title' }
    let(:params) { { id: test_post.id, post: { title: new_title } } }
    let(:second_post) { create(:post, main_post: false) }
    let(:params_status_true_second_post) { { id: second_post.id, post: { main_post: 'active' } } }
    let(:params_status_false_second_post) { { id: second_post.id, post: { main_post: 'inactive' } } }
    let(:third_post) { create(:post, main_post: true) }
    let(:params_status_true_third_post) { { id: third_post.id, post: { main_post: 'active' } } }
    let(:params_status_false_third_post) { { id: third_post.id, post: { main_post: 'inactive' } } }

    context 'when admin is signed in' do
      before do
        admin_user = create(:user, role: :admin)
        sign_in(admin_user)
      end

      context 'with valid attributes' do
        it 'updates the post' do
          get(action, params:)
          test_post.reload
          expect(test_post.title).to eq(new_title)
        end

        context 'when main-post is false' do
          it 'changes from false to true' do
            get(action, params: params_status_true_second_post)
            second_post.reload
            expect(second_post.main_post).to be(true)
          end

          it 'doesnt change' do
            get(action, params: params_status_false_second_post)
            second_post.reload
            expect(second_post.main_post).to be(false)
          end
        end

        context 'when main-post is true' do
          it 'changes from true to false' do
            get(action, params: params_status_false_third_post)
            third_post.reload
            expect(third_post.main_post).to be(false)
          end

          it 'doesnt change' do
            get(action, params: params_status_true_third_post)
            third_post.reload
            expect(third_post.main_post).to be(true)
          end
        end
      end

      context 'with invalid attributes' do
        it 'does not update the post' do
          expect(test_post.title).not_to be_nil
        end
      end
    end

    context 'when admin is not signed in' do
      it_behaves_like 'redirects to new_user_session_path'
    end
  end

  describe 'DELETE #destroy' do
    let(:test_post) { create(:post) }
    let(:action) { :destroy }
    let(:params) { { id: test_post.id } }

    context 'when admin is signed in' do
      before do
        admin_user = create(:user, role: :admin)
        sign_in(admin_user)
      end

      it 'deletes the post' do
        post_to_delete = create(:post)
        expect do
          delete :destroy, params: { id: post_to_delete.id }
        end.to change(Post, :count).by(-1)
      end
    end

    context 'when admin is not signed in' do
      it_behaves_like 'redirects to new_user_session_path'
    end
  end

  describe 'POST #create' do
    let(:valid_attributes) { attributes_for(:post) }
    let(:invalid_attributes) { attributes_for(:post, title: nil) }
    let(:action) { :create }
    let(:params) { { post: valid_attributes } }

    context 'when admin is signed in' do
      before do
        admin_user = create(:user, role: :admin)
        sign_in(admin_user)
      end

      context 'with valid attributes' do
        it 'creates a new post' do
          expect do
            post :create, params: { post: valid_attributes }
          end.to change(Post, :count).by(1)
        end

        it 'redirects to the new post' do
          post :create, params: { post: valid_attributes }
          expected_path = response.location
          expect(response).to redirect_to(expected_path)
        end
      end

      context 'with invalid attributes' do
        it 'does not create a new post' do
          expect do
            post :create, params: { post: invalid_attributes }
          end.not_to change(Post, :count)
        end

        it_behaves_like 'unprocessable_entity status'
      end
    end

    context 'when admin is not signed in' do
      it_behaves_like 'redirects to new_user_session_path'
    end
  end

  describe 'private method #post_params' do
    let(:tag_first) { create(:tag) }
    let(:tag_second) { create(:tag) }

    before do
      admin_user = create(:user, role: :admin)
      sign_in(admin_user)
    end

    it 'permits the expected parameters' do
      test_post = create(:post, tag_ids: [tag_first.id, tag_second.id])

      params = {
        post: {
          title: test_post.title,
          subtitle: test_post.subtitle,
          description: test_post.description,
          status: test_post.status,
          main_post: test_post.main_post,
          photo: test_post.photo,
          tag_ids: [tag_first.id, tag_second.id]
        }
      }

      controller.params = params
      permitted_params = controller.send(:post_params)
      expected_params = ActionController::Parameters.new(
        post: {
          title: test_post.title,
          subtitle: test_post.subtitle,
          description: test_post.description,
          status: test_post.status,
          main_post: test_post.main_post,
          photo: test_post.photo,
          tag_ids: [tag_first.id, tag_second.id]
        }
      )

      expect(permitted_params).to eq(expected_params.require(:post).permit(:title, :subtitle, :description, :status,
                                                                           :main_post, :photo, tag_ids: []))
    end
  end
end
