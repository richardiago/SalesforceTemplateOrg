import json
import requests

# Authenticate and create a Salesforce session

# Define the authentication parameters
client_id     = '3MVG99gP.VbJma8XAt3ozCm4fcR2uShDI_V0zoGYt56haPPfQVyhF.uPGsvYvwFJ.Q2fZWwh6YnZ5AVTr40RO'
client_secret = 'BFDE246AFA1E818B29DA61C296A68C8441905849FE4C92DB0B74EB0C20F1E798'
username      = 'iagorichard@resourceful-badger-a8o4n1.com'
password      = 'Belinha@02BIwXlX8gskYY1DMlvK7CgCS1'

# Set up the authentication requests
auth_url = 'https://login.salesforce.com/services/oauth2/token'
auth_data = {
    'grant_type': 'password',
    'client_id': client_id,
    'client_secret': client_secret,
    'username': username,
    'password': password
}

# Send the authentication request
auth_response = requests.post(auth_url, data=auth_data)
auth_response_json = auth_response.json()
#print(auth_response_json)

# Retrieve the access token
access_token = auth_response_json['access_token']

# Subscribe to the platform event channel
headers = {'Authorization': 'OAuth ' + access_token, 'Content-Type': 'application/json'}
body = {'replayId': -1, 'channel': '/event/Nebula__LogEntryEvent__e'}
response = requests.post('https://resourceful-badger-a8o4n1-dev-ed.trailblaze.my.salesforce.com/cometd/53.0', headers=headers, json=body)
response_json = json.loads(response.text)
print(response_json)
clientId = response_json[0]['clientId']
advice = response_json[0]['advice']

# Use long polling to retrieve the events
headers = {'Authorization': 'Bearer ' + access_token, 'Content-Type': 'application/json'}
params = {'clientId': clientId, 'advice': advice}
response = requests.post('https://resourceful-badger-a8o4n1-dev-ed.trailblaze.my.salesforce.com/cometd/53.0', headers=headers, params=params, stream=True)
for line in response.iter_lines():
    if line:
        message = json.loads(line.decode('utf-8'))
        print(message)