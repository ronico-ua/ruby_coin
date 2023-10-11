# frozen_string_literal: true

class Posts::Builder < BaseService
  attr_accessor :user, :params

  def initialize(user, params)
    @user = user
    @params = params
  end

  def call
    user.posts.build(current_locale_params)
  end

  private

  def current_locale_params
    current_params = {}

    params.each do |key, value|
      new_value = value.is_a?(ActionController::Parameters) ? value[I18n.locale] : value

      current_params[key] = new_value
    end

    current_params
  end
end
