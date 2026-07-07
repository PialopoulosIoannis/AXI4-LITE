library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity AXI4_LITE_RAM is 
PORT ( ACLK, ARESETN : in STD_LOGIC;  -- clock and reset
       ARADDR, ARCACHE, ARPROT, ARVALID, ARREADY : in STD_LOGIC; -- Read Address Channel
       RDATA, RRESP, RVALID, RREADY : out STD_LOGIC; -- Read Data Channel
       AWADDR, AWCACHE, AWPROT, AWVALID : in STD_LOGIC; -- Line 8,9 are Write Address Channel
       AWREADY : out STD_LOGIC;
       


)