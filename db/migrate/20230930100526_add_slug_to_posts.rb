# frozen_string_literal: true

class AddSlugToPosts < ActiveRecord::Migration[7.0]
  def up
    add_column :posts, :slug, :string
    add_index :posts, :slug, unique: true

    Post.find_each(&:save)

    change_column_null :posts, :slug, false
  end

  def down
    remove_index :posts, :slug
    remove_column :posts, :slug
  end
end
