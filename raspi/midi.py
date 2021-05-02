import sys, rtmidi, threading
import RPi.GPIO as GPIO
from time import sleep

clk = 16
rst = 18
data_pins = [7, 11, 13, 15, 19, 21, 23, 29]
GPIO.setmode(GPIO.BOARD)
GPIO.setup(clk, GPIO.OUT)
GPIO.setup(rst, GPIO.OUT)
GPIO.setup(data_pins, GPIO.OUT)


def send_byte(bytemsg, start):
	GPIO.output(clk, 0)
	GPIO.output(rst, start)
	values = [(bytemsg >> i) % 2 for i in range(0, 8)]
	print(values, start)
	GPIO.output(data_pins, values)
	GPIO.output(clk, 1)
	sleep(.001)
	GPIO.output(clk, 0)

def send_msg(msg):
	for i in range(3):
		print(msg[i])
		send_byte(msg[i], (i==0))
	return

def print_message(midi, port):
	if midi.isNoteOn():
		print('%s: ON: ' % port, midi.getMidiNoteName(midi.getNoteNumber()), midi.getVelocity())
	elif midi.isNoteOff():
		print('%s: OFF:' % port, midi.getMidiNoteName(midi.getNoteNumber()))
	elif midi.isController():
		print('%s: CONTROLLER' % port, midi.getControllerNumber(), midi.getControllerValue())

class Collector(threading.Thread):
	def __init__(self, device, port):
		threading.Thread.__init__(self)
		self.setDaemon(True)
		self.port = port
		self.portName = device.getPortName(port)
		self.device = device
		self.quit = False

	def run(self):
		self.device.openPort(self.port)
		self.device.ignoreTypes(True, False, True)
		while True:
			if self.quit:
				return
			msg = self.device.getMessage()
			if msg:
				#print([hex(i) for i in msg.getRawData()])
				#print_message(msg, self.portName)
				send_msg([i for i in msg.getRawData()])

dev = rtmidi.RtMidiIn()
collectors = []
for i in range(dev.getPortCount()):
	device = rtmidi.RtMidiIn()
	print('OPENING',dev.getPortName(i))
	collector = Collector(device, i)
	collector.start()
	collectors.append(collector)


print('HIT ENTER TO EXIT')
sys.stdin.read(1)
for c in collectors:
	c.quit = True
