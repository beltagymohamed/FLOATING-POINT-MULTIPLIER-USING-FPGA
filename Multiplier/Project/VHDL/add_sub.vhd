library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;


entity add_sub is 
  port (
    
  add_sub_in_a:in std_logic_vector(7 downto 0 );
  add_sub_in_b:in std_logic_vector(7 downto 0 ); 
  add_sub_out:out std_logic_vector(7 downto 0 );
  add_sub_sel:in std_logic
  
);
end add_sub ;
---// when the sel is ONE = Addition when select zero = subtraction \\---
architecture behaviour of add_sub is 
begin 
  process (add_sub_in_a,add_sub_in_b,add_sub_sel)
    begin 
      if (add_sub_sel='1')then
      add_sub_out<=add_sub_in_a+add_sub_in_b;
    else
    add_sub_out<=add_sub_in_a-add_sub_in_b; 
  end if ;
end process; 
end  behaviour; 
       
      






