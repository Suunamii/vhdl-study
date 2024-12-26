What is VHDL ? (my notes)
---

- Ein FPGA besteht aus **LUTs** und **Registern**, die für kombinatorische und sequenzielle Logik verwendet werden.  
- Die **Synthese** wandelt eine VHDL-Beschreibung in diese Hardware-Ressourcen um.  
- **RTL** beschreibt den Datenfluss zwischen Registern und wird benötigt, um ein Design in Hardware umzusetzen.

--- 

- In der **Testbench** erzeugst man Signale, die die Eingänge und Ausgänge des Designs simulieren

Dann verwendest du die direkte Instanziierung, um dein Design in die Testbench einzubinden:

```vhdl
dut: entity work.half_adder(rtl)
  port map (
    A => A,           -- Signal A aus der Testbench wird mit Eingang A des Designs verbunden
    B => B,           -- Signal B aus der Testbench wird mit Eingang B des Designs verbunden
    SUM => SUM,       -- Ausgang SUM des Designs wird mit Signal SUM der Testbench verbunden
    COUT => COUT      -- Ausgang COUT des Designs wird mit Signal COUT der Testbench verbunden
  );
```

### **Warum nennt man das „direkte Instanziierung“?**
- Du sagst der Testbench direkt:
  - Welches **Design** (`half_adder`) sie verwenden soll.
  - Welche **Architektur** (`rtl`) des Designs benutzt werden soll.
  - Wie die **Signale der Testbench** mit den **Ports des Designs** verbunden werden.


---


- **Prozess**: Alle Anweisungen im Prozess werden ausgeführt, wenn ein Signal in der Sensitivitätsliste sich ändert.
- **Concurrent** Statements: Jede Anweisung arbeitet unabhängig.

---

### **Was sind Concurrent Statements in VHDL?**
- **Concurrent** bedeutet: **gleichzeitig**.  
  In VHDL werden alle Anweisungen, die zwischen `begin` und `end architecture` stehen, **parallel** ausgeführt.
- Das ist ein großer Unterschied zu normalen Programmiersprachen wie Python oder C, wo der Code **nacheinander (sequentiell)** ausgeführt wird.

---

### **Wie funktionieren Concurrent Statements?**
1. **Parallelität**:  
   Alle Anweisungen in der Architektur laufen **gleichzeitig**, als ob jedes Statement seine eigene Hardware wäre.  
   
2. **Ereignisgesteuert**:  
   Eine Anweisung wird **nur dann ausgeführt**, wenn sich eines der Eingangssignale **ändert**.  
   Beispiel:
   ```vhdl
   A <= B;  -- A wird nur neu berechnet, wenn sich B ändert.
   ```

---

**Die Reihenfolge im Code spielt keine Rolle**:
```vhdl
A <= B;
B <= C;
```
Das Ergebnis ist genau dasselbe wie im vorherigen Beispiel, weil die Anweisungen parallel und ereignisgesteuert sind.

---

### **Ein komplexeres Beispiel**
Stell dir vor, du hast eine Logik wie diese:
```vhdl
Z <= A and B;           -- Logisches UND zwischen A und B
Z <= C and D;           -- Problem: Mehrfachzuweisung an Z
```

**Problem**:
- Hier wird `Z` zweimal gleichzeitig beschrieben, was in echter Hardware nicht erlaubt ist.

**Lösung: Bedingte Zuweisung**:
```vhdl
Z <= (A and B) when ena = '1' else (C and D);
```
- `Z` bekommt entweder `(A and B)` oder `(C and D)`, abhängig davon, ob `ena = '1'` ist.

---

### **Wichtig zu verstehen: Concurrent Statements ≠ Reihenfolge**
- Concurrent Statements sind wie **verschiedene Drähte**, die **gleichzeitig** arbeiten.
- In der Realität beschreibt jede Anweisung ein eigenes Stück Hardware, das unabhängig von anderen arbeitet.

---
-------
Kein Problem, ich erkläre es einfacher und klarer:

---

### **Was bedeutet „Direkte Instanziierung“?**
- **Instanziierung** bedeutet, dass du dein Design (z. B. den Half-Adder) in der Testbench **verwendest**.  
- Bei der **direkten Instanziierung** sagst du der Testbench, dass sie ein bestimmtes Design benutzen soll, das du schon vorher erstellt hast.  
- Dabei werden die Eingänge und Ausgänge deines Designs mit den **Signalen** der Testbench **verbunden**.

---

all credits goes to Ketil Røed