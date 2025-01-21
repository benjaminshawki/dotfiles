library ieee;
use ieee.std_logic_1164.all;

entity fsm_egg_timer is
	port (
		clk, reset, btn, cnt_done : in std_ulogic;
		cnt_enable, cnt_reset, led : out std_ulogic
	);
end entity;

architecture rtl of fsm_egg_timer is

	-- Define an enumerated type for the state machine
	type state_type is (idle, button, cnting, done);

	-- Register to hold the current state
	signal present_state, next_state : state_type;

begin
	-- state register
	pr_flipflops : process (clk, reset)
	begin
		if reset then
			present_state <= idle;
		elsif rising_edge(clk) then
			present_state <= next_state;
		end if;
	end process;
 
	-- logic to determine the next state
	pr_next_state : process (present_state, btn, cnt_done)
	begin
		case present_state is
			when idle => 
				if btn then
					next_state <= button;
				else
					next_state <= idle;
				end if;
			when button => 
				if not btn then
					next_state <= cnting;
				else
					next_state <= button;
				end if;
			when cnting => 
				if cnt_done then
					next_state <= done;
				else
					next_state <= cnting;
				end if;
			when done => 
				next_state <= done;
		end case;
	end process;

	-- Logic to determine the outputs
	pr_outputs : process (present_state)
	begin
		case present_state is
			when idle => 
				cnt_enable <= '0';
				cnt_reset <= '1';
				led <= '0';
			when button => 
				cnt_enable <= '0';
				cnt_reset <= '1';
				led <= '0';
			when cnting => 
				cnt_enable <= '0';
				cnt_reset <= '0';
				led <= '0';
			when done => 
				cnt_enable <= '1';
				cnt_reset <= '0';
				led <= '1';
		end case;
	end process;
end architecture;