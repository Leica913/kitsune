class CreateArticlesGenres < ActiveRecord::Migration[5.2]
  def change
    create_table :articles_genres do |t|
      t.string :name

      t.timestamps
    end
  end
end
