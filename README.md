# ECE4300_Final_Pipeline

# Final Pipeline Code - MIPS Processor

## Project Overview
This repository contains the final implementation of the MIPS pipeline, comprising five interconnected stages that efficiently execute MIPS instructions. The pipeline follows a structured approach, allowing instructions to be processed in a parallel and efficient manner.

### Pipeline Structure
The MIPS pipeline is divided into the following five stages:
1. **Fetch (IF) Stage** - Retrieves the next instruction from memory.
2. **Decode (ID) Stage** - Decodes the instruction and reads the necessary registers.
3. **Execute (EX) Stage** - Performs arithmetic, logic, and branch operations.
4. **Memory (MEM) Stage** - Accesses data memory for load/store instructions.
5. **Writeback (WB) Stage** - Writes the result back to the register file.

### Complete Pipeline Connection
The `complete_pipeline` module brings all these stages together, controlling the data flow between them. Data moves seamlessly from one stage to the next through pipeline registers (latches), which include:
- **IF/ID Latch** - Connects Fetch to Decode.
- **ID/EX Latch** - Connects Decode to Execute.
- **EX/MEM Latch** - Connects Execute to Memory.
- **MEM/WB Latch** - Connects Memory to Writeback.

### Control Flow and Data Flow
- **Control Signals:** The control signals generated in the Decode stage guide the ALU operations, memory access, and writeback operations throughout the pipeline.
- **Data Transformation:** Data from each stage is processed and passed through latches, maintaining pipeline integrity and preventing hazards.

---

## Repository Structure
The repository is organized into five folders, each representing a stage in the pipeline. 
- **Fetch/** - Contains modules related to instruction fetching, such as `program_counter` and `adder`.
- **Decode/** - Includes the control unit, register file, and sign extension unit.
- **Execute/** - Implements ALU operations, MUX selections, and control logic.
- **Memory/** - Handles data read and write operations to the data memory.
- **Writeback/** - Writes the processed data back into the register file.

### Submodule Organization
Inside each stage folder, you will find:
- **Main Stage Module:** Represents the primary operations of that stage.
- **Submodules:** Includes functional components such as `adder`, `mux`, `alu`, etc.
- **Latches:** Ensures the flow of data between stages.

---

## How to Navigate
1. Open the `Final_Pipeline_Code` repository.
2. Choose a folder representing a pipeline stage (e.g., `Fetch/`).
3. Inside each folder, you will find the specific Verilog modules and their instantiations for that stage.
4. The complete pipeline code is in the root directory, where the integration of all stages occurs.

### Conclusion
This project demonstrates a successful implementation of the MIPS pipeline, with well-defined stage connections and efficient data handling. Each stage is organized into separate folders to maintain modularity and ease of navigation. Explore each folder to understand the instantiation and functionality of individual components.
