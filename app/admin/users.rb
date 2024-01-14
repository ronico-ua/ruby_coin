# frozen_string_literal: true

# rubocop:disable Metrics/BlockLength
ActiveAdmin.register User do
  permit_params :nickname, :avatar, :role, :email, :password, :password_confirmation, :confirmed_at, :unconfirmed_email

  menu priority: 4, label: proc { I18n.t('active_admin.users') }

  config.sort_order = 'id_asc'

  scope :all, default: true
  scope :admin, group: :role
  scope :moderator, group: :role
  scope :user, group: :role
  scope :confirmed, group: :status
  scope :unconfirmed, group: :status

  filter :nickname
  filter :email
  filter :role

  batch_action :confirm do |ids|
    User.find(ids).each do |user|
      user.confirm! unless user.confirmed?
    end
    redirect_to collection_path, alert: I18n.t('active_admin.users_controller.confirm.success')
  end

  index do
    selectable_column
    id_column
    column :avatar do |user|
      if user.avatar.present?
        image_tag url_for(user.avatar.lite.url)
      else
        content_tag :div, '', class: 'default-avatar'
      end
    end
    column :nickname do |user|
      link_to user.nickname, admin_user_path(user)
    end
    column :email
    column :role
    column :confirmed_at do |user|
      if user.confirmed?
        status_tag I18n.t('active_admin.good'), class: 'yes'
      else
        status_tag I18n.t('active_admin.bad'), class: 'no'
      end
    end
    column :created_at
    column :unconfirmed_email
    actions
  end

  form do |f|
    f.inputs do
      f.input :email
      f.input :nickname
      f.input :role
      f.input :avatar
      f.input :password
      f.input :password_confirmation
      f.input :confirmed_at
    end
    f.actions
  end
end
# rubocop:enable Metrics/BlockLength
