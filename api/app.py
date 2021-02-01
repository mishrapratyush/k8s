from flask import Flask
from flask import request
from flask import json, jsonify

import datetime

app = Flask(__name__)
app.config["DEBUG"] = True

@app.route('/', methods=['GET'])
def home():
    return "<h1>Hello World from Python </h1>"

@app.route('/device/<deviceId>', methods=['GET'])
def messages_by_device_id(deviceId):
    try:

        event_date = datetime.datetime.strptime(request.args.get('eventDate'), '%Y/%m/%d')
        all_messages = []
        filtered_messages = []

        with open('api/message_data.json', mode='r') as file_obj:
            msg_data = json.load(file_obj)

            all_messages = msg_data['messages']
            for msg in all_messages:
                msg_date = datetime.datetime.strptime(msg['EventTime'], '%Y-%m-%dT%H:%M:%S.%f')
                if(msg['DeviceId'] == deviceId and msg_date.date() == event_date.date()):
                    filtered_messages.append(msg)
        file_obj.close()
        if (len(filtered_messages) == 0 ):
            error_msg = f'No messages found for deviceId {deviceId} and event date {event_date.date()}'
            return jsonify( {"error": f'{error_msg}'} )
        else:
            return(jsonify(filtered_messages))
    
    except KeyError:
        return jsonify( {"exception": f'Exception processing request: Key {ex} not found'} )
    except Exception as ex:
        return jsonify( {"exception": f'Exception processing request: {ex}'} )

@app.route('/api/message', methods=['POST'])
def save_message():
    try:
        telemetry = json.loads(request.data)
        with open ('api/message_data.json', 'r') as file_obj:
            msg_data = json.load(file_obj)
            all_messages = msg_data['messages']
        file_obj.close()

        all_messages.append(telemetry)
        with open('api/message_data.json', 'w') as file_obj:
            file_obj.write(json.dumps(msg_data, indent=10))
        file_obj.close()

        return jsonify({"status": f'success'})
    except Exception as ex:
        return jsonify({"exception": f'Exception processing request: {ex}'})


if __name__ == "__main__":
    app.run(host='0.0.0.0')