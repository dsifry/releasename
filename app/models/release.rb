class Release < ActiveRecord::Base
    
  def self.generate
    noun = Noun.random
    adj = Adjective.random
    self.new :name => (adj.name + ' ' + noun.name).titleize
  end
end
