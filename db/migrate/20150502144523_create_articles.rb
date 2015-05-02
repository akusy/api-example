class CreateArticles < ActiveRecord::Migration
  def change
    create_table :articles do |t|
      t.string :name, null: false
      t.text :content, null: false
      t.references :user, index: true, null: false

      t.timestamps null: false
    end
  end
end
