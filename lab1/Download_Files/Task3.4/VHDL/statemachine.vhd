LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;

-- ensure components in other 'vhd' project files can be included  
LIBRARY WORK;
USE WORK.ALL;

ENTITY statemachine IS
	PORT(

	   slow_clock : IN STD_LOGIC;
		resetb : IN STD_LOGIC;
		
		dscore, pscore : IN STD_LOGIC_VECTOR(3 downto 0);
		pcard3 : IN STD_LOGIC_VECTOR(3 downto 0);
		
		load_pcard1, load_pcard2, load_pcard3 : OUT STD_LOGIC;
		load_dcard1, load_dcard2, load_dcard3 : OUT STD_LOGIC;
		player_win_light, dealer_win_light : OUT STD_LOGIC
	);
END statemachine;


ARCHITECTURE behavioural OF statemachine IS

BEGIN

-- The code describing your state machine will go here.  Remember that
-- a state machine consists of next state logic, output logic, and the 
-- registers that hold the state.  You will want to review your notes from
-- CPEN 211 or equivalent if you have forgotten how to write a state machine.

END;
 