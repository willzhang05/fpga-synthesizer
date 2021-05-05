--
-- VHDL Architecture fpga_synthesizer_lib.midiByteRead.Behavior
--
-- Created:
--          by - annac.UNKNOWN (DESKTOP-73UNB83)
--          at - 12:29:10 05/ 2/2021
--
-- using Mentor Graphics HDL Designer(TM) 2018.2 (Build 19)
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_arith.all;

ENTITY midiByteRead IS
  PORT( byteIn  : IN std_logic_vector(7 downto 0);
        clk, rst : IN std_logic; -- reset is active high 
        midiOut : OUT std_logic_vector(23 downto 0)
      );
        
END ENTITY midiByteRead;

--
ARCHITECTURE Behavior OF midiByteRead IS
  signal midiReg : std_logic_vector(23 downto 0) := (others => '0');
  signal cnt : std_logic_vector(1 downto 0) := "00";
  signal tempMidiOut : std_logic_vector(23 downto 0) := (others => '0');
BEGIN
  process(byteIn, rst, clk) 
  begin
    if rising_edge(clk) then 
      if rst = '1' then 
        midiOut <= tempMidiOut;
        midiReg <= (others => '0');
        cnt <= "00";
      elsif rst = '0' then 
        if cnt = "00" then 
          midiReg(23 downto 16) <= byteIn; -- load top byte
          cnt <= "01";
          midiOut <= tempMidiOut;
        elsif cnt = "01" then 
          midiReg(15 downto 8) <= byteIn;
          cnt <= "10";
          midiOut <= tempMidiOut;
        elsif cnt = "10" then 
          midiReg(7 downto 0) <= byteIn;
          cnt <= "11";
          midiOut <= tempMidiOut;
        elsif cnt = "11" then 
          midiOut <= midiReg;
			 tempMidiOut <= midiReg;
          cnt <= "00";
        end if;
      end if;
    end if;
  end process;
END ARCHITECTURE Behavior;

