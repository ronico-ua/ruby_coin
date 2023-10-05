# frozen_string_literal: true

require 'rails_helper'

describe 'Admin Posts', type: :system do
  let(:image_path) { Rails.root.join('spec', 'fixtures', 'files', 'example.jpg') }
  let(:tag) { create(:tag, title: 'Тег1') }
  let(:post) { build(:post, tag_ids: [tag.id]) }

  before do
    admin_user = create(:user, :admin_user)
    sign_in(admin_user)
  end

  it 'Create new post' do
    visit admin_root_path
    click_link I18n.t('buttons.create')
    fill_in 'post_title', with: post.title
    fill_in 'post_subtitle', with: post.subtitle
    sleep(5)
    page.execute_script("tinyMCE.get('default-editor').setContent('#{post.description}')")
    sleep(5)
    find_field('post_tag_ids-ts-control').set('Тег1')
    find_by_id('post_tag_ids-opt-1').click

    find('.toggle.btn.btn-danger.off input[type="checkbox"]').set(true)

    click_button 'Створити пост'

    expect(page).to have_content('Пост успішно створено')
    expect(page).to have_content(post.title)
    expect(page).to have_css("img[src*='example.jpg']")
  end
end
