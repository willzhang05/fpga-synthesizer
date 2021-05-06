library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity audio_codec is
port (
	----------WM8731 pins-----
	AUD_BCLK: out std_logic;
	AUD_XCK: out std_logic;
	AUD_ADCLRCK:  out std_logic;
	AUD_ADCDAT: in std_logic;
	AUD_DACLRCK: out std_logic;
	AUD_DACDAT: out std_logic;

	---------FPGA pins-----
	clock_50: in std_logic;
	key: in std_logic_vector(3 downto 0);
	--ledr: out std_logic_vector(9 downto 0);
	sw: in std_logic_vector(9 downto 0);
	
	FPGA_I2C_SCLK: out std_logic;
	FPGA_I2C_SDAT: inout std_logic;
	
	MIDI_IN_DATA: in std_logic_vector(7 downto 0);
	MIDI_IN_CLK: in std_logic;
	MIDI_IN_RESET: in std_logic;
	
	FPGA_LED_OUT : out std_logic_vector(23 downto 0);
	
	clock_12 : out std_logic
);

end audio_codec;


architecture main of audio_codec is

signal bitprsc: integer range 0 to 4:=0;
signal aud_mono: std_logic_vector(31 downto 0):=(others=>'0');
signal read_addr: integer range 0 to 240254:=0;
signal ROM_ADDR: std_logic_vector(17 downto 0);
signal ROM_OUT, ROM_OUT0, ROM_OUT1, ROM_OUT2: std_logic_vector(15 downto 0);
signal clock_12pll: std_logic;
signal WM_i2c_busy: std_logic;
signal WM_i2c_done: std_logic;
signal WM_i2c_send_flag: std_logic;
signal WM_i2c_data: std_logic_vector(15 downto 0);
signal DA_CLR: std_logic:='0';
signal MIDI_BYTE_OUT: std_logic_vector(23 downto 0);
signal CURRENT_MIDI_NOTE : std_logic_vector(7 downto 0);
signal CURRENT_MIDI_STATUS : std_logic;
signal NOTE_SAMPLE_TICKS_OUT: std_logic_vector(23 downto 0);


component pll is
port (
	clk_clk                         : in  std_logic                     := 'X';             -- clk
	clock_12_clk                    : out std_logic;                                        -- clk
	reset_reset_n                   : in  std_logic                     := 'X';             -- reset_n
	-- onchip memory for sine wavetable
	onchip_memory2_0_s1_address     : in  std_logic_vector(17 downto 0) := (others => 'X'); -- address
	onchip_memory2_0_s1_debugaccess : in  std_logic                     := 'X';             -- debugaccess
	onchip_memory2_0_s1_clken       : in  std_logic                     := 'X';             -- clken
	onchip_memory2_0_s1_chipselect  : in  std_logic                     := 'X';             -- chipselect
	onchip_memory2_0_s1_write       : in  std_logic                     := 'X';             -- write
	onchip_memory2_0_s1_readdata    : out std_logic_vector(15 downto 0);                    -- readdata
	onchip_memory2_0_s1_writedata   : in  std_logic_vector(15 downto 0) := (others => 'X'); -- writedata
	onchip_memory2_0_s1_byteenable  : in  std_logic_vector(1 downto 0)  := (others => 'X'); -- byteenable
	onchip_memory2_0_reset1_reset   : in  std_logic                     := 'X';             -- reset
	-- onchip memory for cello wavetable
	onchip_memory2_1_s1_address     : in  std_logic_vector(17 downto 0) := (others => 'X'); -- address
	onchip_memory2_1_s1_debugaccess : in  std_logic                     := 'X';             -- debugaccess
	onchip_memory2_1_s1_clken       : in  std_logic                     := 'X';             -- clken
	onchip_memory2_1_s1_chipselect  : in  std_logic                     := 'X';             -- chipselect
	onchip_memory2_1_s1_write       : in  std_logic                     := 'X';             -- write
	onchip_memory2_1_s1_readdata    : out std_logic_vector(15 downto 0);                    -- readdata
	onchip_memory2_1_s1_writedata   : in  std_logic_vector(15 downto 0) := (others => 'X'); -- writedata
	onchip_memory2_1_s1_byteenable  : in  std_logic_vector(1 downto 0)  := (others => 'X'); -- byteenable
	onchip_memory2_1_reset1_reset   : in  std_logic                     := 'X';             -- reset	
	-- onchip memory for sawtooth wavetable
	onchip_memory2_2_s1_address     : in  std_logic_vector(17 downto 0) := (others => 'X'); -- address
	onchip_memory2_2_s1_debugaccess : in  std_logic                     := 'X';             -- debugaccess
	onchip_memory2_2_s1_clken       : in  std_logic                     := 'X';             -- clken
	onchip_memory2_2_s1_chipselect  : in  std_logic                     := 'X';             -- chipselect
	onchip_memory2_2_s1_write       : in  std_logic                     := 'X';             -- write
	onchip_memory2_2_s1_readdata    : out std_logic_vector(15 downto 0);                    -- readdata
	onchip_memory2_2_s1_writedata   : in  std_logic_vector(15 downto 0) := (others => 'X'); -- writedata
	onchip_memory2_2_s1_byteenable  : in  std_logic_vector(1 downto 0)  := (others => 'X'); -- byteenable
	onchip_memory2_2_reset1_reset   : in  std_logic                     := 'X'              -- reset	
);
end component pll;

