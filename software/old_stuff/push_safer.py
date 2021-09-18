import urequests as requests

def push_safer(message, voltage):
	try:
		headers = {'Content-Type': 'application/x-www-form-urlencoded'}
		url = 'http://www.pushsafer.com/api' # Set destination URL here
		
		key ='J2QADTIyXoMqFM11WTpZ'
		device_id = 28915

		res = requests.post(url, data='t=Battery+Isolator&m=' + str(message) + str(voltage) + 'V' + '&s=4&v=2&i=1&c=%23FF0000&d=' + str(device_id) + '&u=http%3A%2F%2Fwww.pushsafer.com&ut=Open+Pushsafer&k=' + str(key), headers=headers )
		print("PUSH RESPONSE: ", res.text)
	except Exception:
		print("CAN'T SEND PUSH MESSAGES")
