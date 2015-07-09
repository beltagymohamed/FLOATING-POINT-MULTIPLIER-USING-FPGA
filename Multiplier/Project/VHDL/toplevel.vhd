library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity multiplier is
  port (clk   : in  std_logic;
        reset : in  std_logic;
        addrA : in  std_logic_vector(2  downto 0);
        addrB : in  std_logic_vector(2  downto 0);
        showAB: in  std_logic;
        start: in  std_logic;
        result: out std_logic_vector(31 downto 0);
        outAB : out std_logic_vector(31 downto 0);
        ready : out std_logic_vector(7  downto 0)
  );
end multiplier;

architecture synt of multiplier is

  signal romAOut : std_logic_vector (31 downto 0);
  signal romBOut : std_logic_vector (31 downto 0);
  
  component graph_driver
	port (in_graph : in  std_logic_vector(31  downto 0);
			out_graph  : out  std_logic_vector(31  downto 0)
	);
	end component;
	signal outAB_graph_s: std_logic_vector(31 downto 0);
	signal result_graph_s: std_logic_vector(31 downto 0);

  component romMemOpA
    port(
      addr    : in  std_logic_vector (2  downto 0); 
      dataOut : out std_logic_vector (31 downto 0)
    );
  end component;

  component romMemOpB
    port(
      addr    : in std_logic_vector  (2  downto 0); 
      dataOut : out std_logic_vector (31 downto 0)
    );
  end component;

  component device 
	port (a,b: in std_logic_vector(31 downto 0);
				clk,en,rst: in std_logic;
				c: out std_logic_vector(31 downto 0);
				done: out std_logic
				);
  end component;
  
  signal en_mul:std_logic;
  signal rst_mul:std_logic;
  signal result_graph_ss: std_logic_vector(31 downto 0);
  signal done_mult: std_logic;
  signal graph: std_logic_vector(31 downto 0);
  type state is (initial, multiply, view_result);
  signal CurrentState, NextState : state;

begin
  process(CurrentState,start) begin
    NextState<=initial;
	 result_graph_s<=(others=>'0');
    
    case CurrentState is
      when initial =>         
        en_mul<='0';
        rst_mul<='0';
		  -----result<="11110000010000000010010011110001";
        if(start='0') then
          NextState<=multiply;
        else
          NextState<=initial;
        end if;
        
      when multiply =>
        en_mul<='1';
        rst_mul<='1';
        if(done_mult='1') then
          NextState<=view_result;
        else
          NextState<=multiply;
        end if;
        
      when view_result =>
        
        if(start='0') then
          NextState<=initial;
        else
          NextState<=view_result;
        end if;
        
        
    end case;
  end process;
  
  transitions:process (clk, reset) begin
    if reset='0'then 
      CurrentState <= initial;
    elsif (clk'event and clk='1')then 
      CurrentState <= NextState;
    end if;
  end process;

  uOpA: romMemOpA
    port map (
      addr    => addrA,
      dataOut => romAOut
    );

  uOpB: romMemOpB
    port map (
      addr    => addrB,
      dataOut => romBOut
    );

  uMult: device 
    port map (
      a    => romAOut,
      b    => romBOut,
      clk=>clk ,
      en=> en_mul,
      rst=> rst_mul,
      c =>  result_graph_ss,
      done=>done_mult
    );
	 
	 outtAB_graph: graph_driver port map(in_graph=>outAB_graph_s,out_graph=>outAB);
	 result_graph: graph_driver port map(in_graph=>result_graph_ss,out_graph=>result);
    

	 


  -- When the button assoiciated to outAB is pushed romAOut is displayed
   outAB_graph_s<= romAOut when showAB = '0' 
                   else romBOut;


  ready(7 downto 0) <= (others => done_mult);

end synt;

