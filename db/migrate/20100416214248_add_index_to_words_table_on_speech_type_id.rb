class AddIndexToWordsTableOnSpeechTypeId < ActiveRecord::Migration
  def self.up
    add_index :words, :speech_type_id
  end

  def self.down
    remove_index :words, :speech_type_id
  end
end
