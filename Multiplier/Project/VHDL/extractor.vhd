library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;


entity extractor is 
  port (
    
  ext_in:in std_logic_vector(47 downto 0 );
  ext_out:out std_logic_vector(22 downto 0 ) 
 
);
end extractor ;

architecture behaviour of extractor is 

begin 
  process (ext_in)
    begin 
      if (ext_in(47 downto 46)="01")then
			ext_out<=ext_in(45 downto 23);
		elsif(ext_in(47 downto 46)="10")then
			ext_out<=ext_in(46 downto 24); 
		elsif(ext_in(47 downto 46)="11")then
			ext_out<=ext_in (46 downto 24);
		else
			ext_out<=(others=>'0');
		end if ;
	end process; 
end  behaviour; 
       
      







