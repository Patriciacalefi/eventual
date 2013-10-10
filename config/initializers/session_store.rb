# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_eventaul_session',
  :secret      => 'ad7de95df05da630616d973f3f97db0d5f98e4e1ec7fc51afb577eb055cfe6737c7abb5ade7614db9a5a9a018e2974bccaba3020aabd4fe146c62289f2301f50'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
