/*

Testbench
---------

• ein design zu testen  bevor es auf FPGA ausgeführt wird.

• simuliert eingänge -> Design (stimuli) und testet die ausgänge.


Wie ?

    1. Kein Eingang und Ausgang in der Testbench-Entity:

        • Im Gegensatz zu deinem Design hat die Testbench-Entity keine Ports 
          (Eingänge oder Ausgänge).
        • Alle Signale werden intern in der Testbench generiert und überwacht.

    2. Signalverbindungen:

        • In der Architektur der Testbench werden Signale deklariert, 
          die mit den Ports des Designs verbunden werden.

    e.g:

        signal A : std_logic;
        signal B : std_logic;
        signal SUM : std_logic;
        signal COUT : std_logic;

    3. Direkte -Instanziierung/ -Design verwendung:

       • Dein Design wird in der Testbench direkt instanziiert 
         und mit den Testbench-Signalen verbunden:

        dut: entity work.half_adder(rtl)
            port map (
                A => A,
                B => B,
                SUM => SUM,
                COUT => COUT
            );


    4. Stimuli erzeugen:

       • process-Block Eingabewerte (Stimuli) definieren:

        p_stimuli: process
        begin
            A <= '0'; B <= '0'; wait for 50 ns;
            A <= '1'; B <= '0'; wait for 50 ns;
            A <= '0'; B <= '1'; wait for 50 ns;
            A <= '1'; B <= '1'; wait for 50 ns;
            wait; -- Beendet die Simulation.
        end process;

*/

-- example : testbench for half_adder
-- 1. the Design -> half_adder.vhd

entity half_adder is
    port (
        A : in std_logic;
        B : in std_logic;
        SUM : out std_logic;
        COUT : out std_logic
    );
end entity half_adder;


-- 2. the testbench -> half_adder_tb.vhd

entity half_adder_tb is
-- The entity declaration of
-- a testbench is empty.
end entity;

architecture tb of half_adder_tb is
    signal A, B, SUM, COUT : std_logic;
begin
    dut: entity work.half_adder(rtl)
        port map (
            A => A,
            B => B,
            SUM => SUM,
            COUT => COUT
        );
    
    p_stimuli: process
    begin
        A <= '0'; B <= '0'; wait for 50 ns;
        A <= '1'; B <= '0'; wait for 50 ns;
        A <= '0'; B <= '1'; wait for 50 ns;
        A <= '1'; B <= '1'; wait for 50 ns;
        wait;                                -- stop the simulation
    end process;
end architecture half_adder_tb;