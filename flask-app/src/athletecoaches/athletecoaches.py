from flask import Blueprint, request, jsonify, make_response
import json
from src import db


products = Blueprint('athletecoaches', __name__)

# Get a player with particular playerID
@athletecoaches.route('/player/<playerID>', methods=['GET'])
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

# get the matches won by given player
@athletecoaches.route('/playerwonmatches/<playerID>', methods=['GET'])
def get_wins(playerID):
    cursor = db.get_db().cursor()
    cursor.execute('select * from matchInfo WHERE winnerID = {0}'.format(playerID))
    row_headers = [x[0] for x in cursor.description]
    json_data = []
    theData = cursor.fetchall()
    for row in theData:
        json_data.append(dict(zip(row_headers, row)))
    the_response = make_response(jsonify(json_data))
    the_response.status_code = 200
    the_response.mimetype = 'application/json'
    return the_response

# get the matches lost by given player
@athletecoaches.route('/playerlostmatches/<playerID>', methods=['GET'])
def get_losses(playerID):
    cursor = db.get_db().cursor()
    cursor.execute('select * from matchInfo WHERE loserID = {0}'.format(playerID))
    row_headers = [x[0] for x in cursor.description]
    json_data = []
    theData = cursor.fetchall()
    for row in theData:
        json_data.append(dict(zip(row_headers, row)))
    the_response = make_response(jsonify(json_data))
    the_response.status_code = 200
    the_response.mimetype = 'application/json'
    return the_response

# Get match schedule info with particular matchID
@athletecoaches.route('/matchschedule/<matchID>', methods=['GET'])
def get_matchschedule(matchID):
    cursor = db.get_db().cursor()
    cursor.execute('select * from matchSchedule WHERE matchID = {0}'.format(matchID))
    row_headers = [x[0] for x in cursor.description]
    json_data = []
    theData = cursor.fetchall()
    for row in theData:
        json_data.append(dict(zip(row_headers, row)))
    the_response = make_response(jsonify(json_data))
    the_response.status_code = 200
    the_response.mimetype = 'application/json'
    return the_response
