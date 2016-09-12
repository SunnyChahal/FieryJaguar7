LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY card7seg IS
	PORT(
		card : IN  STD_LOGIC_VECTOR(3 DOWNTO 0);  -- card type (Ace, 2..10, J, Q, K)
		seg7 : OUT STD_LOGIC_VECTOR(6 DOWNTO 0)   -- top seg 'a' = bit0, proceed clockwise
	);
END;


ARCHITECTURE behavioral OF card7seg IS

BEGIN
   -- Your code for card7seg goes here. You can basically take the code directly
   -- from your solution to Phase 2 (but notice that the inputs and outputs have
   -- different names here).  Recall from Phase 2 that this is a purely 
   -- combinational block.  

END;
