# frozen_string_literal: true

require 'rails_helper'

xdescribe 'Admin Posts', type: :system do
  let!(:tag) { create(:tag, title: 'Тег1') }
  let(:post) { create(:post, tag_ids: [tag.id]) }

  before do
    admin_user = create(:user, :admin)
    sign_in(admin_user)
  end

  context 'when create a new post' do
    it 'with valid data' do
      visit management_root_path
      click_link_or_button I18n.t('buttons.create')
      fill_in 'post_title', with: post.title
      fill_in 'post_subtitle', with: post.subtitle
      page.execute_script("document.getElementById('add-img').style.opacity = '1';")
      attach_file('add-img', File.absolute_path('./spec/support/files/post-img.png'))
      sleep(2)
      page.execute_script("tinyMCE.get('default-editor').setContent('#{post.description}')")
      sleep(1)
      find_field('post_tag_ids-ts-control').set('Тег1')
      find_by_id('post_tag_ids-opt-1').click
      find('label', text: 'Статус').click
      sleep(1)
      find('label', text: 'Головний допис').click

      click_link_or_button I18n.t('global.button.create')
      sleep(1)
      expect(page).to have_content('Допис успішно створено')
      expect(page).to have_content(post.title)
      expect(page).to have_current_path(management_posts_path)
    end

    it 'with invalid data' do
      visit management_root_path
      click_link_or_button I18n.t('buttons.create')

      find_field('post_tag_ids-ts-control').set('Тег1')
      find_by_id('post_tag_ids-opt-1').click

      click_link_or_button I18n.t('global.button.create')

      expect(page).to have_content('Заголовок не може бути порожнім')
      expect(page).to have_content('Підзаголовок не може бути порожнім')
      expect(page).to have_content('Опис не може бути порожнім')
      expect(page).to have_content('Фото не може бути порожнім')
    end
  end

  context 'when edit a post' do
    it 'with valid data' do
      post = create(:post)
      visit management_root_path
      within('.post', text: post.title) do
        find('.edit').click
      end

      fill_in 'post_title', with: 'Новий заголовок'
      fill_in 'post_subtitle', with: 'Новий підзаголовок'
      page.execute_script("document.getElementById('add-img').style.opacity = '1';")
      attach_file('add-img', File.absolute_path('./spec/support/files/post-img.png'))
      sleep(1)
      page.execute_script("tinyMCE.get('default-editor').setContent('#{post.description}')")
      sleep(1)
      find_field('post_tag_ids-ts-control').set('Тег1')
      find_by_id('post_tag_ids-opt-1').click
      sleep(1)
      click_link_or_button I18n.t('global.button.edit')
      sleep(1)

      expect(page).to have_content('Допис успішно оновлено')
      expect(page).to have_content('Новий заголовок')
      expect(page).to have_current_path(management_posts_path)
    end

    it 'with invalid data' do
      post = create(:post)
      visit management_root_path
      within('.post', text: post.title) do
        find('.edit').click
      end

      fill_in 'post_title', with: ''
      fill_in 'post_subtitle', with: ''
      page.execute_script("tinyMCE.get('default-editor').setContent('')")

      find_field('post_tag_ids-ts-control').set('Тег1')
      find_by_id('post_tag_ids-opt-1').click

      click_link_or_button I18n.t('global.button.edit')

      expect(page).to have_content('Заголовок не може бути порожнім')
      expect(page).to have_content('Підзаголовок не може бути порожнім')
      expect(page).to have_content('Опис не може бути порожнім')
    end
  end

  it 'Delete a post' do
    post = create(:post)
    visit management_root_path
    expect(page).to have_content(post.title)

    within('.post', text: post.title) do
      accept_confirm do
        find('.delete').click
      end
    end
    expect(page).to have_content('Допис успішно видалено')
    expect(page).to have_no_content(post.title)
  end
end
