Leanrn to describe digital circuits with VHDL and implement them in an FPGA.

# VHDL

# Computing realization
## Software programmed processors
## Application specific Integrated Circuits (ASIC)
## Reconfigurable computing

# Logic blocks
## LUT
LUTs are the basic building blocks of FPGA logic blocks. LUT stands for Look-Up Table. It is a memory unit that stores the output of a function for all possible inputs. The LUT is programmed to implement a specific function.

# Structured digital design
Architecture -> Implementation -> Simulation (TDD) -> Realization -> Evaluation

Simulatie kan andere resultaten geven dan de uiteindelijke realisatie.

# note
- Sensitivity list (select all signals that are used in the process) in the software
- Use the unresolved version (vhdl) (ULOGIC)

```vhdl
library ieee;
use ieee.std_logic_1164.all;

entity Example is
    port (A, B, C : in STD_LOGIC;
          Y : out STD_LOGIC);
end Example;

architecture behavioral of Example is
begin
    Y <= (not (A and B) or (B and not C));
end behavioral;
```

# From VHDL to FPGA
RTL: Register Transfer Level

# Modeling concepts in VHDL
## Behaviooral Model
## Structural Model


https://nandland.com/fpga-101/
https://fpgatutorial.com/vhdl/
