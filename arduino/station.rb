require 'serialport'
require 'json'

# serialport params
port_str = "/dev/cu.usbmodem621"  #may be different for you
baud_rate = 9600
data_bits = 8
stop_bits = 1
parity = SerialPort::NONE

SerialPort.open(port_str, baud_rate, data_bits, stop_bits, parity) { |sp|
	while true do
		while (i = sp.gets.chomp) do
			puts i
		end
	end
}