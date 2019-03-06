-- Lab 2 Iftidar
-- 16 Function 4-bit ALU entity and architecture

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity my_alu is
    port(   clk     : in    std_logic;
            A, B    : in    std_logic_vector(3 downto 0);
            Opcode  : in    std_logic_vector(3 downto 0);
            ALU_out : out   std_logic_vector(3 downto 0));
end my_alu;

architecture my_alu_arch of my_alu is
    signal funct    : std_logic_vector(3 downto 0) := "0000"; -- Intermediate signal for ALU_out
begin
    
    ALU_out <= funct;   -- funct will hold values from alu operations

    ALU_proc: process(clk)
    begin
        if rising_edge(clk) then
            case (to_integer(unsigned(Opcode))) is
                when 0  => funct <= std_logic_vector(unsigned(A) + unsigned(B));
                when 1  => funct <= std_logic_vector(unsigned(A) - unsigned(B));
                -- Case 2: convert int +1 to length 4 unsigned then add/sub to unsigned A
                -- Then convert all to std_logic_vector before assigning to funct
                when 2      => funct <= std_logic_vector((unsigned(A) + to_unsigned(1,4)));
                when 3      => funct <= std_logic_vector((unsigned(A) - to_unsigned(1,4)));
                when 4      => funct <= std_logic_vector((to_unsigned(0,4) - unsigned(A)));
                when 5      => 
                    if (unsigned(A) > unsigned(B)) then
                        funct <=    "0001";
                    else
                        funct <= (others => '0');
                    end if;
                when 6      => funct <= std_logic_vector(unsigned(A) sll 1);
                when 7      => funct <= std_logic_vector(unsigned(A) srl 1);
                when 8      =>
                    if (A(3) = '1') then
                        funct <= ('1' & std_logic_vector(unsigned(A(3 downto 1))));
                    else
                        funct <= std_logic_vector(unsigned(A) srl 1);
                    end if;
                when 9      => funct <= std_logic_vector(not unsigned(A));
                when 10     => funct <= std_logic_vector(unsigned(A) AND unsigned(B));
                when 11     => funct <= std_logic_vector(unsigned(A) OR unsigned(B));
                when 12     => funct <= std_logic_vector(unsigned(A) XOR unsigned(B));
                when 13     => funct <= std_logic_vector(unsigned(A) XNOR unsigned(B));
                when 14     => funct <= std_logic_vector(unsigned(A) NAND unsigned(B));
                when 15     => funct <= std_logic_vector(unsigned(A) NOR unsigned(B));
                when others => funct <= (others => '0');
            end case;
        end if;
    end process ALU_proc;
end my_alu_arch;