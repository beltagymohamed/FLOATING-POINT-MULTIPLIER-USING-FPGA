-------------------------------------------------------------------------------
-- Description: Implementation of a 32 x 8 ROM
-------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity romMemOpB is
  port (
    addr    : in  std_logic_vector (2  downto 0);
    dataOut : out std_logic_vector (31 downto 0)
  );
end romMemOpB;

architecture behavior of romMemOpB is

  type romTable is array (0 to 7) of std_logic_vector (31 downto 0);

  -- Memory initialization
  constant romData : romTable := (
    ---------|-------|-------|-------
    "11000000000100000000000000000000", -- -2.25 
    "10111110110000000000000000000000", -- -0.375  
    "01000001011110000000000000000000", --  15.5
    "01000001000110000000000000000000", --   9.5
    "11111111111111111111111111111111", --  NaN
    "11111111100000000000000000000000", -- -inf
    "00000000110110011100011111011101", -- 2e-38
    "01111111000101100111011010011001" -- 2e38
  );
  
begin 
  process (addr)
  begin 
    dataOut <= romData(to_integer(unsigned(addr)));
  end process;
  
end behavior;
