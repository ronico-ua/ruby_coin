# frozen_string_literal: true

module Admin::UsersHelper
  def user_avatar_column(user)
    if user.avatar.present?
      image_tag url_for(user.avatar.lite.url)
    else
      content_tag :div, '', class: 'default-avatar'
    end
  end

  def user_confirmed_at_column(user)
    if user.confirmed?
      Arbre::Context.new { status_tag I18n.t('active_admin.good'), class: 'yes' }
    else
      link_to 'Confirm', confirm_admin_user_path(user), method: :put, class: 'button-confirm'
      # Arbre::Context.new { status_tag I18n.t('active_admin.bad'), class: 'no' }
    end
  end
end
