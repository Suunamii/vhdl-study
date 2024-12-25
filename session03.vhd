/*

Objects
-------

Objects in VHDL is a named item that has a value of a specific type.
Most important objets in VHDL are:

• signals
• variables
• constans



Signals
-------

Ein Signal in VHDL kann wie ein Draht oder eine Verbindung betrachtet werden 
– also etwas, das tatsächlich eine physische Verbindung in der Hardware darstellt.


Wo werden Signale deklariert?

    • Innerhalb der Architektur:
        Für Signale, die nur intern im Modul verwendet werden.

    • In der Entity-Deklaration:
        Für Signale, die zum Verbinden mit anderen Modulen genutzt werden.

    • In Paketen:
        Für Signale, die in mehreren Modulen sichtbar oder wiederverwendbar sein sollen.

Wie wird ein Signal deklariert?

    • Mit dem Schlüsselwort signal.
    • Eine typische Deklaration umfasst:
        - Einen Namen (Identifier).
        - Einen Typ (z. B. std_logic).
        - Einen optional festgelegten Standardwert.

signal <identifier> : <type> [:= initial_value]

signal clk : std_logic := '0';


Circuit:

 A o------------|>o---,  C (=internal signal)
                      ---------
 B o--------------------------- D-------o Y

                 t1 (=A invert gate), t2 (=and gate)



Ein Signal C wird innerhalb der Architektur deklariert (siehe Beispiel in Abbildung 2.8). Dieses Beispiel zeigt auch das Konzept der parallelen Signalzuweisung (Concurrent Signal Assignment) in VHDL.
Signalzuweisung in VHDL

    Signalzuweisungen verwenden den Operator <=.

    Im Beispiel:
        Der invertierte Wert von A wird C zugewiesen.
        Das Ergebnis der Operation B AND C wird Y zugewiesen.

    Wichtig: Diese beiden Zuweisungen sind parallel (gleichzeitig).
        Das bedeutet, dass beide in Hardware umgesetzt werden, wobei:
            Ein Inverter den Eingang A verarbeitet.
            Ein UND-Gatter die Eingänge B und C kombiniert.

Verzögerungen durch Gatter (Gate Delay)

    In Hardware braucht eine Änderung eines Signals Zeit, 
    um durch die logischen Gatter zu propagieren (diese Zeit nennt man Gate Delay).
    
        • Eine Änderung bei A wird nach einer Zeitspanne 
          t1 im Signal C sichtbar.

        • Die Änderung von C beeinflusst das Signal Y 
          erst nach einer weiteren Zeitspanne t2.

*/

library ieee;
use ieee.std_logic_1164.all;

entity circuit1 is
    port(
        A : in std_logic;
        B : in std_logic;
        Y : out std_logic
    );
end entity circuit1;

architecture func of circuit1 is

signal C : std_logic;

begin

-- Concurrent statemants

C <= not A;
Y <= B and C;

end architecture;
