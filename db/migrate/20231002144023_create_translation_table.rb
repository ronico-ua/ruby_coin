# frozen_string_literal: true

class CreateTranslationTable < ActiveRecord::Migration[7.0]
  def up
    change_column_null :posts, :slug, true

    unless table_exists?(:post_translations)
      Post.create_translation_table!({
                                       title: :string,
                                       subtitle: :string,
                                       description: :string,
                                       slug: :string
                                     }, {
                                       migrate_data: true
                                     })
    end

    Post.find_each(&:generate_slugs)
  end
end
