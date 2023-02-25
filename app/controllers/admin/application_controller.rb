# frozen_string_literal: true

module Admin
  class ApplicationController < ActionController::Base
    layout 'admin/layouts/application'

    # before_action :authenticate_user!
  end
end
