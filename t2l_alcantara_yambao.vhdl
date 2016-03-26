--Mark Wency P. Yambao
--Joseph Alcantara
--CMSC 132 T-4L
--Base vhdl code is taken from laboratory exercise
library IEEE;
use IEEE.std_logic_1164.all;

entity alarm is
	port(in1, in2, in3, out1, out2, out3: in std_logic; buzzer: out std_logic);	--declaration of ports
end alarm;

architecture rtl of alarm is
begin
	process (in1, in2, in3, out1, out2, out3) is
	begin
		--solved using k-map
		buzzer <= (in3 and out3) or (in3 and out2) or (out3 and out1) or (in2 and out3) or (in2 and out2) or (out2 and out1) or (in1 and out3) or (in1 and out2) or (out1 and out1); 
	end process;
end architecture;
