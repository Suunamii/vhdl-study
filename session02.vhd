/*

General design flow steps
-------------------------

• Design entry:
                    register transfer level [rtl]

• Synthesis:
                    - checks code syntax.
                    - converts abstract form of desired circuit behavior 
                      into a design implementation of basic gate level (netlist).
                    - Netlist = a text-based representation of logic diagram.

• Translate: 
                    merges netlist and constrains  (eg. physical port assignmets,timing,...)
                    into device specific design file

• Map:
                    fits design into specific device resources (LUT, FF, RAM, ...)

• Place and route:
                    decides where in the die the resources will be placed and wires them
                    together (accounts for timing constrains).

• Generate 
  configuration 
  bit file :
                    donwloaded to the FPGA


General simulation steps:
-------------------------

• Behavioral 
  simulation:
                    Simulation to verify RTL behavioral code 
                    (no timing and resource information).

• Gate level 
  functional 
  simulation:
                    - Run simulation on gate level description generated 
                      by the synthesizer.
                    - Can discover improper coding that works at RTL 
                      level but which violates synthesis coding conventions.

• Gate level 
  timing 
  simulation: 
                    Gate level simulation including propagation delays.


Static Timing Analysis:
-------------------------

• Gate level timing simulation of an entire design
  can be slow and is not recommended by Altera
  for new chips

• In fact, not supported for Cylcone/Arria/Stratix V devices.

• Instead, 
  use Static 
  Timing Analysis 
  (STA):
                    - method of computing the expected timing of a
                      digital circuit without requiring simulation
                    - Considers timing of paths from e.g. register to
                      register, input port to register, register to output
                      port, purely combinational paths.
                    - No need for test vectors
                    - However, does not check functionality of design.
                      => combine STA with behavioral simulation (RTL)..


*/