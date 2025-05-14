
# Decode (ID) Stage

## Overview
The Decode stage (ID) is the second stage of the MIPS pipeline. Its main purpose is to decode the fetched instruction, read the required register values, and generate the necessary control signals.

### Purpose:
- Decode the fetched instruction.
- Read register values from the register file.
- Generate control signals for subsequent pipeline stages.

### Components:
- **Control Unit:** Decodes the opcode to generate control signals.
- **Register File:** Reads the source and destination registers.
- **Sign Extension Unit:** Extends the 16-bit immediate to 32 bits.
- **ID/EX Latch:** Stores the decoded instruction and control signals for the Execute stage.

### Connections:
- The fetched instruction is input to the control unit to generate signals.
- The register file reads values from the specified registers.
- The sign extension unit prepares the immediate value for arithmetic operations.

---

## Code Description
The `decode` module handles instruction decoding and prepares control signals for the execute stage.

- **Instruction Decoding:** Uses the opcode to generate control signals.
- **Register Reading:** Uses the register file to obtain operand values.
- **Sign Extension:** Extends the immediate field to 32 bits for arithmetic operations.

---

## Functionality
Upon receiving an instruction, the control unit decodes the opcode and generates signals. The register file outputs the values of the specified registers, and the sign extension unit processes the immediate values.

---

## Testing and Verification
- Tested with arithmetic and load/store instructions.
- Verified that control signals are correctly generated.
- Cross-checked register file outputs with expected values.

---

## Common Issues and Fixes
- **Control Signal Mismatch:** Adjusted opcode decoding logic.
- **Register Read Errors:** Fixed address bit-width mismatches in the register file.

