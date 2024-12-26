What is VHDL ? (my notes)
---

- Ein FPGA besteht aus **LUTs** und **Registern**, die für kombinatorische und sequenzielle Logik verwendet werden.  
- Die **Synthese** wandelt eine VHDL-Beschreibung in diese Hardware-Ressourcen um.  
- **RTL** beschreibt den Datenfluss zwischen Registern und wird benötigt, um ein Design in Hardware umzusetzen.

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
