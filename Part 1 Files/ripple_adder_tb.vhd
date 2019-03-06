-- Lab 2 Iftidar Miah
-- Test bench for ripple_adder.vhd

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity ripple_adder_tb is
end ripple_adder_tb;

architecture ripple_adder_arch_tb of ripple_adder_tb is
    signal C_in_tb      : std_logic;
    signal A_tb, B_tb   : std_logic_vector(3 downto 0);
    signal C_out_tb     : std_logic;
    signal S_tb         : std_logic_vector(3 downto 0);
    
    component ripple_adder
        port(   C_in    : in std_logic;
                A, B    : in std_logic_vector(3 downto 0);
                C_out   : out std_logic;
                S       : out std_logic_vector(3 downto 0));
    end component;
    
begin

    -- 4 addition tests
    -- 0000 + 0000 + 1 = 0 0001
    -- 0110 + 1001 + 0 = 0 1111
    -- 1001 + 0111 + 1 = 1 0001
    -- 1111 + 1001 + 1 = 1 1001
    A_proc: process
    begin
        wait for 8ns;
        A_tb <= "0000";
        wait for 8ns;
        A_tb <= "0110";
        wait for 8ns;
        A_tb <= "1001";
        wait for 8ns;
        A_tb <= "1111";
    end process A_proc;
    
    B_proc: process
    begin
        wait for 8ns;
        B_tb <= "0000";
        wait for 8ns;
        B_tb <= "1001";
        wait for 8ns;
        B_tb <= "0111";
        wait for 8ns;
        B_tb <= "1001";
    end process B_proc;
    
    C_in_proc: process
    begin
        wait for 8ns;
        C_in_tb <= '1';
        wait for 8ns;
        C_in_tb <= '0';
        wait for 8ns;
        C_in_tb <= '1';
        wait for 8ns;
        C_in_tb <= '1';
    end process C_in_proc;
    
    DUT: ripple_adder
        Port Map(   C_in => C_in_tb,
                    A => A_tb,
                    B => B_tb, 
                    C_out => C_out_tb,
                    S => S_tb
        );
        
end ripple_adder_arch_tb;