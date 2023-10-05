# frozen_string_literal: true

require 'rails_helper'

describe 'Admin Tags', type: :system do
  let!(:tag) { create(:tag, title: 'Тест') }

  before do
    admin_user = create(:user, :admin_user)
    sign_in(admin_user)
  end

  it 'Create a new tag' do
    visit admin_tags_path
    fill_in 'tag_title', with: 'Новий тег'
    click_on I18n.t('global.button.create')

    expect(page).to have_content('Тег успішно створено')
    expect(page).to have_content('Новий тег')
  end

  it 'Edit an existing tag' do
    visit admin_tags_path

    find("#tag_#{tag.id} .edit").click
    within '.tag-editor' do
      fill_in 'tag_title', with: 'Редагований Тест'
      find('.save-tag').click
    end

    expect(page).to have_content('Тег успішно оновлено')
    expect(page).to have_content('Редагований Тест')
  end

  it 'Delete tag' do
    visit admin_tags_path

    find("#tag_#{tag.id} .delete").click

    click_button 'Так'

    expect(page).to have_content('Тег успішно видалено')
  end
end
