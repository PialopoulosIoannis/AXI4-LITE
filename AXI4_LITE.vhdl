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

end AXI4_LITE_RAM;

architecture Behavioral_arch_1_with_320bits of AXI4_LITE_RAM is --POIOS KATHORIZEI POSI MNHMH THA EXO. PROFANOS DEN MPORO NA BALO APERIORISTI. 
-- RIGHT NOW I HAVE 320 BITS SO 320/8=40 BYTES OF MEMORY. BECAUSE EACH DATA IS 32 BITS = 4 BYTES. SO I HAVE 10 REGISTERS OF 32 BITS EACH. 
  signal register00 : std_logic_vector(31 downto 0) := (others => '0'); -- 32 bits register       
  signal register01 : std_logic_vector(31 downto 0) := (others => '0'); -- 32 bits register
  signal register02 : std_logic_vector(31 downto 0) := (others => '0'); -- 32 bits register
  signal register03 : std_logic_vector(31 downto 0) := (others => '0'); -- 32 bits register
  signal register04 : std_logic_vector(31 downto 0) := (others => '0'); -- 32 bits register
  signal register05 : std_logic_vector(31 downto 0) := (others => '0'); -- 32 bits register
  signal register06 : std_logic_vector(31 downto 0) := (others => '0'); -- 32 bits register
  signal register07 : std_logic_vector(31 downto 0) := (others => '0'); -- 32 bits register
  signal register08 : std_logic_vector(31 downto 0) := (others => '0'); -- 32 bits register
  signal register09 : std_logic_vector(31 downto 0) := (others => '0'); -- 32 bits register

       process(ARESETN, ACLK)
       begin
              if ARESETN = '0' then
                   if   rising_edge(ACLK) then -- The reset signal can be asserted asynchronously, but deassertion must be synchronous with a rising
                            RVALID <= '0'; --MUST BE 0
                            BVALID <= '0'; --MUST BE 0
                            ARREADY <= '1'; --Can be anything
                            AWREADY <= '1'; --Can be anything
                            RDATA <= (others => '1'); --Can be anything (32bits)
                            RRESP <= (others => '1'); --Can be anything (2bits)    
                            RVALID <= '1'; --Can be anything
                            RREADY <= '1'; --Can be anything
                            BRESP <= (others => '1'); --Can be anything (2bits) 
                   end if;  
              elsif rising_edge(ACLK) then
                     if ARVALID = '1' and RREADY = '1' then
                            ARREADY <= '1';
                     if ARREADY = '1' and ARVALID = '1' then
                            --I can get the address inside ARADDR and put the data inside RDATA. HOW
                            

