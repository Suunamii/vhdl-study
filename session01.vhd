library IEEE;
IEEE.std_logic_1164.all;


/* ENTITY declaration should start with the keyword entity and end with keyword end. 
The identifier in an entity declaration names the module so that it can be referred to later.
A port clause is then used to list and name each of the entity’s ports,
which together form the interface of the entity. Items enclosed by < > are mandatory items,
while [ ] are optional.
*/

entity <identifier> is 
    port(
        -- list of input and output ports
        -- with declaration, and type:
        -- <identifier> : <mode> <type>
    );
end [entity] [identifier];

/*
modes  -- description
-----  -- -----------
IN     -- Flow into -> entity
OUT    -- Flow out -> entity -> NO FEEDBACK !
BUFFER -- Flow out -> entity -> With FEEDBACK !
INOUT  -- bi-directioal signals
*/

/* ARCHITECTURE describes what the circuit actually does 
–> its internal functionality.
architecture body generally operates on values from the input ports, 
generating values to be assigned to output ports. 
An architecture needs to be connected to an entity, 
this achieved with the <entity_identifier> in the first line of the architcture declaration. 
Items enclosed by < > are mandatory items, while [ ] are optional.
*/

architcture <identifier> of <entity_identifier> is
-- Declarative area
begin
-- Concurrent statement area
end [architcture] [identifier]

-- e.g. 

entity and_gate is
    port(
        A: in std_logic;
        B: in std_logic;
        C: out std_logic -- No semicolon -> last item ! 
    ); 
end entity and_gate;


architcture rtl of and_gate is

begin

Y <= A and B;

end architcture rtl;