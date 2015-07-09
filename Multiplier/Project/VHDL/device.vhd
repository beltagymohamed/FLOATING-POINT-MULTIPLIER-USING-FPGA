library ieee;
use ieee.std_logic_1164.all;


entity device is
	port (a,b: in std_logic_vector(31 downto 0);
				clk,en,rst: in std_logic;
				c: out std_logic_vector(31 downto 0);
				done: out std_logic
				);
end device;

architecture arch_device_1 of device is

component datapath is
	port (a,b: in std_logic_vector(31 downto 0);
			clk,rst: in std_logic;
			en: in std_logic_vector(1 downto 0);
			c: out std_logic_vector(31 downto 0);
			done,m47: out std_logic
			);
end component;
component exceptions
	port (in1: in std_logic_vector(31 downto 0);
	      in2: in std_logic_vector(31 downto 0);
			int_mul: in std_logic_vector(31 downto 0);
			enable: in std_logic;
			m_in47:in std_logic;
			exp_out: out std_logic_vector(31 downto 0)			
			);
end component;
component control 
	port (clk,rst,en: in std_logic;
			done_m: in std_logic;
			done:out std_logic;
			en_mul: out std_logic_vector(1 downto 0)
			);
end component;

signal done_s : std_logic ;
signal res: std_logic_vector(31 downto 0);
signal m47: std_logic;
signal en_m:std_logic_vector(1 downto 0);
signal d: std_logic;
begin
  done<=d;
  dp: datapath port map(a=>a,b=>b,clk=>clk,rst=>rst,en=>en_m,c=>res,done=>done_s,m47=>m47);
  ex:exceptions port map(in1=>a,in2=>b,int_mul=>res,enable=>d,m_in47=>m47,exp_out=>c);
  ctrl: control port map(clk=>clk,rst=>rst,en=>en,done_m=>done_s,done=>d,en_mul=>en_m);

end arch_device_1;

 

 
     
