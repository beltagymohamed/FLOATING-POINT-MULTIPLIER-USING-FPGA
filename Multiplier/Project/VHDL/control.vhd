library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity control is
	port (clk,rst,en: in std_logic;
			done_m: in std_logic;
			done:out std_logic;
			en_mul: out std_logic_vector(1 downto 0)
			);
end control;

architecture arch_control of control is
  
  type states is (idle,load,multiply,deploy);
  signal State, NextState : states;

  begin
	 
	 FSM:process(State) begin
    NextState<=idle;
	 done<='0';
	 en_mul<="00";
    
    case State is
      when idle =>  
		  done<='0';
		  en_mul<="00";
        if(en='1') then
          NextState<=load;
        else
          NextState<=idle;
        end if;
      
		when load =>
        NextState<=multiply;
		  done<='0';
		  en_mul<="01";        
      
		when multiply =>
		  done<='0';
		  en_mul<="11";
        if(done_m='1') then
          NextState<=deploy;
        else
          NextState<=multiply;
        end if;
		
		when deploy =>
		  done<='1';
		  en_mul<="11";
          NextState<=idle;
    end case;
  end process;
  
  transitions:process (clk, rst) begin
    if rst='0'then 
      State <= idle;
    elsif (clk'event and clk='1')then 
      State <= NextState;
    end if;
  end process;
   
end arch_control;





 

 
     
