/*

Structure
---------

Eine VHDL-Architektur besteht aus zwei Bereichen:

  • Deklarationsbereich:
        Dieser befindet sich vor dem Schlüsselwort begin.
        Hier deklarierst du Objekte (z. B. Signale oder Variablen), 
        die nur innerhalb der Architektur verwendet werden können 
        und außerhalb nicht sichtbar sind

  • Bereich zwischen begin und end architecture:

    Hier wird die Funktionalität des Systems beschrieben.
    Alle Anweisungen in diesem Bereich sind Concurrent Statements 
    (parallel ausgeführte Anweisungen), 
    die in Hardware-Logik umgesetzt werden.


architecture rtl of example is
  -- Deklarationsbereich
  signal A : std_logic;
begin
  -- Funktionalitätsbereich
  A <= '1'; -- Beispiel für eine Concurrent Statement
end architecture;

  
  
VHDL-Codierungsstile
--------------------
  
In VHDL gibt es drei Hauptstile, die kombiniert werden können:

   • Strukturell:
        Beschreibt die Verbindung von Komponenten, 
          ähnlich wie ein Schaltplan.
 
   • Datenfluss (Data-flow):
        Beschreibt, wie Daten durch die Schaltung fliessen,
          basierend auf logischen Operationen.

   • Verhalten (Behavioral):
        Beschreibt, wie sich die Schaltung verhalten soll, 
          basierend auf Algorithmen oder Zustandsautomaten.


          
Was ist RTL?
-----------
          
 Register Transfer Level (RTL) ist ein Stil in VHDL, der für die Synthese in FPGA-Hardware geeignet ist.
 Es beschränkt sich auf:
     • Kombinatorische Logik (z. B. AND-, OR-Gatter).
     • Speicherelemente (z. B. Flip-Flops, Register).
*/

-- In VHDL können die Schlüsselwörter component und port map verwendet werden, 
-- um ein strukturelles Design zu erstellen.
-- Dabei wird die Schaltung aus bereits vorhandenen Komponenten (wie Gattern) aufgebaut, 
-- die in separaten VHDL-Dateien beschrieben sind.


library IEEE;
use IEEE.std_logic_1164.all;

entity struct_eg is
  port (
    A_IN  : in std_logic;
    B_IN  : in std_logic;
    C_IN  : in std_logic;
    Y_OUT : out std_logic
  );
end entity struct_eg;

architecture structual of struct_eg is
  -- declare signals internal , to connect components
  signal int1 : std_logic;
  signal int2 : std_logic;
  signal int3 : std_logic;

 -- declare components which has been described in another file
component AND_GATE 
  port (
    A, B : in std_logic;
    Y    : out std_logic
  );
end component 

component OR_GATE
  port (
    A, B, C : in std_logic;
    Y       : out std_logic
  );
end component;

begin
  -- connect components togther -> VHDL port map functionality
  A1 : AND_GATE port map (A => A_IN, B => B_IN, Y => int1);
  A2 : AND_GATE port map (A => B_IN, B => C_IN, Y => int2);
  A3 : AND_GATE port map (A => A_IN, B => C_IN, Y => int3);
  O1 : OR_GATE port map (A => int1, B => int2, Y => int3, Y => Y_OUT);

end architecture structual;

  
/*
 Schemaic illustration:
    
       A_IN      B_IN      C_IN
         |        |           |
         |        |           |
         |        |           |
         ._________________   |
         |        |        |  |
         |        |   _____|__.
         |   _____.  |     |  |
         |  |     |  |     |  |
         AND1     AND2     AND3
         |         |         |
        int1     int2       int3 
          \        |        /
            \      |      /
              \    |    /
                \  |  /
                  OR1
                   |
                   |
                 Y_OUT

 

  */


/*
    
    
Data-Flow Modellierung
----------------------


Data-Flow Modellierung beschreibt den Datenfluss in einem Design, 
indem Concurrent Statements zwischen den Schlüsselwörtern begin 
und end architecture verwendet werden.

  Concurrent Statements:

   • Werden parallel ausgeführt, 
     die Reihenfolge der Anweisungen spielt keine Rolle.
  
   • Die Ausführung ist ereignisgesteuert:
        Eine Anweisung wird nur ausgeführt, 
        wenn sich der Wert eines Signals 
        auf der rechten Seite der Zuweisung ändert.    
    
    
    
    
    
    
*/










       
