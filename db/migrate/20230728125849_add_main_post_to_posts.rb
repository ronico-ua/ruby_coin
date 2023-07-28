# frozen_string_literal: true

class AddMainPostToPosts < ActiveRecord::Migration[7.0]
  def change
    add_column :posts, :main_post, :boolean, default: false, null: false
  end
end
