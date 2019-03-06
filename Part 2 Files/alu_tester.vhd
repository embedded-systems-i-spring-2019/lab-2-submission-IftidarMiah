-- Lab 2 Iftidar Miah
-- ALU tester, uses switches, buttons, LEDS, and debounce circuits to test alu.vhd
-- Include my_alu.vhd and debounce.vhd as design sources

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity alu_tester is
    port(   clk         : in    std_logic;
            btn, sw     : in    std_logic_vector(3 downto 0);
            led         : out   std_logic_vector(3 downto 0));
end alu_tester;

architecture alu_tester_arch of alu_tester is
    signal btn_val  : std_logic_vector(3 downto 0) := "0000";   -- Holds output of debounce circuits and pushes to button inputs of ALU
    signal A_val   : std_logic_vector(3 downto 0) := "0000";    -- Register to hold A,B, and Op values
    signal B_val   : std_logic_vector(3 downto 0) := "0000";
    signal Op_val   : std_logic_vector(3 downto 0) := "0000";
    
    component my_alu
        port(   clk     : in    std_logic;
                A, B    : in    std_logic_vector(3 downto 0);
                Opcode  : in    std_logic_vector(3 downto 0);
                ALU_out : out   std_logic_vector(3 downto 0));
    end component;
    
    component debounce
        port(   clk, btn   : in    std_logic;
                dbnc        : out   std_logic);
    end component;
    
begin
   
    alu_test_proc: process(clk)     -- Synchronous process
    begin
        if rising_edge(clk) then
            case (btn_val) is                   -- Update B, A, or Op value when appropriate button pressed
                when "0001" => B_val <= sw;
                when "0010" => A_val <= sw;
                when "0100" => Op_val <= sw;
                when "1000" =>                  -- Reset A, B, and Opcode values
                    Op_val  <= (others => '0');
                    A_val   <= (others => '0');
                    B_val   <= (others => '0');
                when others =>
            end case;
        end if;
    end process alu_test_proc;

    -- 4 debounce circuits for 4 buttons
    btn0:   debounce
        Port Map(
                    clk => clk,
                    btn => btn(0),
                    dbnc => btn_val(0)
        );
        
    btn1:   debounce
        Port Map(
                    clk => clk,
                    btn => btn(1),
                    dbnc => btn_val(1)
        );
        
    btn2:   debounce
    Port Map(
                clk => clk,
                btn => btn(2),
                dbnc => btn_val(2)
    );
    
    btn3:   debounce
    Port Map(
                clk => clk,
                btn => btn(3),
                dbnc => btn_val(3)
    );
    
    -- ALU instance
    alu:    my_alu
    Port Map(   clk     => clk,
                A       => A_val,
                B       => B_val,
                Opcode  => Op_val,
                ALU_out => led
    );
        
    
end alu_tester_arch;