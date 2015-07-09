library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;


entity datapath is
	port (a,b: in std_logic_vector(31 downto 0);
			clk,rst: in std_logic;
			en: in std_logic_vector(1 downto 0);
			c: out std_logic_vector(31 downto 0);
			done,m47: out std_logic
			);
end datapath;

architecture arch_datapath_1 of datapath is
component reg is
	port (clk,en,rst: in std_logic;
				a:in std_logic_vector((31) downto 0);
				r: out std_logic_vector((31) downto 0)
				);
end component;

component mul_int1 is
	port (in1: in std_logic_vector(23 downto 0);
	      in2: in std_logic_vector(23 downto 0);
				clk,rst: in std_logic;
				done:out std_logic;
				res: out std_logic_vector(47 downto 0):=(others=>'0')
				);
end component;

component extractor is 
  port (
    
  ext_in:in std_logic_vector(47 downto 0 );
  ext_out:out std_logic_vector(22 downto 0 ) 
 
);
end component;

signal rra,rrb: std_logic_vector(31 downto 0);
alias signa: std_logic is rra(31);
alias signb: std_logic is rrb(31);
alias expa: std_logic_vector(7 downto 0) is rra(30 downto 23);
alias expb: std_logic_vector(7 downto 0) is rrb(30 downto 23);
alias manta: std_logic_vector(22 downto 0) is rra(22 downto 0);
alias mantb: std_logic_vector(22 downto 0) is rrb(22 downto 0);

signal mana,manb: std_logic_vector(23 downto 0);


signal done_mul: std_logic;
signal mul_out: std_logic_vector(47 downto 0);
signal ext_out: std_logic_vector(22 downto 0);

signal signf: std_logic;
signal expf:std_logic_vector(7 downto 0):=(others=>'0');
signal expg:std_logic_vector(7 downto 0):=(others=>'0');
signal exph:std_logic_vector(7 downto 0):=(others=>'0');

signal ric: std_logic_vector(31 downto 0);

	begin
   mana<='1' & manta;
   manb<='1' & mantb;
   rega: reg port map(clk=>clk,en=>en(0),rst=>rst,a=>a,r=>rra);
	regb: reg port map(clk=>clk,en=>en(0),rst=>rst,a=>b,r=>rrb);
	  
	mult: mul_int1 port map(in1=>mana,in2=>manb,clk=>clk,rst=>rst,done=>done_mul,res=>mul_out);
	  
	ext: extractor port map(ext_in=>mul_out,ext_out=>ext_out);
	  
	signf<=signa xor signb;
	
	expg<=std_logic_vector(expa+expb);
	exph<=std_logic_vector(expg)-"01111111";
	expf<=exph+("0000000" & mul_out(47));
	
	ric<=signf & expf & ext_out;
	regc: reg port map(clk=>clk,en=>en(1),rst=>rst,a=>ric,r=>c);
	  
	done<=done_mul;
	m47<=mul_out(47);
	
	
	  



end arch_datapath_1;

 

 
     
