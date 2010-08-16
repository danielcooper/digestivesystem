# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_digestivesystem_session',
  :secret      => '85bf34fae4cd7bffec60822aa48f5820a86d5b7dc62e0cb3259ccb5227ecccfc75272eac919c3f1f4c777ce5fd5a8db04ab8ea610fae8a10e0c1300cc14d1730'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
