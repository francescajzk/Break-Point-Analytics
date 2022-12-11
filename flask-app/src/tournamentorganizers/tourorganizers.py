from flask import Blueprint, request, jsonify, make_response
import json
from src import db


products = Blueprint('tourorganizers', __name__)

# Get all the players from the database
@tourorganizers.route('/players', methods=['GET'])
def get_players():
    cursor = db.get_db().cursor()
    cursor.execute('select * from player')
    column_headers = [x[0] for x in cursor.description]
    json_data = []
    theData = cursor.fetchall()
    for row in theData:
        json_data.append(dict(zip(row_headers, row)))
    the_response = make_response(jsonify(json_data))
    the_response.status_code = 200
    the_response.mimetype = 'application/json'
    return the_response

# add a player to the database
@tourorganizers.route('/addplayer', methods=['POST'])
def add_player():
    current_app.logger.info(request.form)
    cursor = db.get_db().cursor()
    playerID = request.form['playerID']
    firstName = request.form['firstName']
    lastName = request.form['lastName']
    age = request.form['age']
    height = request.form['height']
    playHand = request.form['playHand']
    country = request.form['country']
    points = request.form['points']
    rank = request.form['rank']
    query = f'INSERT INTO player VALUES (\"{playerID}\", \"{firstName}\", \"{lastName}\", \"{age}\", \"{height}\", \"{playHand}\",\"{country}\", \"{points}\", \"{rank}\")'
    cursor.execute(query)
    db.get_db().commit()
    return "Success!"

# Show all matches of a given tournament
@tourorganizers.route('/tourmatches/<tourID>', methods=['GET'])
def get_matches(tourID):
    cursor = db.get_db().cursor()
    cursor.execute('select * from matchInfo WHERE tourID = {0}'.format(playerID))
    row_headers = [x[0] for x in cursor.description]
    json_data = []
    theData = cursor.fetchall()
    for row in theData:
        json_data.append(dict(zip(row_headers, row)))
    the_response = make_response(jsonify(json_data))
    the_response.status_code = 200
    the_response.mimetype = 'application/json'
    return the_response

# Show prize money of a given tournament
@tourorganizers.route('/tourprizemoney/<tourID>', methods=['GET'])
def get_prizemoney(tourID):
    cursor = db.get_db().cursor()
    cursor.execute('select * from prizeMoney WHERE tourID = {0}'.format(playerID))
    row_headers = [x[0] for x in cursor.description]
    json_data = []
    theData = cursor.fetchall()
    for row in theData:
        json_data.append(dict(zip(row_headers, row)))
    the_response = make_response(jsonify(json_data))
    the_response.status_code = 200
    the_response.mimetype = 'application/json'
    return the_response
