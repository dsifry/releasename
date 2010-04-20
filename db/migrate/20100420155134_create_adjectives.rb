class CreateAdjectives < ActiveRecord::Migration
  def self.up
    create_table :adjectives do |t|
      t.string :name
      
      t.timestamps
    end
  end

  def self.down
    drop_table :adjectives
  end
end
