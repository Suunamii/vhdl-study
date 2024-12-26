/*

Packages and Subprograms 
-------------------------

1. Packages:

    • Packages gruppieren wiederverwendbare Elemente 
      (z. B. Datentypen, Signale, Funktionen, Komponenten).
    • Sie helfen, Code strukturiert und wiederverwendbar zu machen.
    • z.B: ieee.std_logic_1164 ist ein vordefiniertes Package.
    • Eigene Packages können erstellt und in Designs eingebunden werden.

Struktur eines Packages:

- Package-Deklaration: äussere Sichtbarkeit der Inhalte.
- Package-Body: Implementierungsdetails.


*/

use work.user_pkg.all;

library ieee;
use ieee.std_logic_1164.all;

package <identifer> is
-- Declaration
end [package] [identifier];

package body <package name> is
-- Implementation
end [package] [identifier];

/*

2. Subprogramme:

   • Subprogramme sind kleine, wiederverwendbare Code-Blöcke.
   • Sie erleichtern die Strukturierung und Wiederverwendung.
   
    Es gibt zwei Arten:
        - Prozeduren: Führen eine Aufgabe aus, ändern Parameterwerte, 
                      geben aber nichts zurück.
        
        - Funktionen: Berechnen einen Wert und geben diesen zurück.

 Prozeduren:

    - Verwenden in, out, oder inout Parameter.
    - Häufig in Testbenches verwendet, 
       z.B. um Eingaben zu automatisieren

procedure write_data(signal data : out std_logic_vector) is
begin
  data <= "1010";  -- Beispielwert setzen
end procedure;




Funktionen:

    - Berechnen einen Rückgabewert.
    - Verwenden nur in Parameter (keine Änderung der Eingabe).

*/
-- Library and package part
library ieee;
use ieee.std_logic_1164.all;

package user_pkg is
  -- The function needs to be declared here to be visible outside the package
  function bcd2seg7(signal bcd : in std_logic_vector(3 downto 0)) return std_logic_vector;

end package;

package body user_pkg is
  -- implementation details of BCD to 7-segment decoder
  begin
    case bcd is
      when "0000" => return "01000000";
      when "0001" => return "01111001";
      when "0010" => return "00100100";
      when "0011" => return "00110000";
      when "0100" => return "00011001";
      when "0101" => return "00010010";
      when "0110" => return "00000010";
      when "0111" => return "01111000";
      when "1000" => return "00000000";
      when "1001" => return "00010000";
      when "1010" => return "00001000";
      when "1011" => return "00000011";
      when "1100" => return "01000110";
      when "1101" => return "00100001";
      when "1110" => return "00000110";
      when "1111" => return "00001110";
      when others => return "01111111";
    end case;
  end function;
end;

-- In the main design entity this function can be used as demonstrated below.

-- Library and package part
library ieee;
use ieee.std_logic_1164.all;
-- include user defined package
use work.user_pkg.all;

-- entity description
entity example is
  port (
    sw   : in  std_logic_vector(3 downto 0);
    hex0 : out std_logic_vector(7 downto 0)  -- 7-segment display
    );
end entity example;


-- architecture
architecture rtl of example is

  -- declartion area

begin
  -- make use of function declared and implemented in user_pkg.vhd
  hex0 <= bcd2seg7(sw);

end architecture;



-- procedure - example below shows how a procedure 
-- can be declared in a package and used to automate 
-- the test stimuli on the input of a RX UART module.

library ieee;
use ieee.std_logic_1164.all;

package tb_support_pkg is

  constant GC_SYSTEM_CLK : integer := 50_000_000;
  constant GC_BAUD_RATE : integer := 115_200;

  --clock generation parameters
  signal clk : std_logic;
  signal clk_enable : boolean := false;
  constant clk_period : time := 20 ns;
  constant C_BIT_PERIOD : time := clk_period * GC_SYSTEM_CLK/GC_BAUD_RATE;

  -- Support procedure to write serial data
  procedure uart_write_data (
    constant data : in std_logic_vector(7 downto 0); -- data
    signal serial_data : out std_logic; -- serial RX line out
    constant inject_error_stop_bit : boolean := false; -- Error in stop bit
    constant inject_error_start_bit : boolean := false -- Error in start bit
  );

end package;

package body tb_support_pkg is
  -- Support procedure to write serial data
  procedure uart_write_data (
    constant data : in std_logic_vector(7 downto 0); -- data
    signal serial_data : out std_logic; -- serial RX line out
    constant inject_error_stop_bit : boolean := false; -- Error in stop bit
    constant inject_error_start_bit : boolean := false -- Error in start bit
  ) is
  begin

    -- Send start bit with or without error
    if inject_error_start_bit then
      serial_data <= '1';
    else
      serial_data <= '0';
    end if;
    wait for C_BIT_PERIOD;

    -- Send the data bits LSB first
    for bit_pos in 0 to data'length - 1 loop
      serial_data <= data(bit_pos);
      --report "Writint bit " & integer'image(bit_pos) & " of value " & std_logic'image(data(bit_pos)) ;
      wait for C_BIT_PERIOD;
    end loop;

    -- Send stop bit with or without error
    if inject_error_stop_bit then
      serial_data <= '0';
    else
      serial_data <= '1';
    end if;
    wait for C_BIT_PERIOD;

    -- Return to default value for RX.
    serial_data <= '1';
  end procedure;
end;

-- procedure uart_write_data can then be easily used 
-- in the stimuli process of the main test bench.

library ieee;
use ieee.std_logic_1164.all;
use work.tb_support_pkg.all;

entity rx_uart_tb is
end entity;

architecture tb of rx_uart_tb is

  signal areset_n : std_logic;
  signal rx_data : std_logic_vector(7 downto 0);
  signal rx_data_valid : std_logic;
  signal rx_busy : std_logic;
  signal rx : std_logic;
  signal rx_err : std_logic;

begin
  -- create the system clock
  clk <= not clk after clk_period/2 when clk_enable else '0';
  
  -- include the dut
  dut : entity work.rx_uart(rtl)
    generic map(
      GC_SYSTEM_CLK => GC_SYSTEM_CLK,
      GC_BAUD_RATE => GC_BAUD_RATE
    )
    port map(
      clk => clk,
      areset_n => areset_n,
      rx_data => rx_data,
      rx_busy => rx_busy,
      rx_err => rx_err,
      rx => rx
    );

  -- Generate the main test stimuli
  p_stimuli : process
  begin
    report "Starting simulation of RX UART";
    areset_n <= '1';
    clk_enable <= true;
    wait for 100 ns;

    -- toggle restet for at least a few clock cycles
    areset_n <= '0';
    wait for clk_period * 5;
    areset_n <= '1';
    wait for 100 ns;
    
    -- Write the data 0x55 to the RX input
    uart_write_data(x"55", rx);
    -- make sure the data has been received and busy is set
    wait for clk_period*2; 
    -- make sure transaction has been completed
    -- and busy is low before checking received byte
    if rx_busy = '1' then
      wait until rx_busy = '0';
      report "rx_busy goes low - new data has been received";
    end if;

    -- check if correct value has been received by the rx moduel
    assert rx_data = x"55" -- report if not equal to expected byte.
    report "Incorrect byte received!"
      severity warning;

    -- Wait some additional time to allow visual inspection in wave diagram
    wait for 200 ns;
    clk_enable <= false;
    wait;

  end process;

end architecture;
