require './config/environment'

use Rack::MethodOverride

use SessionsController
use UsersController
use NotesController
use ShopsController
run ApplicationController
