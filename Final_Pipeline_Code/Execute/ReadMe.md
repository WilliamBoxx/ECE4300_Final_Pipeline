
# 3-Execute (EX) Stage

## Overview
The Execute stage (EX) is the third stage of the MIPS pipeline. It performs arithmetic, logical, and branch operations based on the control signals from the decode stage.

### Purpose:
- Perform arithmetic and logic operations.
- Calculate branch target addresses.
- Select the correct destination register for writing results.

### Components:
- **ALU:** Performs arithmetic and logic operations.
- **ALU Control Unit:** Generates control signals based on the opcode and function code.
- **MUX (ALUSrc):** Chooses between a register value or an immediate value for the ALU input.
- **Adder:** Computes the branch target address.
- **MUX (RegDst):** Selects the destination register.
- **EX/MEM Latch:** Passes results and control signals to the MEM stage.

### Connections:
- The ALU control unit interprets the opcode and function code.
- The ALU performs the required operation on the input data.
- The result is passed to the EX/MEM latch for the memory stage.

---

## Code Description
The `execute` module implements the ALU operations, including addition, subtraction, and logical functions.

- **ALU Control Signal Generation:** Decodes ALU operation based on the opcode and funct.
- **Arithmetic and Logic Operations:** Uses the ALU to perform computations.
- **Branch Calculation:** Computes the target address for branches.

---

## Functionality
On each clock cycle, the ALU computes the result using the given inputs. The branch calculation is performed simultaneously, and the result is passed to the next pipeline stage.

---

## Testing and Verification
- Tested with arithmetic (ADD, SUB) and logical (AND, OR) instructions.
- Verified correct branch address calculation.
- Ensured correct data forwarding and hazard management.

---

## Common Issues and Fixes
- **ALU Result Incorrect:** Fixed ALU control signal mapping.
- **Branch Misalignment:** Corrected branch address calculation in the adder.
- **MUX Selection Errors:** Validated input selection between register and immediate values.

