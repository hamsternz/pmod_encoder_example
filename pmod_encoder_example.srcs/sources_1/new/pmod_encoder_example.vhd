library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity encoder_demo is
    Port (
        clk     : in  STD_LOGIC;
        encoder : in  STD_LOGIC_VECTOR ( 1 downto 0);
        leds    : out STD_LOGIC_VECTOR ( 3 downto 0)
    );
end encoder_demo;

architecture Behavioral of encoder_demo is
    signal encoder_unsafe_to_use : STD_LOGIC_VECTOR ( 1 downto 0) := (others => '0');
    signal encoder_safe          : STD_LOGIC_VECTOR ( 1 downto 0) := (others => '0');
    signal encoder_last          : STD_LOGIC_VECTOR ( 1 downto 0) := (others => '0');    
    signal count                 : unsigned(3 downto 0)            := (others => '0'); 
begin

    leds <= std_logic_vector(count);
    
process(clk)
    begin
        if rising_edge(clk) then
            case encoder_last & encoder_safe is
                when "00" & "01" => count <= count + 1;
                when "01" & "11" => count <= count + 1;
                when "11" & "10" => count <= count + 1;
                when "10" & "00" => count <= count + 1;
                when "00" & "10" => count <= count - 1;
                when "10" & "11" => count <= count - 1;
                when "11" & "01" => count <= count - 1;
                when "01" & "00" => count <= count - 1;
                when others =>
            end case;

            encoder_last          <= encoder_safe;
            -- Synchronizer
            encoder_safe          <= encoder_unsafe_to_use;
            encoder_unsafe_to_use <= encoder;
        end if;
    end process;

end Behavioral;
