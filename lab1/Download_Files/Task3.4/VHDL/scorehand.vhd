LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.numeric_std.ALL;

ENTITY scorehand IS
	PORT(
	   card1, card2, card3 : IN STD_LOGIC_VECTOR(3 downto 0);
		total : OUT STD_LOGIC_VECTOR( 3 DOWNTO 0)  -- total value of hand
	);
END scorehand;


ARCHITECTURE behavioral OF scorehand IS

BEGIN

-- The code describing scorehand will go here.  Remember this is a combinational
-- block.  The function is described in the handout.  Be sure to read the section
-- on representing numbers in Slide Set 2.

END;
