library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity mul_int2 is
	port (in1: in std_logic_vector(23 downto 0);
	      in2: in std_logic_vector(23 downto 0);
				clk,rst: in std_logic;
				done:out std_logic;
				res: out std_logic_vector(47 downto 0)
				);
end mul_int2;

architecture arch_mul_int2_1 of mul_int2 is
  
  component shifter2
    port (in1: in std_logic_vector(23 downto 0);
          in2: in unsigned(4 downto 0);
          rst: in std_logic;
          res: out std_logic_vector (47 downto 0));
  end component;
  
  
  signal rsh: std_logic_vector(47 downto 0):=(others=>'0');
  signal r: std_logic_vector(47 downto 0):=(others=>'0');
  signal counter: unsigned(4 downto 0):="00000";
  signal d: std_logic;

  begin
    sh: shifter2 port map(in1=>in2,in2=>counter,rst=>rst,res=>rsh );
    res<=r(47 downto 0);
    done<=d;
    
    process (rst,clk) 
      begin
        if rst='0'  then
          r<=(others=>'0');
          counter<="00000";
          d<='0';
        else
          if(rising_edge(clk)) then
            if(in1(to_integer(counter))='1' and d='0') then
              r<=std_logic_vector(unsigned(r)+unsigned(rsh));
            end if;
            
            if(counter="10111") then
              d<='1';
            else              
              counter<=counter+1;
            end if;
            
          end if;
        end if;
      end process;             
  
end arch_mul_int2_1;





 

 
     
