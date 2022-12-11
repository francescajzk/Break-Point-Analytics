from flask import Flask, jsonify
from flaskext.mysql import MySQL

app = Flask(__name__)

app.config['MYSQL_DATABASE_HOST'] = 'db'
app.config['MYSQL_DATABASE_PORT'] = 3306
app.config['MYSQL_DATABASE_USER'] = 'webapp'
app.config['MYSQL_DATABASE_PASSWORD'] = 'abc123'
app.config['MYSQL_DATABASE_DB'] = 'bp_analytics_db'

db_connection = MYSQL()
db_connection.init_app(app)

# import the create app function 
# that lives in src/__init__.py
from src import create_app

# create the app object
app = create_app()

if __name__ == '__main__':
    # we want to run in debug mode (for hot reloading) 
    # this app will be bound to port 4000. 
    # Take a look at the docker-compose.yml to see 
    # what port this might be mapped to... 
    app.run(debug = True, host = '0.0.0.0', port = 4000)