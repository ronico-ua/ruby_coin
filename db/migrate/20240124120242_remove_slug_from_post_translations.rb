# frozen_string_literal: true

class RemoveSlugFromPostTranslations < ActiveRecord::Migration[7.1]
  def change
    remove_column :post_translations, :slug, :string
  end
end
