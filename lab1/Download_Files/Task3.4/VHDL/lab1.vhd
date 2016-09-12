-- This module contains a Verilog description of the top level module
-- Assuming you don't modify the inputs and outputs of the various submodules,
-- you should not have to modify anything in this file.


LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;

-- ensure components in other 'vhd' project files can be included  
LIBRARY WORK;
USE WORK.ALL;

ENTITY lab1 IS
	PORT(
      CLOCK_50 : IN STD_LOGIC; -- the fast clock for clocking deal_hand
		KEY : IN STD_LOGIC_VECTOR(3 downto 0);  -- includes slow_clock and reset
      LEDR : OUT STD_LOGIC_VECTOR(9 downto 0);
		HEX5 : OUT STD_LOGIC_VECTOR(6 DOWNTO 0);  -- digit 5
		HEX4 : OUT STD_LOGIC_VECTOR(6 DOWNTO 0);  -- digit 4
		HEX3 : OUT STD_LOGIC_VECTOR(6 DOWNTO 0);  -- digit 3
		HEX2 : OUT STD_LOGIC_VECTOR(6 DOWNTO 0);  -- digit 2
		HEX1 : OUT STD_LOGIC_VECTOR(6 DOWNTO 0);  -- digit 1
		HEX0 : OUT STD_LOGIC_VECTOR(6 DOWNTO 0)   -- digit 0
	);
END lab1;


ARCHITECTURE structural OF lab1 IS

      component datapath is
	      PORT(
	         slow_clock : IN STD_LOGIC;
	       	fast_clock : IN STD_LOGIC;
		      resetb : IN STD_LOGIC;
		      load_pcard1, load_pcard2, load_pcard3 : IN STD_LOGIC;
		      load_dcard1, load_dcard2, load_dcard3 : IN STD_LOGIC;
		      pcard3_out	: out STD_LOGIC_VECTOR(3 downto 0);		
		      pscore_out, dscore_out : out STD_LOGIC_VECTOR(3 downto 0);
		      HEX5 : OUT STD_LOGIC_VECTOR(6 DOWNTO 0);  -- digit 5
		      HEX4 : OUT STD_LOGIC_VECTOR(6 DOWNTO 0);  -- digit 4
		      HEX3 : OUT STD_LOGIC_VECTOR(6 DOWNTO 0);  -- digit 3
		      HEX2 : OUT STD_LOGIC_VECTOR(6 DOWNTO 0);  -- digit 2
	      	HEX1 : OUT STD_LOGIC_VECTOR(6 DOWNTO 0);  -- digit 1
      		HEX0 : OUT STD_LOGIC_VECTOR(6 DOWNTO 0)   -- digit 0			
	      );		
   	end component;
 
      component statemachine is
      	PORT(
       	   slow_clock : IN STD_LOGIC;
		      resetb : IN STD_LOGIC;
		      dscore, pscore : IN STD_LOGIC_VECTOR(3 downto 0);
		      pcard3 : IN STD_LOGIC_VECTOR(3 downto 0);
		      load_pcard1, load_pcard2, load_pcard3 : OUT STD_LOGIC;
		      load_dcard1, load_dcard2, load_dcard3 : OUT STD_LOGIC;
		      player_win_light, dealer_win_light : OUT STD_LOGIC			
      	);		
		end component;

   SIGNAL fast_clock, slow_clock, resetb : STD_LOGIC;
	SIGNAL load_pcard1, load_pcard2, load_pcard3: STD_LOGIC;
	SIGNAL load_dcard1, load_dcard2, load_dcard3 : STD_LOGIC;
	SIGNAL pscore, dscore : STD_LOGIC_VECTOR(3 downto 0);
	SIGNAL pcard3 : STD_LOGIC_VECTOR(3 downto 0);
	
BEGIN
	resetb <= KEY(3);
   slow_clock <= KEY(0);
	fast_clock <= CLOCK_50;
	
  	dp : datapath PORT MAP(
	   slow_clock => slow_clock,
		fast_clock => fast_clock,
		resetb => resetb,
		load_pcard1 => load_pcard1,
		load_pcard2 => load_pcard2,
		load_pcard3 => load_pcard3,
		load_dcard1 => load_dcard1,
		load_dcard2 => load_dcard2,
		load_dcard3 => load_dcard3,
		dscore_out => dscore,
		pscore_out => pscore,
		pcard3_out => pcard3,
		HEX5 => HEX5,
		HEX4 => HEX4,
		HEX3 => HEX3,
		HEX2 => HEX2,
		HEX1 => HEX1,
		HEX0 => HEX0 );		
	      
	sm : statemachine PORT MAP (
	   slow_clock => slow_clock,
		resetb => resetb,
		dscore => dscore,
		pscore => pscore,
		pcard3 => pcard3,
		load_pcard1 => load_pcard1,
		load_pcard2 => load_pcard2,
		load_pcard3 => load_pcard3,
		load_dcard1 => load_dcard1,
		load_dcard2 => load_dcard2,
		load_dcard3 => load_dcard3,
      player_win_light => LEDR(8),
      dealer_win_light => LEDR(9));

LEDR(3 downto 0) <= pscore;
LEDR(7 downto 4) <= dscore;		
	
END;
