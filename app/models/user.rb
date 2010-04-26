class User < ActiveRecord::Base
  has_and_belongs_to_many :roles
  acts_as_authentic

  def role_symbols
    roles.map do |role|
      role.name.underscore.to_sym
    end
  end
end
