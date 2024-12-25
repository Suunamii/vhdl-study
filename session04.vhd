/*

Operators
---------

Arithmetic operations cannot be used directly on objects of the type std_logic. 
When doing arithmetic operations, 
it is instead recommended to declare the object using 
the type usigned , signed , or integer, 
for which these arithmetic operators are defined when using the library:

*/

ieee.numeric_std.all;



/*

Logic Operators
---------------

*/

ieee.std_logic_1164;

-- not, and, nand, or, nor, xor, xnor

Y <= A xor B and C;    -- -> ERROR 

Y <= A xor (B and C);  -- -> good 

--

not A and B;
-- <=> ------
(not A) and B;

--

signal test : std_logic;
-----------------------
if test = 1 then -- -> ERROR

/*

Warum gibt es einen Fehler im ersten Beispiel?

    Problem:
    Im ersten Beispiel wird das Signal test als std_logic deklariert.

      • std_logic ist ein spezieller Datentyp für logische Werte, 
          wie '0' oder '1', aber nicht für Zahlen wie 1.

      •  1 ist eine Zahl (vom Typ integer), und deshalb passt der Vergleich nicht.

Wie löst man das Problem?

Es gibt zwei richtige Möglichkeiten:

    Deklariere test als integer:
      • Wenn du mit Zahlen wie 1 arbeiten möchtest, 
           muss test ein Zahlen-Datentyp sein.

*/

signal test : integer;

if test = 1 then
    -- code...
end if; 


-- Operator priority:

1. **, abs, not
2. *, /, mod, rem
3. +, - (unary versions)
4. +, -, &
5. sll, srl, sla, sra, rol, ror
6. =, /=, <, <=, >, >=, ?=, ?/=, ?<, ?<=, ?>, ?>=
7. and, or, nand, nor, xor, xnor