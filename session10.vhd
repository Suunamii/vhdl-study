/*

Generic Map 
------------

-> macht Module flexibel, ohne Code des Moduls -> zu ändern
indem du Parameter wie die Breite eines Datenbusses einfach anpassen kannst.

Das Modul selbst bleibt unverändert.

Besonders nützlich, wenn du viele ähnliche Instanzen mit leicht 
unterschiedlichem Verhalten erstellen möchtest.

example shown below:

*/

-- 1. in entity -> define generic

entity flex is
    generic(width : integer := 8);  -- Standardwert = 8
    port(
        data : in std_logic_vector(width-1 downto 0)
    );
end entity;


-- 2. generic map

architecture struct of top_level is
    constant bus_width : integer := 16; -- new value
    signal data_bus : std_logic_vector(bus_width-1 downto 0);

begin
    inst: entity work.flex
        generic map(
            width => bus_width -- overwrite value
        )
        port map(
            data => data_bus -- connection
        );
end architecture;




-- mehrere instanzen mit loop 

g_modules: for i in 0 to no_modules-1 generate
  inst: entity work.super_design
    generic map(
      param => i -- Unterschiedlicher Wert für jede Instanz
    )
    port map(
      A(i) => A(i),
      B(i) => B(i)
    );
end generate;


/*

Flexibilität durch width-1

Wenn du 7 downto 0 schreibst, bedeutet das:

    - Der Datenbus hat immer 8 Bits (von Bit 7 bis Bit 0).
    - Das ist statisch und nicht veränderbar.

Mit width-1 downto 0 machst du den Bus:

    Flexibel: Die Breite des Busses kann angepasst werden.
    Beispiel:
        - width = 8 → 7 downto 0 (8 Bits).
        - width = 16 → 15 downto 0 (16 Bits).

Warum width-1?

    Der höchste Bit-Index eines Busses ist immer width-1, weil das Zählen bei 0 beginnt.
    Beispiel für einen 8-Bit-Bus:
        - Die Bits sind: 7, 6, 5, 4, 3, 2, 1, 0.
        - Der höchste Index ist 8-1 = 7.

Formel:

    - Startbit = width-1 (höchstes Bit).
    - Endbit = 0 (niedrigstes Bit).


*/