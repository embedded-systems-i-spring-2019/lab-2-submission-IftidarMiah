-- Lab 2 Iftidar Miah
-- Entity and Architecture for Single Bit Full Adder, used as component of ripple_adder.vhd

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity adder is
    port(   A, B, C_in  : in    std_logic;  -- A,B bits to add. C_in is carry in bit to add.
            S, C_out    : out std_logic);   -- S is sum. C_out is carry out bit.
end adder;

architecture adder_arch of adder is
begin
    -- Logic functions for sum and carry out of a full adder
    S <= (A XOR B) XOR C_in;
    C_out <= ((A XOR B) AND C_in) OR (A AND B);
end adder_arch;