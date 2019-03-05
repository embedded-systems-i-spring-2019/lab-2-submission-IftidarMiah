-- Lab 2 Iftidar Miah
-- Test bench for adder.vhd

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std;

entity adder_tb is
end adder_tb;

architecture adder_arch_tb of adder_tb is
    signal A_tb, B_tb, C_in_tb  : std_logic := '0';    -- Input test bench signal declarations
    signal S_tb, C_out_tb       : std_logic;    -- Output test bench signal declarations

    -- Component for adder. Uses entity and architecture from adder.vhd
    component adder
        port(   A, B, C_in  : in    std_logic;
                S, C_out    : out std_logic);
    end component;
begin
    -- Define 3 processes to alternate A, B, and C_in for all 8 possible inputs
    
    A_proc: process     -- Alternate A every 100ns
    begin
        wait for 100ns;
        A_tb <= '1';
        wait for 100ns;
        A_tb <= '0';
    end process A_proc;
    
    B_proc: process     -- Alternate A every 50ns
    begin
        wait for 50ns;
        B_tb <= '1';
        wait for 50ns;
        B_tb <= '0';
    end process B_proc;
    
    C_in_proc: process     -- Alternate A every 25ns
    begin
        wait for 25ns;
        C_in_tb <= '1';
        wait for 25ns;
        C_in_tb <= '0';
    end process C_in_proc;
    
    DUT: adder
        Port Map(   A => A_tb,
                    B => B_tb,
                    C_in => C_in_tb,
                    S => S_tb,
                    C_out => C_out_tb
        );
    
end adder_arch_tb;