# frozen_string_literal: true

class CreateTranslationTable < ActiveRecord::Migration[7.0]
  def up
    change_column_null :posts, :slug, true
    return if table_exists?(:post_translations)

    post_params = { title: :string, subtitle: :string, description: :text }
    Post.create_translation_table!(post_params, { migrate_data: true })
  end
end
