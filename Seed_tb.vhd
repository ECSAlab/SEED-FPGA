------------------------------------------------------------------------------------------------
--  This source is dedicated to the research paper enttled                                    --
--  "An 8-bit Serialized Architecture of SEED Block Cipher for Constrained Devices"           --
--  on IET Circuits, Devices & Systems journal                                                --
--  Authors : Lampros Pyrgas, Filippos Pirpilidis and Paris Kitsos                            --
--  Institute: University of the Peloponnese                                                  --
--  Department: Electrical and Computer Engineering                                           --
--                                                                                            --
--  This source is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY.  --
------------------------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

-- entity declaration for your testbench.Dont declare any ports here
ENTITY Seed_tb IS
END ;

ARCHITECTURE arc OF Seed_tb IS
	-- Component Declaration for the Unit Under Test (UUT)
	COMPONENT Seed is
port(	

clk: in std_logic;
reset_n: in std_logic;
Key : in std_logic_vector(7 downto 0);   
Mes : in std_logic_vector(7 downto 0);   
Cryp : out std_logic_vector(7 downto 0);   
valid_data : out std_logic   

);
	END COMPONENT;
	
	signal clk : std_logic := '0';
	signal reset_n : std_logic := '0';
	signal Key : std_logic_vector(7 downto 0):= "00000000";    	    
    signal Mes  : std_logic_vector(7 downto 0):= "00001111";   
    signal Cryp : std_logic_vector(7 downto 0);   
    signal valid_data : std_logic;
  	    
	
	-- Clock period definitions
	constant clk_period : time := 20 ns;
