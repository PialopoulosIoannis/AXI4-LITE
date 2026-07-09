library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity AXI4_LITE_RAM is 
PORT ( ACLK, ARESETN : in STD_LOGIC;  -- clock and reset
       ARCACHE, ARVALID : in STD_LOGIC; -- Read Address Channel
       ARPROT: in std_logic_vector(2 downto 0);
       ARADDR : in std_logic_vector(31 downto 0);
       ARREADY : out STD_LOGIC;
       RVALID : out STD_LOGIC; --Read Data Channel
       RDATA : out std_logic_vector(31 downto 0); 
       RRESP : out std_logic_vector(1 downto 0);
       RREADY : in STD_LOGIC;
       AWCACHE, AWVALID : in STD_LOGIC; -- Write Address Channel
       AWPROT: in std_logic_vector(2 downto 0);
       AWADDR : in std_logic_vector(31 downto 0);
       AWREADY : out STD_LOGIC; 
       WSTRB : in STD_LOGIC; -- Write Data Channel
       WDATA : in std_logic_vector(31 downto 0);
       BVALID : out STD_LOGIC; -- Write Response Channel
       BRESP: out std_logic_vector(1 downto 0);
       BREADY : in STD_LOGIC
)

end AXI4_LITE_RAM;

architecture Behavioral_arch_1_with_320bits of AXI4_LITE_RAM is --POIOS KATHORIZEI POSI MNHMH THA EXO. PROFANOS DEN MPORO NA BALO APERIORISTI. 
-- RIGHT NOW I HAVE 320 BITS SO 320/8=40 BYTES OF MEMORY. BECAUSE EACH DATA IS 32 BITS = 4 BYTES. SO I CAN DEFINE 10 REGISTERS OF 32 BITS EACH. 
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
                            BRESP <= (others => '1'); --Can be anything (2bits) 
                   end if;  
              elsif rising_edge(ACLK) then
                     if ARVALID = '1' and RREADY = '1' then
                            ARREADY <= '1';
                     if ARREADY = '1' and ARVALID = '1' then
                            case ARADDR(5 downto 2) is
                                   when "0000" => RDATA <= register00;
                                   when "0001" => RDATA <= register01;
                                   when "0010" => RDATA <= register02;
                                   when "0011" => RDATA <= register03;
                                   when "0100" => RDATA <= register04;
                                   when "0101" => RDATA <= register05;
                                   when "0110" => RDATA <= register06;
                                   when "0111" => RDATA <= register07;
                                   when "1000" => RDATA <= register08;
                                   when "1001" => RDATA <= register09;
                                   when others => RDATA <= (others => '0');
                            end case;
                            ARREADY <= '0'; -- We deassert ARREADY and ARVALID because the read address handshake is complete. 
                            ARVALID <= '0';
                            RVALID <= '1'; -- We assert RVALID because the read data is now available.
                            RRESP <= "00"; -- We set RRESP to "00" to indicate a successful read operation, OKEY status
                            end if;       
                     end if;
                     if RREADY = '1' and RVALID = '1' then
                            RVALID <= '0'; -- We deassert RVALID because the read data handshake is complete.
                            RREADY <= '0'; -- We deassert RREADY because the read data handshake is complete.
                     end if;
                     end process;
                     end Behavioral_arch_1_with_320bits; 
                     

