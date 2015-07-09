library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_unsigned.all;


entity shifter is
	port (in1: in std_logic_vector(23 downto 0);
	      in2: in unsigned(4 downto 0);
				clk,rst: in std_logic;
				res: out std_logic_vector (47 downto 0)
				);
end shifter;

architecture arch_shifter_1 of shifter is
  

  signal a:unsigned(47 downto 0);
  signal r:unsigned(47 downto 0);
  
  
  begin
    a<="000000000000000000000000" & unsigned(in1);
    res<=std_logic_vector(r);
  
  process (clk, rst)
  begin
    if rst='0' then
      r <= (others => '0');
    elsif(in2="00000") then 
     r <= (others => '0');
    else
      if (rising_edge(clk)) then
        r<=a sll to_integer(in2);
      end if;
    end if;
  end process;
  



end arch_shifter_1;
