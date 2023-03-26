class AddPhotoToPosts < ActiveRecord::Migration[7.0]
  def change
    add_column :posts, :photo, :string
  end
end
