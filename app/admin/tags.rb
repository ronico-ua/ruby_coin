# frozen_string_literal: true

ActiveAdmin.register Tag do
  permit_params :title

  menu priority: 3, label: proc { I18n.t('active_admin.tags') }

  index do
    selectable_column
    id_column
    column :title
    column :updated_at
    column :created_at
    actions
  end

  scope :all, default: true
  scope :news

  filter :title
  filter :created_at
  filter :updated_at
end
