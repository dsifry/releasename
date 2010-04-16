class Word < ActiveRecord::Base
  belongs_to :speech_type

  def speech_type=(val)
    self.speech_type_id = val.to_i
  end
end
