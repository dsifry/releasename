authorization do
  role :admin do
    has_permission_on [:adjectives, :nouns, :releases, :roles, :users, :user_sessions], :to => [:index, :show, :new, :create, :edit, :update, :destroy, :import]
  end
  role :guest do
    has_permission_on :releases, :to => [:index, :show, :new, :create]
    has_permission_on :adjectives, :to => [:index, :show]
    has_permission_on :nouns, :to => [:index, :show]
    has_permission_on :users, :to => [:new, :create, :update]
  end
end