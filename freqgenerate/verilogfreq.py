

for i in range(128):
    freq = (440*2**(((138-i)-69)/12))*(6/25)
    print("8'h{}: noteSampleTicks <= 24'd{};  // {}".format(
        hex(i), int(freq), (i)
    ))