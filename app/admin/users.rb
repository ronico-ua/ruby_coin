# frozen_string_literal: true

ActiveAdmin.register User do
  permit_params :nickname, :avatar, :role, :email, :password, :password_confirmation, :confirmed_at, :unconfirmed_email

  scope :all, default: true
  scope :admin
  scope :moderator
  scope :user

  filter :nickname
  filter :email
  filter :role

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
