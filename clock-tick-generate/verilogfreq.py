

for i in range(128):
    clock_tick_delay = (440*2**(((138-i)-69)/12))*(6/25)
    print("8'h{}: noteSampleTicks <= 24'd{};  // {}".format(
        hex(i), int(clock_tick_delay), (i)
    ))
