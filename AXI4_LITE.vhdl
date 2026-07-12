library ieee;
use ieee.std_logic_1164.all;

entity axi4_lite_ram is
    generic (
        DATA_WIDTH : INTEGER := 32;
        ADDR_WIDTH : INTEGER := 10
    );
    port (
        aclk            : in    STD_LOGIC;
        areset_n        : in    STD_LOGIC;
        
        s_axilt_awaddr  : in    STD_LOGIC_VECTOR(ADDR_WIDTH-1 downto 0);
        s_axilt_awvalid : in    STD_LOGIC;
        s_axilt_awready : out   STD_LOGIC;

        s_axilt_wdata   : in    STD_LOGIC_VECTOR(DATA_WIDTH-1 downto 0);
        s_axilt_wstrb   : in    STD_LOGIC_VECTOR((DATA_WIDTH/8)-1 downto 0);
        s_axilt_wvalid  : in    STD_LOGIC;
        s_axilt_wready  : out   STD_LOGIC;

        s_axilt_bresp   : out   STD_LOGIC_VECTOR(1 downto 0);
        s_axilt_bvalid  : out   STD_LOGIC;
        s_axilt_bready  : in    STD_LOGIC;

        s_axilt_araddr  : in    STD_LOGIC_VECTOR(ADDR_WIDTH-1 downto 0);
        s_axilt_arvalid : in    STD_LOGIC;
        s_axilt_arready : out   STD_LOGIC;

        s_axilt_rdata   : out   STD_LOGIC_VECTOR(DATA_WIDTH-1 downto 0);
        s_axilt_rresp   : out   STD_LOGIC_VECTOR(1 downto 0);
        s_axilt_rvalid  : out   STD_LOGIC;
        s_axilt_rready  : in    STD_LOGIC;

        irq_trig        : out   STD_LOGIC
    );
end axi4_lite_ram;

architecture behavioral_arch_1_with_320bits of axi4_lite_ram is 
  -- Memory registers (10 registers of 32 bits each = 320 bits)
  signal register00 : std_logic_vector(31 downto 0) := x"DEAD1111"; 
  signal register01 : std_logic_vector(31 downto 0) := x"DEAD2222"; 
  signal register02 : std_logic_vector(31 downto 0) := x"DEAD3333";  
  signal register03 : std_logic_vector(31 downto 0) := x"DEAD4444"; 
  signal register04 : std_logic_vector(31 downto 0) := x"DEAD5555"; 
  signal register05 : std_logic_vector(31 downto 0) := x"DEAD6666"; 
  signal register06 : std_logic_vector(31 downto 0) := x"DEAD7777"; 
  signal register07 : std_logic_vector(31 downto 0) := x"DEAD8888"; 
  signal register08 : std_logic_vector(31 downto 0) := x"DEAD9999"; 
  signal register09 : std_logic_vector(31 downto 0) := x"DEADAAAA"; 

  signal internal_arready : std_logic := '0'; -- Internal signal to track arready state
  signal internal_rvalid  : std_logic := '0'; -- Internal signal to track rvalid state
begin 

  process(areset_n, aclk)
  begin
    if areset_n = '0' then 
        internal_rvalid  <= '0'; 
        s_axilt_bvalid   <= '0'; 
        internal_arready <= '1'; 
        s_axilt_awready  <= '1'; 
        s_axilt_rdata    <= (others => '1'); 
        s_axilt_rresp    <= (others => '1');     
        s_axilt_bresp    <= (others => '1');  
    end  if;

     if rising_edge(aclk) then
        if areset_n = '1' then
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
            internal_arready <= '1';
          end if;
      end if; 
  end process;

  s_axilt_arready <= internal_arready; 
  s_axilt_rvalid  <= internal_rvalid; 

end behavioral_arch_1_with_320bits;