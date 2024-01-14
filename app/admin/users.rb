# frozen_string_literal: true

# rubocop:disable Metrics/BlockLength
ActiveAdmin.register User do
  permit_params :nickname, :avatar, :role, :email, :password, :password_confirmation, :confirmed_at, :unconfirmed_email

  menu priority: 4, label: proc { I18n.t('active_admin.users') }

  config.sort_order = 'id_asc'

  scope :all, default: true
  User.roles.each_key do |role|
    scope role.humanize, role.to_sym.to_s, group: :role
  end

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
      user_avatar_column(user)
    end
    column :nickname do |user|
      link_to user.nickname, admin_user_path(user)
    end
    column :email
    column :role
    column :confirmed_at do |user|
      user_confirmed_at_column(user)
    end
    column :created_at
    column :unconfirmed_email
    actions
  end

  form partial: 'form'

  controller do
    def update
      if params[:user][:password].blank?
        params[:user].delete('password')
        params[:user].delete('password_confirmation')
      end
      super
    end
  end

  member_action :confirm, method: :put do
    resource.confirm!
    redirect_to collection_path, notice: I18n.t('active_admin.users_controller.confirm.success')
  end
end
# rubocop:enable Metrics/BlockLength
