

##############################################################################
# Sqlite3
##############################################################################
require "sinatra"
require "sinatra/activerecord"

set :database, "sqlite3:ganeti.db"