require 'sinatra'
require 'json'
require 'serialport'

def readArduinoOnce()
	# Configure serialport
	port_str = "/dev/cu.usbmodem621"
	baud_rate = 9600
	data_bits = 8
	stop_bits = 1
	parity = SerialPort::NONE

	i = ""

	SerialPort.open(port_str, baud_rate, data_bits, stop_bits, parity) { |sp|
		# Read serial twice to avoid chompy reading
		puts "Getting the readings..."
		i = sp.gets.chomp
		i = sp.gets.chomp
		i = i.gsub("\'", "\"")
	}

	return i
end

set :port, 7777
set :enviroment, :production

set :protection, false

get '/reading' do

	content_type :json

	headers 'Access-Control-Allow-Origin' => '*',
            'Access-Control-Allow-Methods' => ['OPTIONS', 'GET', 'POST']

	return_message = readArduinoOnce()
end