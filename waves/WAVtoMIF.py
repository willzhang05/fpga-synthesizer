#!/usr/bin/python
import wave, sys

if len(sys.argv) < 2:
    print("Missing args.")
    print("Expected: input")

waveReader = wave.open(sys.argv[1], 'rb')

depth = waveReader.getnframes()
width = 16 # wav is 16 bits
radix = "HEX" # address and data in hex

print("DEPTH =", str(depth)+";")
print("WIDTH =", str(width)+";")
print("ADDRESS_RADIX =", radix+";")
print("DATA_RADIX =", radix+";")

print("CONTENT")
print("BEGIN\n")

for i in range(waveReader.getnframes()):
    frameAddr = "%X" % i
    frameValue = waveReader.readframes(1)
    hexFrame = "%02X%02X" % (frameValue[1], frameValue[0])
    print(frameAddr, ":", hexFrame+";")

print("\nEND;")

