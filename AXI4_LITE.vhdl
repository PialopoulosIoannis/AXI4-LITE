library ieee;
use ieee.std_logic_1164.all;

entity axi4_lite_ram is 
port ( aclk, aresetn : in std_logic;  -- clock and reset
       s_axilt_arcache, s_axilt_arvalid : in std_logic; -- Read Address Channel
       s_axilt_arprot: in std_logic_vector(2 downto 0);
       s_axilt_araddr : in std_logic_vector(31 downto 0);
       s_axilt_arready : out std_logic;
       s_axilt_rvalid : out std_logic; --Read Data Channel
       s_axilt_rdata : out std_logic_vector(31 downto 0); 
       s_axilt_rresp : out std_logic_vector(1 downto 0);
       s_axilt_rready : in std_logic;
       s_axilt_awcache, s_axilt_awvalid : in std_logic; -- Write Address Channel
       s_axilt_awprot: in std_logic_vector(2 downto 0);
       s_axilt_awaddr : in std_logic_vector(31 downto 0);
       s_axilt_awready : out std_logic; 
       s_axilt_wstrb : in std_logic; -- Write Data Channel
       s_axilt_wdata : in std_logic_vector(31 downto 0);
       s_axilt_bvalid : out std_logic; -- Write Response Channel
       s_axilt_bresp: out std_logic_vector(1 downto 0);
       s_axilt_bready : in std_logic
);
end axi4_lite_ram;

architecture behavioral_arch_1_with_320bits of axi4_lite_ram is 
  -- Memory registers (10 registers of 32 bits each = 320 bits)
  signal register00 : std_logic_vector(31 downto 0) := (others => '0');       
  signal register01 : std_logic_vector(31 downto 0) := (others => '0'); 
  signal register02 : std_logic_vector(31 downto 0) := (others => '0'); 
  signal register03 : std_logic_vector(31 downto 0) := (others => '0'); 
  signal register04 : std_logic_vector(31 downto 0) := (others => '0'); 
  signal register05 : std_logic_vector(31 downto 0) := (others => '0'); 
  signal register06 : std_logic_vector(31 downto 0) := (others => '0'); 
  signal register07 : std_logic_vector(31 downto 0) := (others => '0'); 
  signal register08 : std_logic_vector(31 downto 0) := (others => '0'); 
  signal register09 : std_logic_vector(31 downto 0) := (others => '0'); 

  signal internal_arready : std_logic := '0'; -- Internal signal to track arready state
  signal internal_rvalid  : std_logic := '0'; -- Internal signal to track rvalid state
begin 

  process(aresetn, aclk)
  begin
    if aresetn = '0' then
      if rising_edge(aclk) then 
        internal_rvalid  <= '0'; 
        s_axilt_bvalid   <= '0'; 
        internal_arready <= '1'; 
        s_axilt_awready  <= '1'; 
        s_axilt_rdata    <= (others => '1'); 
        s_axilt_rresp    <= (others => '1');     
        s_axilt_bresp    <= (others => '1'); 
      end if;      
    elsif rising_edge(aclk) then
      if s_axilt_arvalid = '1' and s_axilt_rready = '1' then
        internal_arready <= '1';
      end if; 
      
      if internal_arready = '1' and s_axilt_arvalid = '1' then
        case s_axilt_araddr(5 downto 2) is
          when "0000" => s_axilt_rdata <= register00;
          when "0001" => s_axilt_rdata <= register01;
          when "0010" => s_axilt_rdata <= register02;
          when "0011" => s_axilt_rdata <= register03;
          when "0100" => s_axilt_rdata <= register04;
          when "0101" => s_axilt_rdata <= register05;
          when "0110" => s_axilt_rdata <= register06;
          when "0111" => s_axilt_rdata <= register07;
          when "1000" => s_axilt_rdata <= register08;
          when "1001" => s_axilt_rdata <= register09;
          when others => s_axilt_rdata <= (others => '0');
        end case;
        internal_arready <= '0'; 
        internal_rvalid  <= '1'; 
        s_axilt_rresp    <= "00"; 
      end if;       
      
      if s_axilt_rready = '1' and internal_rvalid = '1' then
        internal_rvalid <= '0'; 
      end if;
    end if;
  end process;

  s_axilt_arready <= internal_arready; 
  s_axilt_rvalid  <= internal_rvalid; 

end behavioral_arch_1_with_320bits;