component aud_gen is
 port (
	aud_clock_12: in std_logic;
	aud_bk: out std_logic;
	aud_dalr: out std_logic;
	aud_dadat: out std_logic;
	aud_data_in: in std_logic_vector(31 downto 0);
	note_sample_ticks_in: in std_logic_vector(23 downto 0);
	midi_note_in : in std_logic_vector(7 downto 0);
	note_status_in: in std_logic
 ); 
end component aud_gen;


component i2c is
	port(
		i2c_busy: out std_logic;
		i2c_scl: out std_logic;
		i2c_send_flag: in std_logic;
		i2c_sda: inout std_logic;
		i2c_addr: in std_logic_vector(7 downto 0);
		i2c_done: out std_logic;
		i2c_data: in std_logic_vector(15 downto 0);
		i2c_clock_50: in std_logic
	); 
end component i2c;


component midiByteRead is
		port (
			byteIn: in std_logic_vector(7 downto 0);
			clk, rst: in std_logic; -- reset is active high 
			midiOut: out std_logic_vector(23 downto 0)
		);
end component midiByteRead;

component midiNoteNumberToSampleTicks is
		port (
			midiNoteNumber: in std_logic_vector(7 downto 0);
			noteSampleTicks: out std_logic_vector(23 downto 0)
		);
end component midiNoteNumberToSampleTicks;

begin
u0 : component pll
        port map (
					clk_clk       => clock_50,                                           -- clk.clk
					reset_reset_n => '1',                                                -- reset.reset_n
					clock_12_clk  => clock_12pll, 												   -- clock_12.clk
					-- onchip memory for sine wavetable
					onchip_memory2_0_s1_address     => ROM_ADDR,
					onchip_memory2_0_s1_debugaccess =>'0',                               -- debugaccess
					onchip_memory2_0_s1_clken       =>'1',                               -- clken
					onchip_memory2_0_s1_chipselect  =>'1',                               -- chipselect
					onchip_memory2_0_s1_write      =>'0',                                -- write
					onchip_memory2_0_s1_readdata   =>ROM_OUT0,                            -- readdata
					onchip_memory2_0_s1_writedata  =>(others=>'0'),
					onchip_memory2_0_s1_byteenable  =>"11",
					onchip_memory2_0_reset1_reset=>'0',
					-- onchip memory for cello wavetable 
					onchip_memory2_1_s1_address     => ROM_ADDR,
					onchip_memory2_1_s1_debugaccess =>'0',                               -- debugaccess
					onchip_memory2_1_s1_clken       =>'1',                               -- clken
					onchip_memory2_1_s1_chipselect  =>'1',                               -- chipselect
					onchip_memory2_1_s1_write      =>'0',                                -- write
					onchip_memory2_1_s1_readdata   =>ROM_OUT1,                            -- readdata
					onchip_memory2_1_s1_writedata  =>(others=>'0'),
					onchip_memory2_1_s1_byteenable  =>"11",
					onchip_memory2_1_reset1_reset=>'0',
					-- onchip memory for sawtooth wavetable
					onchip_memory2_2_s1_address     => ROM_ADDR,
					onchip_memory2_2_s1_debugaccess =>'0',                               -- debugaccess
					onchip_memory2_2_s1_clken       =>'1',                               -- clken
					onchip_memory2_2_s1_chipselect  =>'1',                               -- chipselect
					onchip_memory2_2_s1_write      =>'0',                                -- write
					onchip_memory2_2_s1_readdata   =>ROM_OUT2,                            -- readdata
					onchip_memory2_2_s1_writedata  =>(others=>'0'),
					onchip_memory2_2_s1_byteenable  =>"11",
					onchip_memory2_2_reset1_reset=>'0'
				);

sound: component aud_gen
		port map(
			aud_clock_12 => clock_12pll,
			aud_bk => AUD_BCLK,
			aud_dalr => DA_CLR,
			aud_dadat => AUD_DACDAT,	
			aud_data_in => aud_mono,
			note_sample_ticks_in => NOTE_SAMPLE_TICKS_OUT,
			midi_note_in => MIDI_BYTE_OUT(15 downto 8),
			note_status_in => MIDI_BYTE_OUT(20)
		);
		
