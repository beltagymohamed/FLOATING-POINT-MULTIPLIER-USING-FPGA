library ieee;
use ieee.std_logic_1164.all;


entity reg is
	port (clk,en,rst: in std_logic;
				a:in std_logic_vector((31) downto 0);
				r: out std_logic_vector((31) downto 0)
				);
end reg;

architecture arch_reg_1 of reg is

begin
  process (clk, rst)
  begin
    if rst='0' then 
      r <= (others => '0');
    else 
      if (clk'event and clk='1') then 
        if en='1' then 
          r <= a;
        end if;
      end if;
    end if;
  end process;
end arch_reg_1;
