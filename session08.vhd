/* 

Process
--------

prozess ->  kombinatorisch oder synchronisierte logik beschrieben.

 • kombinatorische logik: logiksgatter, die auf eingangsänderung reagieren.
 • synch. logik: FF oder register mit taktsignal

 aufbau: 
    1. sensitivity list: which creating signals chnages 
    2. declaration area: local variables 
    3. obey area: process -> which command when 


sensitivity list :

process(sensitivity list)
begin
 ...
end process;
...

*/

-- kombinatorisch process

process (A, B, SEL)
begin
    if SEL = '1' then
        Y <= A;
    else
        Y <= B;
    end if;
end process;


-- synch process

p_reg: process(clk) is
begin
  -- do not write anything here
  if rising_edge(clk) then
    -- your logic is described solely within the rising_edge(clk)
    Y <= A;
  end if;
  -- do not write anything here
end process;

-- For a synchronous process, 
-- only the clock signal shall be present in the sensitivity list,
-- unless the process has an asynchronous reset.

-- asyn. reset 

p_reg: process(clk, areset) is
begin
    -- do not wirite anything here
    if areset = '1'  then 
     Y <= '0';
    elseif rising_edge(clk) then
        Y <= A;
    end if;
    -- do not write here anything
end process;


-- synch. reset

p_reg: process(clk) is
begin
  -- do not write anything here
  if rising_edge(clk) then
    if reset = '1' then
      Y <= '0';
    else
      Y <= A;
  end if;
  -- do not write anything here
end process;


/*

Häufige Fehler

    • Unvollständige Sensitivitätsliste:
        Fehlt ein Signal, wird der Prozess bei Änderungen dieses Signals 
        nicht ausgelöst.
            Beispiel: Wenn SEL fehlt, wird es ignoriert.

    • Latch-Erzeugung:
        Wenn nicht alle möglichen Zustände abgedeckt sind, 
        wird ein Speicher (Latch) eingefügt.
            Lösung: Standardwerte oder eine else-Anweisung nutzen.

*/

-- e.g. with Standardwerte

process(A, B, SEL)
begin
  Y <= A; -- Standardwert
  if SEL = '1' then
    Y <= B;
  end if;
end process;


-- 