WM8731: component i2c 
		port map(
			i2c_busy => WM_i2c_busy,
			i2c_scl => FPGA_I2C_SCLK,
			i2c_send_flag => WM_i2c_send_flag,
			i2c_sda => FPGA_I2C_SDAT,
			i2c_addr => "00110100",
			i2c_done => WM_i2c_done,
			i2c_data => WM_i2c_data,
			i2c_clock_50 => clock_50	
		);

reader: component midiByteRead 
		port map(
			byteIn => MIDI_IN_DATA,
			clk => MIDI_IN_CLK, 
			rst => MIDI_IN_RESET,
			midiOut => MIDI_BYTE_OUT 
		);

converter: component midiNoteNumberToSampleTicks
		port map(
			midiNoteNumber => MIDI_BYTE_OUT(15 downto 8),
			noteSampleTicks => NOTE_SAMPLE_TICKS_OUT
		);

		
AUD_XCK<=clock_12pll;
AUD_DACLRCK<=DA_CLR;
	
ROM_ADDR<=std_logic_vector(to_unsigned(read_addr,18));


process (clock_12pll)
	VARIABLE NUM_SAMPLES : NATURAL RANGE 0 to 32767 := 255;
begin
	clock_12 <= clock_12pll;
	if rising_edge(clock_12pll)then
		-- switch statement to set the wave table 
		if (SW(7)='0' AND SW(6)='0' AND SW(5) = '1') then -- use the cello wave
			ROM_OUT <= ROM_OUT1;
			NUM_SAMPLES := 255;
		elsif (SW(7)='0' AND SW(6)='1' AND SW(5) = '0') then -- use the sawtooth wave
			ROM_OUT <= ROM_OUT2;
			NUM_SAMPLES := 255;
		else  -- use the sine wave
			ROM_OUT <= ROM_OUT0;
			NUM_SAMPLES := 255;
		end if;
		
		if (SW(8)='1') then--------reset
			read_addr<=0;
			bitprsc<=0;
			aud_mono<=(others=>'0');
		else
			--LEDR(1)<=SW(7);
			FPGA_LED_OUT <= MIDI_BYTE_OUT;
			aud_mono(15 downto 0)<=ROM_OUT;----mono sound
			aud_mono(31 downto 16)<=ROM_OUT;
			-- outputs a 190Hz signal with a 12 MHz clock 
			if(DA_CLR='1')then
				bitprsc<=0;
				if(read_addr < NUM_SAMPLES) then
					read_addr<=read_addr+1;
				else
					read_addr<=0;
				end if;
			end if;
		end if;	
	end if;
end process;	

process (clock_50)
begin
	if rising_edge (clock_50)then
		if(KEY="1111")then
		WM_i2c_send_flag<='0';
		end if;
	end if;
	if rising_edge(clock_50) and WM_i2c_busy='0' then
 
	
		if (KEY(0)='0') then ----Digital Interface: DSP, 16 bit, slave mode
		WM_i2c_data(15 downto 9)<="0000111";
		WM_i2c_data(8 downto 0)<="000010011";	
		WM_i2c_send_flag<='1';
			
		elsif (KEY(0)='0'AND SW(0)='1' ) then---HEADPHONE VOLUME
		WM_i2c_data(15 downto 9)<="0000010";
		WM_i2c_data(8 downto 0)<="101111001";
		WM_i2c_send_flag<='1';
		
		elsif (KEY(1)='0'AND SW(0)='0' ) then---ADC of, DAC on, Linout ON, Power ON
		WM_i2c_data(15 downto 9)<="0000110";
		WM_i2c_data(8 downto 0)<="000000111";
	
		WM_i2c_send_flag<='1';
		elsif (KEY(1)='0'AND SW(0)='1' ) then---USB mode
		WM_i2c_data(15 downto 9)<="0001000";
		WM_i2c_data(8 downto 0)<="000000001";
		
		WM_i2c_send_flag<='1';
		elsif (KEY(2)='0'AND SW(0)='0') then---activ interface
		WM_i2c_data(15 downto 9)<="0001001";
		WM_i2c_data(8 downto 0)<="111111111";
		
		WM_i2c_send_flag<='1';
		elsif (KEY(2)='0'AND SW(0)='1') then---Enable DAC to LINOUT
		WM_i2c_data(15 downto 9)<="0000100";
		WM_i2c_data(8 downto 0)<="000010010";
		
		WM_i2c_send_flag<='1';
		elsif (KEY(3)='0' AND SW(0)='0') then---remove mute DAC
		WM_i2c_data(15 downto 9)<="0000101";
		WM_i2c_data(8 downto 0)<="000000000";
		
		WM_i2c_send_flag<='1';
		elsif (KEY(3)='0' AND SW(0)='1') then---reset
		WM_i2c_data(15 downto 9)<="0001111";
		WM_i2c_data(8 downto 0)<="000000000";
		
		WM_i2c_send_flag<='1';
		end if;
	end if;
end process;
end main;