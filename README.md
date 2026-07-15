# AXI4-LITE

## VHDL Code for AXI4-LITE Interface
The VHDL code for the AXI4-LITE interface is located in the **AXI4_LITE.vhdl** file.

The base AXI4-LITE implementation was sourced from [Real Digital](https://www.realdigital.org/doc/a9fee931f7a172423e1ba73f66ca4081). However, since more details were required, the official AMBA specification was also used as a reference. You can find this specification in this repository under the filename: **IHI0022E_amba_axi_and_ace_protocol_spec.pdf**. 

To verify the correctness of the VHDL code, I used Vivado to create a block design. This design consists of my AXI4_LITE RAM (configured as the slave) and an AXI Traffic Generator (ATG) acting as the master. The clock was automated by Vivado. The block design is shown below:

<img width="981" height="305" alt="image" src="https://github.com/user-attachments/assets/9c9b08fb-6664-4d6c-90d1-e3b19e793413" />

The configuration of the ATG is critical to the setup and is briefly explained below.

### Configuration of the ATG
* **Profile Selection:** Custom
* **Protocol:** AXI4-LITE
* **Mode:** System Test

The COE files used for this simulation are uploaded in this repository. 

#### Important Notes Regarding the COE Files:
1. **Address COE File:** The last address in this file must be `FFFFFFFF`, which acts as a NOP (No Operation) address. As AMD states: 
   > "The core stops generating further transactions (including the current NOP address of 0xFFFFFFFF) after the NOP address is present. You need to ensure at least one NOP address is present in the address COE file."
2. **File Alignment:** Every COE file must have the exact same number of lines, as each line across the files maps directly to the others. Because we append `FFFFFFFF` to the address file, you must also add an extra placeholder data line in the data file (the actual value of this line does not matter).
3. **Mask COE File:** * A mask bit value of `1` indicates that the corresponding bit is used to compare incoming read data with expected data.
   * A mask bit value of `0` indicates that the corresponding bit is ignored during comparison.
   * *Note: I filled this file entirely with `0`s because I did not need Vivado to perform data comparison.*
4. **Control COE File:** This file indicates whether you want to perform write or read transactions, along with comparison configurations. These details are explained in the AMD [AXI Traffic Generator Product Guide](https://docs.amd.com/r/en-US/pg125-axi-traffic-gen/Operation) under the "Operation" section.
5. **Memory Validation:** Ultimately, your memory should contain exactly what is written in your data COE file.

> **Note:** Make sure you match the addresses written in your VHDL file to the Vivado Address Editor window.

---

### Simulation Results

#### 1. Read-Only Simulation
If you perform the behavioral simulation using only the **read** COE files, it should look like this: 
<img width="1538" height="698" alt="image" src="https://github.com/user-attachments/assets/d550fdcc-6444-41c4-b1c2-1f52af63b332" />

#### 2. Read and Write Simulation
If you perform the behavioral simulation using both the **read and write** COE files, it should look like this: 
<img width="1450" height="601" alt="image" src="https://github.com/user-attachments/assets/7216946d-d547-4347-956b-ee46a15131e2" />
<img width="1452" height="650" alt="image" src="https://github.com/user-attachments/assets/d9d03b48-4ae8-42d4-90f5-67f112dbg227" />

---

### Project Structure & Synthesis Note
* **COE Folders:** There are 2 folders containing COE files:
  * **Folder 1:** Contains COE files configured solely to test read transactions.
  * **Folder 2:** Contains COE files configured to cycle through read and write operations (specifically instructing the ATG to perform: read, write, read, write...).
* **Synthesis:** Please note that this block design is **not synthesizable** and is intended for simulation purposes only.

When we read, we should see as a result what we initialized in the code and when we write we should see the data file's content for each address respectively.
