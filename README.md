# AXI4-LITE
## VHDL code for AXI4-LITE interface
The VHDL code for AXI4-LITE interface (up until now only the read transcraption have been executed) are in the **AXI4_LITE.vhdl** file
AXI4-LITE implementation was found in the website: **https://www.realdigital.org/doc/a9fee931f7a172423e1ba73f66ca4081** but more details where needed and where found in the pdf file uploaded in the same repo under the title **...**. 
To test if the VHDL code was correct I used Vivado. I created a block design with my AXI4_LITE ram which was the slave and a ATG (AXI Trafic Generator). Clock was automated by Vivado. An image is shown below:
<img width="981" height="305" alt="image" src="https://github.com/user-attachments/assets/9c9b08fb-6664-4d6c-90d1-e3b19e793413" />

Configuration of the ATF is really important and is explained briefly below

### Configuration of ATF
Profile Selection : Custom
Protocol : AXI4-LITE
Mode: System Test
My coe files are uploaded in this repo. 
Some note about them:
1. In the address file we add as last address : FFFFFFFF which is a NOP address. As AMD states : **The core stops generating further transactions (including the current NOP address of 0xFFFFFFFF) after the NOP address is present. You need to ensure at least one NOP address is present in the address COE file**
2. **Lines should match exactly for every file** so you add another line of data which we dont care about in the data file.
3. In the mask file : Mask bit value of 1 indicates the corresponding bit is used for comparing incoming read data with expected data.
                      Mask bit value of 0 indicates the corresponding bit is not used for comparing incoming read data with expected data.
   I filled this file with 0 because I did not care about Vivado doing the comparation
4. Control file is the where you idicate whether you want write or read transactions, comparation details... All these and the above are explained in the AMD file :https://docs.amd.com/r/en-US/pg125-axi-traffic-gen/Operation ( the section where the control file is explained is called "Operation" )

If you perform the behavioural simulation, it should look like this: 
<img width="1538" height="698" alt="image" src="https://github.com/user-attachments/assets/d550fdcc-6444-41c4-b1c2-1f52af63b332" />

**Make sure yoy match the addresses that are written in the VHDL file to Vivado address window**








