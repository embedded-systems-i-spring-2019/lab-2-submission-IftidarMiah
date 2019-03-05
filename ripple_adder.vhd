-- Lab 2 Iftidar Miah
-- 4-bit Ripple Carry Adder. Uses 4 instances of adder from adder.vhd

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity ripple_adder is
    port(   C_in    : in std_logic;
            A, B    : in std_logic_vector(3 downto 0);
            C_out   : out std_logic;
            S       : out std_logic_vector(3 downto 0));
end ripple_adder;

architecture ripple_adder_arch of ripple_adder is
    signal C    : std_logic_vector(2 downto 0); -- Carry ins/outs inside black box
    
    -- adder component, defined by adder.vhd. 4 instances below
    component adder
        port(   A, B, C_in  : in    std_logic;
                S, C_out    : out   std_logic);
    end component;
    
begin
    
    ADD0: adder
        Port Map(   A => A(0), 
                    B => B(0), 
                    C_in => C_in, 
                    S => S(0), 
                    C_out => C(0)
        );
    
    ADD1: adder
        Port Map(   A => A(1), 
                    B => B(1), 
                    C_in => C(0), 
                    S => S(1), 
                    C_out => C(1)
        );
    
    ADD2: adder
        Port Map(   A => A(2), 
                    B => B(2), 
                    C_in => C(1), 
                    S => S(2), 
                    C_out => C(2)
       );
    
    ADD3: adder
        Port Map(   A => A(3), 
                    B => B(3), 
                    C_in => C(2), 
                    S => S(3), 
                    C_out => C_out
        );  
    
end ripple_adder_arch;