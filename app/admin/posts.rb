# frozen_string_literal: true

ActiveAdmin.register Post do # rubocop:disable Metrics/BlockLength
  permit_params :photo, :status, :user_id, :main_post, :title, :subtitle, :description, :slug

  menu priority: 2, label: proc { I18n.t('active_admin.posts') }

  index do
    selectable_column
    id_column
    column :status
    column :main_post
    column :title
    column :slug
    column :subtitle
    column :description
    column :user
    column :photo
    column :created_at
    actions
  end

  scope :all, default: true
  scope :new_main, group: :date
  scope :new_regular, group: :date
  scope :main, group: :status
  scope :active, group: :status
  scope :inactive, group: :status

  filter :user, as: :select, collection: User.pluck([:email, :id])
  filter :title, as: :string
  filter :subtitle, as: :string

  form do |f|
    f.inputs do
      f.input :title
      f.input :subtitle
      f.input :description
      f.input :main_post
      f.input :user, as: :select, collection: User.pluck([:email, :id])
      f.input :photo
      f.input :status
    end
    f.actions
  end
end
