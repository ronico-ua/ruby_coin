# frozen_string_literal: true

class CreateTranslationTable < ActiveRecord::Migration[7.0]
  def up
    Post.create_translation_table!({
                                     title: :string,
                                     subtitle: :string,
                                     description: :string
                                   }, {
                                     migrate_data: true
                                   })
  end

  def down
    Post.drop_translation_table!
  end
end
