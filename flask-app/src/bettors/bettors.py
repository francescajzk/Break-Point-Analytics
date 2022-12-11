from flask import Blueprint, request, jsonify, make_response
import json
from src import db


customers = Blueprint('bettors', __name__)

# Get a player with particular playerID
@bettors.route('/player/<playerID>', methods=['GET'])
def get_player(playerID):
    cursor = db.get_db().cursor()
    cursor.execute('select * from player WHERE playerID = {0}'.format(playerID))
    row_headers = [x[0] for x in cursor.description]
    json_data = []
    theData = cursor.fetchall()
    for row in theData:
        json_data.append(dict(zip(row_headers, row)))
    the_response = make_response(jsonify(json_data))
    the_response.status_code = 200
    the_response.mimetype = 'application/json'
    return the_response
