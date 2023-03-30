# frozen_string_literal: true

class CreateJoinTablePostsTags < ActiveRecord::Migration[7.0]
  def change
    create_join_table :posts, :tags do |t|
      t.index %i[post_id tag_id]
      t.index %i[tag_id post_id]
    end
  end
end
