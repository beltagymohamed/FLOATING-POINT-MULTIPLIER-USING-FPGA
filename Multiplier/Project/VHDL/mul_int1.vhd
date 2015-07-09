library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity mul_int1 is
	port (in1: in std_logic_vector(23 downto 0);
	      in2: in std_logic_vector(23 downto 0);
				clk,rst: in std_logic;
				done:out std_logic;
				res: out std_logic_vector(47 downto 0):=(others=>'0')
				);
end mul_int1;

architecture arch_mul_int_1 of mul_int1 is
  
  component shifter
    port (in1: in std_logic_vector(23 downto 0);
          in2: in unsigned(4 downto 0);
          clk,rst: in std_logic;
          res: out std_logic_vector (47 downto 0)
          );
  end component;
    
    type RAM is array (23 downto 0) of std_logic_vector(47 downto 0);  
    signal out_shifters: RAM;
    signal out_mux: RAM;
    
    signal r:std_logic_vector(47 downto 0 ):=(others=>'0'); 
	 
	 signal r1:unsigned(47 downto 0 ):=(others=>'0'); 
	 signal r2:unsigned(47 downto 0 ):=(others=>'0'); 
	 signal r3:unsigned(47 downto 0 ):=(others=>'0'); 
	 signal r4:unsigned(47 downto 0 ):=(others=>'0');
	 signal r5:unsigned(47 downto 0 ):=(others=>'0'); 
	 signal r6:unsigned(47 downto 0 ):=(others=>'0'); 
	 signal r7:unsigned(47 downto 0 ):=(others=>'0'); 
	 signal r8:unsigned(47 downto 0 ):=(others=>'0');
    
	 signal done1:std_logic:='0';

  begin
    
    res<=r;
	 
	 r1<=unsigned(out_mux(0))+unsigned(out_mux(1))+unsigned(out_mux(2))+unsigned(out_mux(3));
	 r2<=unsigned(out_mux(4))+unsigned(out_mux(5))+unsigned(out_mux(6))+unsigned(out_mux(7));
	 r3<=unsigned(out_mux(8))+unsigned(out_mux(9))+unsigned(out_mux(10))+unsigned(out_mux(11));
	 r4<=unsigned(out_mux(12))+unsigned(out_mux(13))+unsigned(out_mux(14))+unsigned(out_mux(15));
	 r5<=unsigned(out_mux(16))+unsigned(out_mux(17))+unsigned(out_mux(18))+unsigned(out_mux(19));
	 r6<=unsigned(out_mux(20))+unsigned(out_mux(21))+unsigned(out_mux(22))+unsigned(out_mux(23));
	 r7<=r1+r2+r3;
	 r8<=r4+r5+r6;
    
    SH1 : for N in 23 downto 0 generate  
      shifter_array : shifter
        port map (in1=>in2,in2=>to_unsigned(N,5),clk=>clk,rst=>rst,res=>out_shifters(N));
    end generate SH1;
    
    MS : for M in 23 downto 0 generate  
		with in1(M) select
			out_mux(M)<=out_shifters(M) when '1',
							(others=>'0') when others;
    end generate MS;

    	
	syncrho:process (clk, rst)
	begin
		if rst='0' then 
			r <= (others => '0');
			done1<='0';
			done<='0';
		else 
			if (rising_edge(clk)) then 
				done1<='1';
				done<=done1;
				if (in1="100000000000000000000000" or in2="100000000000000000000000")then
				  r<=(others => '0');
				else
				  r<=std_logic_vector(r7+r8);
				end if;
			end if;
		end if;
	end process;
   
end arch_mul_int_1;





 

 
     
