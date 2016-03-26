--Mark Wency P. Yambao
--Joseph Alcantara
--CMSC 132 T-4L
--Base vhdl code is taken from laboratory exercise
library IEEE; use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity tb_alarm is
	constant MAX_COMB: integer := 63;
	constant DELAY: time := 10 ns;	--delay
end entity tb_alarm;

architecture rtl of tb_alarm is
	--component declaration
	component alarm is
		port(in1, in2, in3, out1, out2, out3: in std_logic; buzzer: out std_logic);
	end component alarm;
	--signal declaration
	signal in1, in2, in3, out1, out2, out3: std_logic;
	signal buzzer: std_logic;
	
begin --architecture
	--create unit under test
	uut: component alarm port map(in1, in2, in3, out1, out2, out3, buzzer);
	main: process is
	
	variable err_count	: integer   := 0;
	variable temp	: unsigned(5 downto 0);
	variable expected_buzzer	: std_logic;
			
	begin --process
	
		report "start simulation";
		
		for i in 0 to 63 loop
			temp := TO_UNSIGNED(i, 6);
			in1  <= temp(5);
			in2  <= temp(4);
			in3  <= temp(3);
			out1 <= temp(2);
			out2 <= temp(1);
			out3 <= temp(0);
			
            wait for DELAY;
            
			--get expected_buzzer
            expected_buzzer := (in1 or in2 or in3) and (out1 or out2 or out3);
			
            wait for DELAY;
			
			--check if output is same as expected value
			assert(expected_buzzer = buzz)
				report "ERROR: Expected Buzzer " & std_logic'image(expected_buzzer) & " /= actual valid " & 
					std_logic'image(valid) & " at time " & time'image(now);
			
			--number of errors isincremented
			if  (expected_buzzer /= buzz)
				then err_count := err_count + 1;
			end if;
            
            temp := temp + 1;
		end loop;
		
		wait for DELAY;
		--report error
		assert (err_count = 0)
			report "ERROR: There were " &
				integer'image(err_count) & " errors!";
			--else report no error
			if(err_count = 0)
				then report "Simulation completed with NO errors.";
			end if;
		wait;
	end process;
end architecture rtl;
