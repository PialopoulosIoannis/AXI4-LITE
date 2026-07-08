library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity AXI4_LITE_RAM is 
PORT ( ACLK, ARESETN : in STD_LOGIC;  -- clock and reset
       ARADDR, ARCACHE, ARPROT, ARVALID : in STD_LOGIC; -- Line 6, 7 Read Address Channel
       ARREADY : out STD_LOGIC;
       RDATA, RRESP, RVALID, RREADY : out STD_LOGIC; -- Line 8, 9 Read Data Channel
       RREADY : in STD_LOGIC;
       AWADDR, AWCACHE, AWPROT, AWVALID : in STD_LOGIC; -- Line 10, 11 are Write Address Channel
       AWREADY : out STD_LOGIC; 
       WDATA, WSTRB : in STD_LOGIC; -- Write Data Channel
       BRESP, BVALID : out STD_LOGIC; -- Line 13, 14 Write Response Channel
       BREADY : in STD_LOGIC;


)
