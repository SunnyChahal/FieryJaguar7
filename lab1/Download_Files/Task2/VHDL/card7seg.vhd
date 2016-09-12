LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY card7seg IS
	PORT(
		SW : IN  STD_LOGIC_VECTOR(3 DOWNTO 0);  -- SW type (Ace, 2..10, J, Q, K)
		HEX0 : OUT STD_LOGIC_VECTOR(6 DOWNTO 0)   -- top seg 'a' = bit0, proceed clockwise
	);
END;


ARCHITECTURE behavioral OF card7seg IS
BEGIN
	
   -- Your code for Phase 2 goes here.  Be sure to check the Slide Set 2 notes,
   -- since one of the slides almost gives away the answer here.  I wrote this as
   -- a single combinational process containing a single CASE statement, but there are 
   -- other ways to do it.

END;
