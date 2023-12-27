# frozen_string_literal: true

require 'rails_helper'

xdescribe 'Admin Tags', type: :system do
  let!(:tag) { create(:tag, title: 'Тест') }

  before do
    admin_user = create(:user, :admin_user)
    sign_in(admin_user)
  end

  context 'when creating a new tag' do
    it 'with valid data' do
      visit management_tags_path
      fill_in 'tag_title', with: 'Новий тег'
      click_button I18n.t('global.button.create')

      expect(page).to have_content('Тег успішно створено')
      expect(page).to have_content('Новий тег')
    end

    it 'with invalid data' do
      visit management_tags_path
      click_button I18n.t('global.button.create')

      expect(page).to have_content('Заголовок не може бути пустим')
    end
  end

  context 'when editing an existing tag' do
    it 'with valid data' do
      visit management_tags_path
      find("#tag_#{tag.id} .edit").click
      within '.tag-editor' do
        fill_in 'tag_title', with: 'Редагований Тест'
        find('.save-tag').click
      end

      expect(page).to have_content('Тег успішно оновлено')
      expect(page).to have_content('Редагований Тест')
    end

    it 'with invalid data' do
      visit management_tags_path
      find("#tag_#{tag.id} .edit").click
      within '.tag-editor' do
        fill_in 'tag_title', with: ''
        find('.save-tag').click
      end

      expect(page).to have_content('Заголовок не може бути пустим')
    end
  end

  it 'Delete tag' do
    visit management_tags_path

    find("#tag_#{tag.id} .delete").click
    sleep(0.2)
    click_button I18n.t('buttons.yes_text')
    sleep(0.2)
    expect(page).to have_content('Тег успішно видалено')
  end
end
