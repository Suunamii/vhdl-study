/*

State Machines
--------------

• Moore-Maschine:
    - Die Ausgabe hängt nur vom aktuellen Zustand ab.
    - Stabilere Ausgabe, da sie nicht direkt von Eingaben abhängt.

• Mealy-Maschine:
    - Die Ausgabe hängt vom Zustand und den Eingaben ab.
    - Reagiert schneller auf Änderungen der Eingaben 
      (eine Taktperiode früher als Moore).



Verschiedene Implementierungsansätze in VHDL

• Ein-Prozess-FSM:
    - Alles in einem Prozess (Zustandsübergänge + Ausgaben).
    - Einfach, aber begrenzt bei komplexen Designs.

• Zwei-Prozess-FSM:
    - Ein Prozess für Zustandsübergänge.
    - Ein separater Prozess für die Ausgaben.
    - Besser strukturiert, besonders bei Mealy-Maschinen.

• Drei-Prozess-FSM:
    - Ein Prozess für Eingaben (nächster Zustand).
    - Ein Prozess für Zustände (Speicherung).
    - Ein Prozess für Ausgaben.
    - Gut für komplexe Designs, klare Trennung von Logik.



*/

-- two process moore state m.

architecture moore_twoprocess of statemachine is

  type state_type is (S0, S1, S2);
  signal state_moore : state_type;


begin

p_state : process(clk) is
begin
  if rising_edge(clk) then
    case state_moore is
      when S0 =>
        if din = '1' then
          state_moore <= S1;
        end if;
      when S1 =>
        if din = '0' then
          state_moore <= S2;
        end if;
      when S2 =>
        if din = '1' then
          state_moore <= S0;
        end if;
    end case;
  end if;
end process;

p_comb_out : process(state_moore) is
begin
  case state_moore is
    when S0 =>
      dout <= "00";
    when S1 =>
      dout <= "01";
    when S2 =>
      dout <= "10";
  end case;
end process;

end architecture;


-- two process mealy state m.

architecture mealy_twoprocess of statemachine is

  type state_type is (S0, S1, S2);
  signal state_mealy : state_type;


begin

p_state : process(clk) is
begin
  if rising_edge(clk) then
    case state_mealy is
      when S0 =>
        if din = '1' then
          state_mealy <= S1;
        end if;
      when S1 =>
        if din = '0' then
          state_mealy <= S2;
        end if;
      when S2 =>
        if din = '1' then
          state_mealy <= S0;
        end if;
    end case;
  end if;
end process;


p_comb_out : process(state_mealy, din) is
begin
  case state_mealy is
    when S0 =>
      if din = '1' then
        dout <= "01";
      else
        dout <= "00";
      end if;
    when S1 =>
      if din = '0' then
        dout <= "10";
      else
        dout <= "01";
      end if;
      when S2 =>
      if din = '1' then
        dout <= "00";
      else
        dout <= "10";
      end if;
  end case;
end process;

end architecture;


/*

Fig. 2.56 Simulation result of a Moore and Mealy machine implemented 
using one synchronous process to update the current state 
and one combinational ouput process. 
Notice how the ouputs of the Mealy machine changes 
when the input changes and is one clock cycle in advance of the Moore machine.

Compared to the one process implementation it is worth noticing 
that the output of the two process implementation changes immediately 
as a function of the input. The output logic is now implemented 
in a combinational process and any change on the process’ input signals 
will reflect immediately on the output. 
This is not the case for the one process implementation 
where output logic changes synchronously to the clock. 
Still for both the one process and two process implementation, 
the outputs of the Mealy machine changes one clock cycle in advance 
of the Moore machine.

*/