BEGIN
	-- Instantiate the Unit Under Test (UUT)
	uut : Seed PORT MAP (
		clk => clk,
		reset_n => reset_n,
		Key=> Key,
		Mes=> Mes,
		Cryp=> Cryp,
		valid_data=> valid_data
		);      
	
	-- Clock process definitions( clock with 50% duty cycle is generated here.
	clk_process :process
	begin
		clk <= '0';
		wait for clk_period/2;  
		clk <= '1';
		wait for clk_period/2;  
	end process;
	-- Stimulus process
	stim_proc: process
	begin        
 	    WAIT FOR clk_period;
        WAIT FOR clk_period;      
		WAIT FOR clk_period;
        reset_n <= '1';
        
--0010 1000 1101 1011 1100 0011 1011 1100 
--0100 1001 1111 1111 1101 1000 0111 1101 
--1100 1111 1010 0101 0000 1001 1011 0001 
--0001 1101 0100 0010 0010 1011 1110 0111
 
--Key<="00001111";              
--WAIT FOR clk_period;       
--Key<="00001110";              
--WAIT FOR clk_period;     
--Key<="00001101";              
--WAIT FOR clk_period;
--Key<="00001100";              
--WAIT FOR clk_period;

--Key<="00001011";              
--WAIT FOR clk_period;
--Key<="00001010";              
--WAIT FOR clk_period;
--Key<="00001001";              
--WAIT FOR clk_period;          
--Key<="00001000";              
--WAIT FOR clk_period;

--Key<="00000111";              
--WAIT FOR clk_period;
--Key<="00000110";              
--WAIT FOR clk_period;
--Key<="00000101";              
--WAIT FOR clk_period;
--Key<="00000100";              
--WAIT FOR clk_period;

--Key<="00000011";              
--WAIT FOR clk_period;
--Key<="00000010";              
--WAIT FOR clk_period;            
--Key<="00000001";              
--WAIT FOR clk_period;           
--Key<="00000000"; 
      
WAIT FOR clk_period;
 	    WAIT FOR clk_period;
WAIT FOR clk_period;      
WAIT FOR clk_period;
 	    WAIT FOR clk_period;
WAIT FOR clk_period;      
WAIT FOR clk_period;
WAIT FOR clk_period;
WAIT FOR clk_period;      
WAIT FOR clk_period;
 	    WAIT FOR clk_period;
WAIT FOR clk_period;      
WAIT FOR clk_period;
WAIT FOR clk_period;
WAIT FOR clk_period;      
WAIT FOR clk_period;




   Mes<="00001111";              
WAIT FOR clk_period;       
Mes<="00001110";              
WAIT FOR clk_period;     
Mes<="00001101";              
WAIT FOR clk_period;
Mes<="00001100";              
WAIT FOR clk_period;

Mes<="00001011";              
WAIT FOR clk_period;
Mes<="00001010";              
WAIT FOR clk_period;
Mes<="00001001";              
WAIT FOR clk_period;          
Mes<="00001000";              
WAIT FOR clk_period;

Mes<="00000111";              
WAIT FOR clk_period;
Mes<="00000110";              
WAIT FOR clk_period;
Mes<="00000101";              
WAIT FOR clk_period;
Mes<="00000100";              
WAIT FOR clk_period;

Mes<="00000011";              
WAIT FOR clk_period;
Mes<="00000010";              
WAIT FOR clk_period;            
Mes<="00000001";              
WAIT FOR clk_period;           
Mes<="00000000";   
  
--        Key<="11100111";              
--        WAIT FOR clk_period;       
--        Key<="00101011";              
--        WAIT FOR clk_period;     
--        Key<="01000010";              
--        WAIT FOR clk_period;
--        Key<="00011101";              
--        WAIT FOR clk_period;
      
--        Key<="10110001";              
--        WAIT FOR clk_period;
--        Key<="00001001";              
--        WAIT FOR clk_period;
--        Key<="10100101";              
--        WAIT FOR clk_period;          
--        Key<="11001111";              
--        WAIT FOR clk_period;

--        Key<="01111101";              
--        WAIT FOR clk_period;
--        Key<="11011000";              
--        WAIT FOR clk_period;
--        Key<="11111111";              
--        WAIT FOR clk_period;
--        Key<="01001001";              
--        WAIT FOR clk_period;

--        Key<="10111100";              
--        WAIT FOR clk_period;
--        Key<="11000011";              
--        WAIT FOR clk_period;            
--        Key<="11011011";              
--        WAIT FOR clk_period;           
--        Key<="00101000";              
    
--1011 0100 0001 1110 0110 1011 1110 0010 
--1110 1011 1010 1000 0100 1010 0001 0100
--1000 1110 0010 1110 1110 1101 1000 0100
--0101 1001 0011 1100 0101 1110 1100 0111
 

  
 
--        Mes<="0111";              
--        WAIT FOR clk_period;
--        Mes<="1100";              
--        WAIT FOR clk_period; 
           
--        Mes<="1110";              
--        WAIT FOR clk_period;
--        Mes<="0101";              
--        WAIT FOR clk_period;       
        
--        Mes<="1100";              
--        WAIT FOR clk_period;
--        Mes<="0011";              
--        WAIT FOR clk_period;       
        
--        Mes<="1001";              
--        WAIT FOR clk_period;
--        Mes<="0101";              
--        WAIT FOR clk_period;       
        


        
        
        
--        Mes<="0100";              
--        WAIT FOR clk_period;
--        Mes<="1000";              
--        WAIT FOR clk_period;       
        
--        Mes<="1101";              
--        WAIT FOR clk_period;
--        Mes<="1110";              
--        WAIT FOR clk_period;       
        
--        Mes<="1110";              
--        WAIT FOR clk_period;
--        Mes<="0010";              
--        WAIT FOR clk_period;       
        
--        Mes<="1110";              
--        WAIT FOR clk_period;
--        Mes<="1000";              
--        WAIT FOR clk_period;       
   



   
--        Mes<="0100";              
--        WAIT FOR clk_period;
--        Mes<="0001";              
--        WAIT FOR clk_period;       
        
--        Mes<="1010";              
--        WAIT FOR clk_period;
--        Mes<="0100";              
--        WAIT FOR clk_period;       
        
--        Mes<="1000";              
--        WAIT FOR clk_period;
--        Mes<="1010";              
--        WAIT FOR clk_period;       
        
--        Mes<="1011";              
--        WAIT FOR clk_period;
--        Mes<="1110";              
--        WAIT FOR clk_period;       
        
        
        
        
      
        
        
--        Mes<="0010";              
--        WAIT FOR clk_period;
--        Mes<="1110";              
--        WAIT FOR clk_period;       
        
--        Mes<="1011";              
--        WAIT FOR clk_period;
--        Mes<="0110";              
--        WAIT FOR clk_period;       
        
--        Mes<="1110";              
--        WAIT FOR clk_period;
--        Mes<="0001";              
--        WAIT FOR clk_period;       
        
--        Mes<="0100";              
--        WAIT FOR clk_period;
--        Mes<="1011"; 
 
 
 
 
 
        
         	
	end process;
	
END;
