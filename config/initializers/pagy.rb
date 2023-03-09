# frozen_string_literal: true
require 'pagy/extras/bootstrap'

Pagy::DEFAULT[:size] = [1, 3, 3, 1]
Pagy::I18n.load({ locale: "en" },
                { locale: "uk" })
