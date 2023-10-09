# frozen_string_literal: true

require 'rails_helper'

describe 'Admin Posts', type: :system do
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
    page.execute_script("document.getElementById('add-img').style.opacity = '1';")
    attach_file('add-img', File.absolute_path('./spec/support/files/post-img.png'))
    sleep(5)
    page.execute_script("tinyMCE.get('default-editor').setContent('#{post.description}')")
    sleep(5)
    find_field('post_tag_ids-ts-control').set('Тег1')
    find_by_id('post_tag_ids-opt-1').click
    find('label', text: 'Статус').click
    sleep(1)
    find('label', text: 'Головний допис').click

    click_button I18n.t('global.button.create')
    sleep(1)

    expect(page).to have_content('Допис успішно створено')
    expect(page).to have_content(post.title)
    expect(page).to have_current_path(admin_posts_path)
  end

  it 'Delete a post' do
    post = create(:post)
    visit admin_root_path
    expect(page).to have_content(post.title)

    within('.post', text: post.title) do
      accept_confirm do
        find('.delete').click
      end
    end
    expect(page).to have_content('Пост успішно видалено')
    expect(page).not_to have_content(post.title)
  end
end
