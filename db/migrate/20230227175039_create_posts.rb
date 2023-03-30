# frozen_string_literal: true

class CreatePosts < ActiveRecord::Migration[7.0]
  def change
    create_table :posts do |t|
      t.string :title
      t.string :description
      t.string :photo
      t.integer :status
      t.belongs_to :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
