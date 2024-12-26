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
    
    
Z <= A and B;
Z <= C and D;  -- Mehrfachzuweisung an Z    
    --> ERROR
    

Solution:

Statt Mehrfachzuweisungen kannst du eine bedingte Zuweisung verwenden:


Z <= (A and B) when ena = '1' else (C and D);

--

Die Syntax für when-else:

result_signal <= expression_1 when condition_1 else
                 expression_2 when condition_2 else
                 expression_3 when condition_3 else
                 :
                 expression_n;



Eine Alternative ist die with-select-Anweisung:

with input_signal select
  result_signal <= expression_1 when condition_1,
                   expression_2 when condition_2,
                   expression_3 when condition_3,
                   :
                   expression_n when others;

    Unterschied zu when-else:
        • with-select prüft nur einen Eingang (z. B. input_signal).
        • when-else kann mehrere Eingänge und Bedingungen prüfen.
        • with-select entspricht eher der Funktion eines Multiplexers.

  

Behavioral Modellierung
-----------------------

• Behaviorale Modellierung beschreibt, 
  wie sich die Schaltung verhalten soll, ohne sich darum zu kümmern, 
  wie sie tatsächlich in Hardware umgesetzt wird.

• Sie arbeitet auf der höchsten Abstraktionsebene 
  und ähnelt mehr einem Algorithmus als einer konkreten Hardware-Beschreibung.



Wann wird sie verwendet?

  1. Testbenches:
      • Behaviorale Beschreibungen werden oft verwendet, 
        um Testbenches zu schreiben, mit denen das Verhalten
        einer Schaltung überprüft wird.

  2. Hardware-Implementierung:
      • Unter bestimmten Einschränkungen 
        (z. B. Nutzung einer begrenzten Menge der VHDL-Syntax) 
        kann auch Hardware mit behavioralem Stil beschrieben werden.
      • Dabei wird auf kombinatorische Logik (Gatter) 
        und Speicher (Register) reduziert 
         -> siehe Register Transfer Level (RTL).

  example:

Ein Multiplexer wählt basierend auf einem Steuersignal (SEL), 
welcher Eingang (A oder B) an den Ausgang (Y) weitergegeben wird.

Wenn SEL = 0 ist, wird A an Y weitergegeben.
Wenn SEL = 1 ist, wird B an Y weitergegeben.
-- eine logische Verknüpfung mit AND, OR und NOT.

*/

-- 1. Data-Flow- Modellierung
architecture description_model of mux is
begin
  Y <= ((not sel) and A) or (sel and B);
end architecture;

-- 2. Behavioral-Modellierung
architecture desc_model of mux is
begin
  process(sel, A, B) is
  begin
    if sel = '0' then
      Y <= A;
    else
      Y <= B;
  end if;
end process;

/*


Data-Flow-Modellierung:
  • Logisch und direkt.
  • Zeigt, wie die Signale miteinander verknüpft sind.
  • Basiert auf logischen Operationen.


A ___________
             \ 
              AND Y~0   ________
            o                   \
           /                     \
          /                       \
         /                         OR Y~2 ____ Y
        |                        /
B  _____|______                 /
        |      \               /
        |       AND Y~1  _____/
        |    __/
        |   /
SEL ____•__/
 
=> Quartus wont think of using a multiplexer gatter



Behaviorale Modellierung:
  • Beschreibt das Verhalten auf einer abstrakteren Ebene 
    (z. B. mit Bedingungen oder Algorithmen).
  • Ist flexibler, da sie komplexe Verhaltensweisen 
    einfacher ausdrücken kann.

SEL _______________
                   |
                \  |
                |\ | Y
                | \|
                |  \
                |   \
             0  |    \
B ______________|     |
                |     |_____________ Y
                |     |
                |     |
             1  |    /
A ______________|   /
                |  /
                | /
                |/
                /

=> Quartus has interpreted the behaviour as a multiplexer !





Register Transfer Level (RTL)
----------------------------



Was ist ein FPGA?

    Ein FPGA (Field-Programmable Gate Array) ist eine Matrix 
    aus logischen Blöcken, die miteinander verbunden sind.

    Jeder logische Block enthält zwei wichtige Bausteine:
      • Look-Up Table (LUT):
            Für kombinatorische Logik (z. B. AND-, OR-, NOT-Gatter).
      • Register:
            Zum Speichern von Daten (z. B. Zwischenergebnisse).

      
Wie funktioniert die Synthese von VHDL zu FPGA-Hardware?

  • Die Synthese ist der Prozess, bei dem eine VHDL-Beschreibung 
     in Hardware umgesetzt wird.
  
  • Der Synthese-Tool (Software) übersetzt die Funktionalität, 
    die in VHDL beschrieben ist, in die verfügbaren FPGA-Ressourcen:
        - LUTs für kombinatorische Logik.
        - Register für die Speicherung der Ergebnisse


Welche VHDL-Stile werden für RTL genutzt?

RTL kann eine Mischung aus verschiedenen VHDL-Stilen sein:

  • Strukturell: Verbindungen zwischen Bausteinen.
  • Datenfluss (Data-flow): Logik und Signalverarbeitung.
  • Begrenzte Verhaltensbeschreibung (Behavioral): 
      Für Zustände und einfache Algorithmen.
*/
























       
