class Noun < ActiveRecord::Base
  cattr_reader :per_page
  @@per_page = 50

  def self.random
    self.find(:first, :offset => rand(self.count()))
  end

end
