library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_unsigned.all;


entity shifter2 is
	port (in1: in std_logic_vector(23 downto 0);
	      in2: in unsigned(4 downto 0);
				rst: in std_logic;
				res: out std_logic_vector (47 downto 0)
				);
end shifter2;

architecture arch_shifter2_1 of shifter2 is
  
  signal a:unsigned(47 downto 0);
  signal r:unsigned(47 downto 0);
  
  
  begin
    a<="000000000000000000000000" & unsigned(in1);
    res<=std_logic_vector(r);
    
    with rst select
      r <= (others => '0') when '0',
          a sll to_integer(in2) when others;
          
end arch_shifter2_1;
