library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity axi4_lite_ram is
    generic(
        SIZE : integer := 1024;
        ADDR_WIDTH : integer := 10;
        COL_WIDTH : integer := 8;
        NB_COL : integer := 4
        DATA_WIDTH : integer := NB_COL * COL_WIDTH; -- from above
          );
    port (
        aclk            : in    STD_LOGIC;
        areset_n        : in    STD_LOGIC;
        
        s_axilt_awaddr  : in    STD_LOGIC_VECTOR(ADDR_WIDTH-1 downto 0);
        s_axilt_awvalid : in    STD_LOGIC;
        s_axilt_awready : out   STD_LOGIC;

        s_axilt_wdata   : in    STD_LOGIC_VECTOR(DATA_WIDTH-1 downto 0);
        s_axilt_wstrb   : in    STD_LOGIC_VECTOR((DATA_WIDTH/8)-1 downto 0); -- 4 bits we need
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
  



  signal internal_arready : std_logic := '0'; -- Internal signal to track arready state
  signal internal_rvalid  : std_logic := '0'; -- Internal signal to track rvalid state
  signal internal_awready : std_logic := '0'; -- Internal signal to track awready state
  signal internal_wready : std_logic := '0'; -- Internal signal to track wready state
  signal temp_waddr : STD_LOGIC_VECTOR(ADDR_WIDTH-1 downto 0);
  signal temp_wdata : STD_LOGIC_VECTOR(DATA_WIDTH-1 downto 0);
  signal internal_address_flag : std_logic := '0'; -- Internal signal to track address flag
  signal internal_data_flag : std_logic := '0'; -- Internal signal to track data flag
  signal internal_bvalid : std_logic := '0'; -- Internal signal to track bvalid state


begin 

process(aclk, areset_n) --Byte Write Enable—True Dual Port READ_FIRST Mode
begin

  if areset_n = '0' then --reset
          internal_wready  <= '1'; 
          internal_awready  <= '1';
          internal_address_flag <= '0';
          internal_data_flag <= '0';
          internal_bvalid <= '0';
          s_axilt_bresp    <= (others => '1');  

  end if;
          
   
    if rising_edge(aclk) then
        if areset_n = '1' then
            if s_axilt_awvalid = '1' and internal_awready = '1' then
              temp_waddr <= s_axilt_awaddr;
              internal_awready <= '0';
              internal_address_flag <= '1';
            end if;
              if s_axilt_wvalid = '1' and internal_wready = '1' then
                temp_wdata <= s_axilt_wdata;
                internal_wready <= '0';
                internal_data_flag <= '1';
              end if;
                
                  if internal_data_flag = '1' and internal_address_flag = '1' then 
                    case temp_waddr (5 downto 2) is
                        when "0000" =>  register00 <= temp_wdata;
                        when "0001" =>  register01 <= temp_wdata;
                        when "0010" =>  register02 <= temp_wdata;
                        when "0011" =>  register03 <= temp_wdata;
                        when "0100" =>  register04 <= temp_wdata;
                        when "0101" =>  register05 <= temp_wdata;
                        when "0110" =>  register06 <= temp_wdata;
                        when "0111" =>  register07 <= temp_wdata;
                        when "1000" =>  register08 <= temp_wdata;
                        when "1001" =>  register09 <= temp_wdata;
                        when others =>  register00 <= (others => '0');
                     end case;                    
                   internal_address_flag <= '0';
                   internal_data_flag <= '0';
                   internal_bvalid <= '1';
                   s_axilt_bresp <= "00"; --OK response
                  end if;
                
              if s_axilt_bready = '1' and internal_bvalid = '1'  then
                internal_bvalid <= '0';
                internal_awready <= '1';
                internal_wready <= '1'; 
              end if;
          end if;
    end if;

                      
            
  end process;  



  s_axilt_arready <= internal_arready; 
  s_axilt_rvalid  <= internal_rvalid; 
  s_axilt_awready <= internal_awready;
  s_axilt_wready <= internal_wready;
  s_axilt_bvalid <= internal_bvalid;


end behavioral_arch_1_with_320bits;