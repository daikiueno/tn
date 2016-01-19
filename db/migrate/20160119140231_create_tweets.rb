class CreateTweets < ActiveRecord::Migration[5.0]
  def change
    create_table :tweets do |t|
      t.text :content
      t.string :name, null: false, default: '名無しさん'
      t.integer :fav, null: false, default: 0
      t.timestamps
    end
  end
end
