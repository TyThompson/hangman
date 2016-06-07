class CreateGameTable < ActiveRecord::Migration
  def change
    create_table :games do |t|
      t.string :name
      t.integer :games_won
      t.integer :games_played
      t.array :guessed_letters
      t.string :word
      end
    end
end
