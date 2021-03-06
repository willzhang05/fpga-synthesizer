module midiNoteNumberToSampleTicks(
	input [7:0] midiNoteNumber,
	output reg [23:0] noteSampleTicks
);

always @(midiNoteNumber)
begin
	case (midiNoteNumber)
		8'h0x0: noteSampleTicks <= 24'd5683;  // 0
		8'h0x1: noteSampleTicks <= 24'd5364;  // 1
		8'h0x2: noteSampleTicks <= 24'd5063;  // 2
		8'h0x3: noteSampleTicks <= 24'd4778;  // 3
		8'h0x4: noteSampleTicks <= 24'd4510;  // 4
		8'h0x5: noteSampleTicks <= 24'd4257;  // 5
		8'h0x6: noteSampleTicks <= 24'd4018;  // 6
		8'h0x7: noteSampleTicks <= 24'd3793;  // 7
		8'h0x8: noteSampleTicks <= 24'd3580;  // 8
		8'h0x9: noteSampleTicks <= 24'd3379;  // 9
		8'h0xa: noteSampleTicks <= 24'd3189;  // 10
		8'h0xb: noteSampleTicks <= 24'd3010;  // 11
		8'h0xc: noteSampleTicks <= 24'd2841;  // 12
		8'h0xd: noteSampleTicks <= 24'd2682;  // 13
		8'h0xe: noteSampleTicks <= 24'd2531;  // 14
		8'h0xf: noteSampleTicks <= 24'd2389;  // 15
		8'h0x10: noteSampleTicks <= 24'd2255;  // 16
		8'h0x11: noteSampleTicks <= 24'd2128;  // 17
		8'h0x12: noteSampleTicks <= 24'd2009;  // 18
		8'h0x13: noteSampleTicks <= 24'd1896;  // 19
		8'h0x14: noteSampleTicks <= 24'd1790;  // 20
		8'h0x15: noteSampleTicks <= 24'd1689;  // 21
		8'h0x16: noteSampleTicks <= 24'd1594;  // 22
		8'h0x17: noteSampleTicks <= 24'd1505;  // 23
		8'h0x18: noteSampleTicks <= 24'd1420;  // 24
		8'h0x19: noteSampleTicks <= 24'd1341;  // 25
		8'h0x1a: noteSampleTicks <= 24'd1265;  // 26
		8'h0x1b: noteSampleTicks <= 24'd1194;  // 27
		8'h0x1c: noteSampleTicks <= 24'd1127;  // 28
		8'h0x1d: noteSampleTicks <= 24'd1064;  // 29
		8'h0x1e: noteSampleTicks <= 24'd1004;  // 30
		8'h0x1f: noteSampleTicks <= 24'd948;  // 31
		8'h0x20: noteSampleTicks <= 24'd895;  // 32
		8'h0x21: noteSampleTicks <= 24'd844;  // 33
		8'h0x22: noteSampleTicks <= 24'd797;  // 34
		8'h0x23: noteSampleTicks <= 24'd752;  // 35
		8'h0x24: noteSampleTicks <= 24'd710;  // 36
		8'h0x25: noteSampleTicks <= 24'd670;  // 37
		8'h0x26: noteSampleTicks <= 24'd632;  // 38
		8'h0x27: noteSampleTicks <= 24'd597;  // 39
		8'h0x28: noteSampleTicks <= 24'd563;  // 40
		8'h0x29: noteSampleTicks <= 24'd532;  // 41
		8'h0x2a: noteSampleTicks <= 24'd502;  // 42
		8'h0x2b: noteSampleTicks <= 24'd474;  // 43
		8'h0x2c: noteSampleTicks <= 24'd447;  // 44
		8'h0x2d: noteSampleTicks <= 24'd422;  // 45
		8'h0x2e: noteSampleTicks <= 24'd398;  // 46
		8'h0x2f: noteSampleTicks <= 24'd376;  // 47
		8'h0x30: noteSampleTicks <= 24'd355;  // 48
		8'h0x31: noteSampleTicks <= 24'd335;  // 49
		8'h0x32: noteSampleTicks <= 24'd316;  // 50
		8'h0x33: noteSampleTicks <= 24'd298;  // 51
		8'h0x34: noteSampleTicks <= 24'd281;  // 52
		8'h0x35: noteSampleTicks <= 24'd266;  // 53
		8'h0x36: noteSampleTicks <= 24'd251;  // 54
		8'h0x37: noteSampleTicks <= 24'd237;  // 55
		8'h0x38: noteSampleTicks <= 24'd223;  // 56
		8'h0x39: noteSampleTicks <= 24'd211;  // 57
		8'h0x3a: noteSampleTicks <= 24'd199;  // 58
		8'h0x3b: noteSampleTicks <= 24'd188;  // 59
		8'h0x3c: noteSampleTicks <= 24'd177;  // 60
		8'h0x3d: noteSampleTicks <= 24'd167;  // 61
		8'h0x3e: noteSampleTicks <= 24'd158;  // 62
		8'h0x3f: noteSampleTicks <= 24'd149;  // 63
		8'h0x40: noteSampleTicks <= 24'd140;  // 64
		8'h0x41: noteSampleTicks <= 24'd133;  // 65
		8'h0x42: noteSampleTicks <= 24'd125;  // 66
		8'h0x43: noteSampleTicks <= 24'd118;  // 67
		8'h0x44: noteSampleTicks <= 24'd111;  // 68
		8'h0x45: noteSampleTicks <= 24'd105;  // 69
		8'h0x46: noteSampleTicks <= 24'd99;  // 70
		8'h0x47: noteSampleTicks <= 24'd94;  // 71
		8'h0x48: noteSampleTicks <= 24'd88;  // 72
		8'h0x49: noteSampleTicks <= 24'd83;  // 73
		8'h0x4a: noteSampleTicks <= 24'd79;  // 74
		8'h0x4b: noteSampleTicks <= 24'd74;  // 75
		8'h0x4c: noteSampleTicks <= 24'd70;  // 76
		8'h0x4d: noteSampleTicks <= 24'd66;  // 77
		8'h0x4e: noteSampleTicks <= 24'd62;  // 78
		8'h0x4f: noteSampleTicks <= 24'd59;  // 79
		8'h0x50: noteSampleTicks <= 24'd55;  // 80
		8'h0x51: noteSampleTicks <= 24'd52;  // 81
		8'h0x52: noteSampleTicks <= 24'd49;  // 82
		8'h0x53: noteSampleTicks <= 24'd47;  // 83
		8'h0x54: noteSampleTicks <= 24'd44;  // 84
		8'h0x55: noteSampleTicks <= 24'd41;  // 85
		8'h0x56: noteSampleTicks <= 24'd39;  // 86
		8'h0x57: noteSampleTicks <= 24'd37;  // 87
		8'h0x58: noteSampleTicks <= 24'd35;  // 88
		8'h0x59: noteSampleTicks <= 24'd33;  // 89
		8'h0x5a: noteSampleTicks <= 24'd31;  // 90
		8'h0x5b: noteSampleTicks <= 24'd29;  // 91
		8'h0x5c: noteSampleTicks <= 24'd27;  // 92
		8'h0x5d: noteSampleTicks <= 24'd26;  // 93
		8'h0x5e: noteSampleTicks <= 24'd24;  // 94
		8'h0x5f: noteSampleTicks <= 24'd23;  // 95
		8'h0x60: noteSampleTicks <= 24'd22;  // 96
		8'h0x61: noteSampleTicks <= 24'd20;  // 97
		8'h0x62: noteSampleTicks <= 24'd19;  // 98
		8'h0x63: noteSampleTicks <= 24'd18;  // 99
		8'h0x64: noteSampleTicks <= 24'd17;  // 100
		8'h0x65: noteSampleTicks <= 24'd16;  // 101
		8'h0x66: noteSampleTicks <= 24'd15;  // 102
		8'h0x67: noteSampleTicks <= 24'd14;  // 103
		8'h0x68: noteSampleTicks <= 24'd13;  // 104
		8'h0x69: noteSampleTicks <= 24'd13;  // 105
		8'h0x6a: noteSampleTicks <= 24'd12;  // 106
		8'h0x6b: noteSampleTicks <= 24'd11;  // 107
		8'h0x6c: noteSampleTicks <= 24'd11;  // 108
		8'h0x6d: noteSampleTicks <= 24'd10;  // 109
		8'h0x6e: noteSampleTicks <= 24'd9;  // 110
		8'h0x6f: noteSampleTicks <= 24'd9;  // 111
		8'h0x70: noteSampleTicks <= 24'd8;  // 112
		8'h0x71: noteSampleTicks <= 24'd8;  // 113
		8'h0x72: noteSampleTicks <= 24'd7;  // 114
		8'h0x73: noteSampleTicks <= 24'd7;  // 115
		8'h0x74: noteSampleTicks <= 24'd6;  // 116
		8'h0x75: noteSampleTicks <= 24'd6;  // 117
		8'h0x76: noteSampleTicks <= 24'd6;  // 118
		8'h0x77: noteSampleTicks <= 24'd5;  // 119
		8'h0x78: noteSampleTicks <= 24'd5;  // 120
		8'h0x79: noteSampleTicks <= 24'd5;  // 121
		8'h0x7a: noteSampleTicks <= 24'd4;  // 122
		8'h0x7b: noteSampleTicks <= 24'd4;  // 123
		8'h0x7c: noteSampleTicks <= 24'd4;  // 124
		8'h0x7d: noteSampleTicks <= 24'd4;  // 125
		8'h0x7e: noteSampleTicks <= 24'd3;  // 126
		8'h0x7f: noteSampleTicks <= 24'd3;  // 127
		default: noteSampleTicks <= 0;
	endcase
end

endmodule
