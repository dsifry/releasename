# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_releasename_session',
  :secret      => 'e96431145da9b63be1ce1457c7a0ec51f156d1087db8fd2cc076f51450ec69cd49eac2d726d77dc80507f86214b83933081d793d0f267e2087fb2588c6ad7797'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
