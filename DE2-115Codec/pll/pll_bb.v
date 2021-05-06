
module pll (
	clk_clk,
	clock_12_clk,
	onchip_memory2_0_reset1_reset,
	onchip_memory2_0_reset1_reset_req,
	onchip_memory2_0_s1_address,
	onchip_memory2_0_s1_debugaccess,
	onchip_memory2_0_s1_clken,
	onchip_memory2_0_s1_chipselect,
	onchip_memory2_0_s1_write,
	onchip_memory2_0_s1_readdata,
	onchip_memory2_0_s1_writedata,
	onchip_memory2_0_s1_byteenable,
	onchip_memory2_1_reset1_reset,
	onchip_memory2_1_reset1_reset_req,
	onchip_memory2_1_s1_address,
	onchip_memory2_1_s1_debugaccess,
	onchip_memory2_1_s1_clken,
	onchip_memory2_1_s1_chipselect,
	onchip_memory2_1_s1_write,
	onchip_memory2_1_s1_readdata,
	onchip_memory2_1_s1_writedata,
	onchip_memory2_1_s1_byteenable,
	onchip_memory2_2_reset1_reset,
	onchip_memory2_2_reset1_reset_req,
	onchip_memory2_2_s1_address,
	onchip_memory2_2_s1_debugaccess,
	onchip_memory2_2_s1_clken,
	onchip_memory2_2_s1_chipselect,
	onchip_memory2_2_s1_write,
	onchip_memory2_2_s1_readdata,
	onchip_memory2_2_s1_writedata,
	onchip_memory2_2_s1_byteenable,
	reset_reset_n,
	onchip_memory2_3_reset1_reset,
	onchip_memory2_3_reset1_reset_req,
	onchip_memory2_3_s1_address,
	onchip_memory2_3_s1_debugaccess,
	onchip_memory2_3_s1_clken,
	onchip_memory2_3_s1_chipselect,
	onchip_memory2_3_s1_write,
	onchip_memory2_3_s1_readdata,
	onchip_memory2_3_s1_writedata,
	onchip_memory2_3_s1_byteenable);	

	input		clk_clk;
	output		clock_12_clk;
	input		onchip_memory2_0_reset1_reset;
	input		onchip_memory2_0_reset1_reset_req;
	input	[7:0]	onchip_memory2_0_s1_address;
	input		onchip_memory2_0_s1_debugaccess;
	input		onchip_memory2_0_s1_clken;
	input		onchip_memory2_0_s1_chipselect;
	input		onchip_memory2_0_s1_write;
	output	[15:0]	onchip_memory2_0_s1_readdata;
	input	[15:0]	onchip_memory2_0_s1_writedata;
	input	[1:0]	onchip_memory2_0_s1_byteenable;
	input		onchip_memory2_1_reset1_reset;
	input		onchip_memory2_1_reset1_reset_req;
	input	[7:0]	onchip_memory2_1_s1_address;
	input		onchip_memory2_1_s1_debugaccess;
	input		onchip_memory2_1_s1_clken;
	input		onchip_memory2_1_s1_chipselect;
	input		onchip_memory2_1_s1_write;
	output	[15:0]	onchip_memory2_1_s1_readdata;
	input	[15:0]	onchip_memory2_1_s1_writedata;
	input	[1:0]	onchip_memory2_1_s1_byteenable;
	input		onchip_memory2_2_reset1_reset;
	input		onchip_memory2_2_reset1_reset_req;
	input	[7:0]	onchip_memory2_2_s1_address;
	input		onchip_memory2_2_s1_debugaccess;
	input		onchip_memory2_2_s1_clken;
	input		onchip_memory2_2_s1_chipselect;
	input		onchip_memory2_2_s1_write;
	output	[15:0]	onchip_memory2_2_s1_readdata;
	input	[15:0]	onchip_memory2_2_s1_writedata;
	input	[1:0]	onchip_memory2_2_s1_byteenable;
	input		reset_reset_n;
	input		onchip_memory2_3_reset1_reset;
	input		onchip_memory2_3_reset1_reset_req;
	input	[7:0]	onchip_memory2_3_s1_address;
	input		onchip_memory2_3_s1_debugaccess;
	input		onchip_memory2_3_s1_clken;
	input		onchip_memory2_3_s1_chipselect;
	input		onchip_memory2_3_s1_write;
	output	[15:0]	onchip_memory2_3_s1_readdata;
	input	[15:0]	onchip_memory2_3_s1_writedata;
	input	[1:0]	onchip_memory2_3_s1_byteenable;
endmodule
