require './config/environment'

use Rack::MethodOverride

use SessionsController
use UsersController
use TeasController
use NotesController
use ShopsController
run ApplicationController
