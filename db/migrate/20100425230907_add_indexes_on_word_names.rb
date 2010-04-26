class AddIndexesOnWordNames < ActiveRecord::Migration
  def self.up
    add_index :nouns, :name
    add_index :adjectives, :name
  end

  def self.down
    remove_index :adjectives, :name
    remove_index :nouns, :name
  end
end
