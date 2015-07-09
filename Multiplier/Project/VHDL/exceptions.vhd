library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity exceptions is
	port (in1: in std_logic_vector(31 downto 0);
	      in2: in std_logic_vector(31 downto 0);
			int_mul: in std_logic_vector(31 downto 0);
			enable: in std_logic;
			m_in47:in std_logic;
			exp_out: out std_logic_vector(31 downto 0)
			);
end exceptions;

architecture arch_exceptions of exceptions is
  signal expa :std_logic_vector (8 downto 0);
  signal expb :std_logic_vector (8 downto 0);
  signal summ :std_logic_vector (8 downto 0);
  signal m :std_logic_vector (8 downto 0) ;
   begin

  expa<='0' & in1(30 downto 23);
  expb<='0' & in2(30 downto 23);
  m<="00000000" & m_in47;
  summ<=std_logic_vector(unsigned(expa)+unsigned(expb)+unsigned(m));
  
  process (enable,in1,in2,int_mul,summ)
  begin
  
	if(enable='1')then
		
		-- not anumber 
		if (in1(30 downto 23)="11111111" and in1(22 downto 0 )/= "00000000000000000000000") then 
		exp_out<="11111111111111111111111111111111"; -- NaN
			elsif (in2(30 downto 23)="11111111" and in2(22 downto 0 )/="00000000000000000000000") then 
		exp_out<="11111111111111111111111111111111"; -- NaN
		elsif(in1=x"00000000")then
			-- zero by infinity or negative infinity  = NaN
	   	if(in2(30 downto 0)="1111111100000000000000000000000")then
				exp_out<="11111111111111111111111111111111"; --NaN
			-- zero by any number = 0 
			else
				exp_out<=(others=>'0');
			end if;
		elsif(in2=x"00000000")then
				if(in1(30 downto 0)="1111111100000000000000000000000")then
					exp_out<="11111111111111111111111111111111"; -- NaN
				else
					exp_out<=(others=>'0');
				end if;
		elsif(in1(30 downto 0)="1111111100000000000000000000000") then
			exp_out<=int_mul(31)&in1(30 downto 0 );
		elsif(in2(30 downto 0)="1111111100000000000000000000000") then 
			exp_out<=int_mul(31)&in2(30 downto 0 );
		
		---overflow detector \\\ ----
		elsif (summ>="111111100") then 
			exp_out<=int_mul(31)&"1111111100000000000000000000000";
		-- underflow detector
	   elsif (summ<="001111111") then 
			exp_out<="00000000000000000000000000000000";		
		else 
			exp_out<=int_mul;
		end if ;
		end if;
	end process;
	
   
end arch_exceptions;





 

 
     
