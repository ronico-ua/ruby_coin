# frozen_string_literal: true

class CreateTranslationTable < ActiveRecord::Migration[7.0]
  def up
    Post.create_translation_table!({
                                     title: string,
                                     description: string
                                   }, {
                                     migrate_data: true
                                   })
  end

  def down
    Post.drop_translation_table! migrate_data: true
  end
end
