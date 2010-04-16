class Release < ActiveRecord::Base
  def self.generate
    nouns = Word.find_all_by_speech_type_id(1)
    adjs = Word.find_all_by_speech_type_id(2)
    noun = nouns[rand(nouns.size)]
    adj = adjs[rand(adjs.size)]
    self.new :name => (adj.name + ' ' + noun.name)
  end
end
