

---

### **Was sind Concurrent Statements in VHDL?**
- **VHDL beschreibt Hardware**, nicht Software.  
- Während Code auf einem Prozessor **nacheinander** ausgeführt wird, wird VHDL in einem FPGA in **Hardware-Ressourcen** übersetzt.  
- Das bedeutet, dass mehrere Hardware-Elemente gleichzeitig arbeiten können (**parallel**).

---

### **Wie funktionieren Concurrent Statements?**
- In der **Architektur** eines VHDL-Designs sind alle Anweisungen **parallel**.  
- Jede Anweisung beschreibt ein **separates Hardware-Element**, wie ein Draht, ein Gatter oder eine Bedingung.

---

### **Beispiele für Concurrent Statements**

1. **Einfache Verbindung**:  
   ```vhdl
   A <= B;
   ```
   - Signal `B` wird direkt mit Signal `A` verbunden.  
   - Das kannst du dir wie einen einfachen Draht vorstellen.

2. **Logikoperation**:  
   ```vhdl
   A <= B and C;
   ```
   - Hier wird ein **AND-Gatter** erzeugt, das die Signale `B` und `C` verarbeitet und das Ergebnis an `A` weiterleitet.

3. **Bedingte Zuweisung (Multiplexer)**:  
   ```vhdl
   Y <= B when S = '1' else C;
   ```
   - Das erzeugt einen **Multiplexer**, der `B` an `Y` weiterleitet, wenn `S` = `1` ist, sonst `C`.

---

### **Wichtig: Reihenfolge der Anweisungen ist egal**
Da alle Concurrent Statements **parallel arbeiten**, spielt die Reihenfolge keine Rolle.  
- Diese beiden Code-Blöcke sind **gleichwertig**:

   **Block 1**:
   ```vhdl
   B <= C;
   A <= B;
   ```

   **Block 2**:
   ```vhdl
   A <= B;
   B <= C;
   ```

- In beiden Fällen wird dieselbe Hardware erzeugt.

---

### **Zusammenfassung**
- **Concurrent Statements** in VHDL beschreiben Hardware, die **gleichzeitig** arbeitet.  
- Beispiele:
  - **Draht**: `A <= B;`  
  - **Gatter**: `A <= B and C;`  
  - **Multiplexer**: `Y <= B when S = '1' else C;`  
- Die Reihenfolge der Anweisungen ist irrelevant, da sie parallel umgesetzt werden.  

