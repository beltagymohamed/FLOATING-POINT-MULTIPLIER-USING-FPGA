-------------------------------------------------------------------------------
-- Description: Implementation of a 32 x 8 ROM
-------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity romMemOpA is
  port (
    addr    : in  std_logic_vector (2  downto 0);
    dataOut : out std_logic_vector (31 downto 0)
  );
end romMemOpA;

architecture behavior of romMemOpA is

  type romTable is array (0 to 7) of std_logic_vector (31 downto 0);

  -- Memory initialization
  constant romData : romTable := (
    ---------|-------|-------|-------
    "01000011000001100001000000000000", -- 134.0625
    "11000001011010000000000000000000", -- -14.5 
    "01000000111100000000000000000000", --   7.5
    "11000001100100000000000000000000", -- -18.0
    "00000000000000000000000000000000", --  0
    "01111111100000000000000000000000", -- +inf
    "00000000110110011100011111011101", -- 2e-38
    "01111111000101100111011010011001" -- 2e38
  );
  

begin 

  process (addr)
  begin 
    dataOut <= romData(to_integer(unsigned(addr)));
  end process;
  
end behavior;
