/*

 Metastabilität und Synchronisation
 ----------------------------------

Metastabilität tritt in digitalen Schaltungen wie FPGAs auf 
und kann zu Fehlern führen. Sie entsteht in zwei Situationen:

    • Asynchrone Taktbereiche: Signale wechseln zwischen Bereichen 
      mit unterschiedlichen Taktsignalen (z. B. clk1 und clk2).

    • Lange kombinatorische Pfade: Signale benötigen zu viel Zeit, 
      um zwischen Registern stabil zu werden.


Setup- und Hold-Zeiten
----------------------

Jedes Flip-Flop hat zwei wichtige Anforderungen:

   • Setup-Zeit: Die Daten müssen stabil sein, bevor die Taktflanke eintrifft.

   • Hold-Zeit: Die Daten müssen nach der Taktflanke stabil bleiben.

Wenn diese Zeiten nicht eingehalten werden, 
kann ein Flip-Flop in einen metastabilen Zustand geraten, in dem der Ausgang vorübergehend unvorhersehbar ist.



Pipelining
-----------

Pipelining -> um lange kombinatorische Pfade zu verkürzen:

    • Ein zusätzlicher Register wird eingefügt, 
      um die Logik in zwei kürzere Pfade zu teilen.

    • Dadurch wird das Timing verbessert, 
      auch wenn das Signal um einen Taktzyklus verzögert wird.



Synchronisation
---------------

Nutzt Register, um Signale an den lokalen Takt anzupassen.


Um Metastabilität bei asynchronen Signalen zu vermeiden:

    •  Signal -> durch zwei Register durchbringen, 
       die mit lokalen Takt synchronisiert sind.

         -> stabilisiert das Signal, vor weiterverarbeitung



Edge detection
--------------

Erkennt Signaländerungen (Flanken) und erzeugt kurze, stabile Impulse.


Ein externes Signal wie ein Tastendruck 
kann ein Ereignis in der FPGA-Logik auslösen.
Problem: Ein Tastendruck dauert oft länger als ein Taktzyklus, 
was zu mehrfachen Zählimpulsen führen kann.

Lösung:

    1. Flanke erkennen (z. B. fallende Flanke):
        • Das Signal durch ein Register führen.
        • Die Flanke durch Vergleich von aktuellem 
          und vorherigem Zustand erkennen.
   
    2. Ein einzelnes Impuls-Signal erzeugen, 
       das genau einen Taktzyklus dauert


*/

architecture rtl of edge_detection is
begin
  
  p_reg: process(clk)
    begin
      if rising_edge(clk) then
        -- trigger on the external active low signal signal
        if enable = '0' then  
          counter <= counter + 1;
        end if;
      end if;
  end process;

end architecture;




architecture rtl of edge_detection is
  signal enable_i_n : std_logic;
begin
  
  p_reg: process(clk)
    begin
      if rising_edge(clk) then
        enable_i_n <= enable_n;
      end if;
  end process;

  -- Create the falling edge detection and thus
  -- a pulse with a duration of one single clock
  -- cycle
  pulse <= not enable_n and enable_i_n;

  -- If you want to create a pulse on the rising edge
  -- of the input enable signal, place instead the inverter
  -- at the output of the register, effectively inverting
  -- the enable_i_n signal as shown in the commented line
  -- below.
  -- pulse <= enable_n and not enable_i_n;

end architecture;



library ieee;
use ieee.std_logic_1164.all;

-- This module detects the falling edge of the asynchronous
-- active low incoming enable_n signal and generates a single
-- active high output pulse with a duration equal to the length of
-- one clock cycle of the incoming clock clk.
entity edge_detection is
port (
  clk : in std_logic; 
  enable_n : in std_logic; 
  pulse : out std_logic 
);
end edge_detection;


architecture rtl of edge_detection is

  -- Signal for the two synchronization registers
  signal enable_r1_n : std_logic;
  signal enable_r2_n : std_logic;
  -- Signal for the edge detection register
  signal enable_i_n : std_logic;
begin
  
  -- This process the 3 registeres through
  -- which the input enable signal is clocked to
  -- to first synchronize the signal and then to add
  -- a register used for the combinational edge detection logic
  -- described in the separate statement below. 
  p_synchronization: process(clk)
    begin
      if rising_edge(clk) then
        -- First bring the input signal through the 
        -- two synchronization registers
        enable_r1_n <= enable_n;
        enable_r2_n <= enable_r1_n;
        -- Additional register for edge detection functionality
        enable_i_n <= enable_r2_n;
      end if;
  end process;

  -- Create the falling edge detection and thus
  -- a pulse with a duration of one single clock
  -- cycle
  pulse <= not enable_r2_n and enable_i_n;

end architecture;