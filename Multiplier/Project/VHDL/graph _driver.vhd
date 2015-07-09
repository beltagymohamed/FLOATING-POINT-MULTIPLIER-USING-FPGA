library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity graph_driver is
  port (in_graph : in  std_logic_vector(31  downto 0);
        out_graph  : out  std_logic_vector(31  downto 0)
  );
end graph_driver;

architecture synt of graph_driver is

begin
	process(in_graph )
	begin
		if(in_graph="00000000000000000000000000000000")then --- zero
			out_graph<="00001100000100100001001000001100";
			
		elsif(in_graph="01111111100000000000000000000000")then
			out_graph<="00001010000101010001010100001010"; -- + Inf
		
		elsif(in_graph="11111111100000000000000000000000")then
			out_graph<="00001010110101010001010100001010"; -- - Inf
			
		elsif (in_graph(30 downto 23)="11111111" and in_graph(22 downto 0 )/= "00000000000000000000000") then 
		   out_graph<="01001000010110000110100001001000"; --- not a number
		else
			out_graph<=in_graph;
		end if ;
	
	end process;
end synt;

