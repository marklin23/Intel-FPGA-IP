	component ddr is
		port (
			clk_clk                                         : in    std_logic                     := 'X';             -- clk
			mem_if_ddr3_emif_0_pll_sharing_pll_mem_clk      : out   std_logic;                                        -- pll_mem_clk
			mem_if_ddr3_emif_0_pll_sharing_pll_write_clk    : out   std_logic;                                        -- pll_write_clk
			mem_if_ddr3_emif_0_pll_sharing_pll_locked       : out   std_logic;                                        -- pll_locked
			mem_if_ddr3_emif_0_pll_sharing_pll_capture0_clk : out   std_logic;                                        -- pll_capture0_clk
			mem_if_ddr3_emif_0_pll_sharing_pll_capture1_clk : out   std_logic;                                        -- pll_capture1_clk
			mem_if_ddr3_emif_0_status_local_init_done       : out   std_logic;                                        -- local_init_done
			mem_if_ddr3_emif_0_status_local_cal_success     : out   std_logic;                                        -- local_cal_success
			mem_if_ddr3_emif_0_status_local_cal_fail        : out   std_logic;                                        -- local_cal_fail
			memory_mem_a                                    : out   std_logic_vector(12 downto 0);                    -- mem_a
			memory_mem_ba                                   : out   std_logic_vector(2 downto 0);                     -- mem_ba
			memory_mem_ck                                   : inout std_logic_vector(0 downto 0)  := (others => 'X'); -- mem_ck
			memory_mem_ck_n                                 : inout std_logic_vector(0 downto 0)  := (others => 'X'); -- mem_ck_n
			memory_mem_cke                                  : out   std_logic_vector(0 downto 0);                     -- mem_cke
			memory_mem_cs_n                                 : out   std_logic_vector(0 downto 0);                     -- mem_cs_n
			memory_mem_dm                                   : out   std_logic_vector(2 downto 0);                     -- mem_dm
			memory_mem_ras_n                                : out   std_logic_vector(0 downto 0);                     -- mem_ras_n
			memory_mem_cas_n                                : out   std_logic_vector(0 downto 0);                     -- mem_cas_n
			memory_mem_we_n                                 : out   std_logic_vector(0 downto 0);                     -- mem_we_n
			memory_mem_reset_n                              : out   std_logic;                                        -- mem_reset_n
			memory_mem_dq                                   : inout std_logic_vector(23 downto 0) := (others => 'X'); -- mem_dq
			memory_mem_dqs                                  : inout std_logic_vector(2 downto 0)  := (others => 'X'); -- mem_dqs
			memory_mem_dqs_n                                : inout std_logic_vector(2 downto 0)  := (others => 'X'); -- mem_dqs_n
			memory_mem_odt                                  : out   std_logic_vector(0 downto 0);                     -- mem_odt
			mm_bridge_0_s0_waitrequest                      : out   std_logic;                                        -- waitrequest
			mm_bridge_0_s0_readdata                         : out   std_logic_vector(31 downto 0);                    -- readdata
			mm_bridge_0_s0_readdatavalid                    : out   std_logic;                                        -- readdatavalid
			mm_bridge_0_s0_burstcount                       : in    std_logic_vector(0 downto 0)  := (others => 'X'); -- burstcount
			mm_bridge_0_s0_writedata                        : in    std_logic_vector(31 downto 0) := (others => 'X'); -- writedata
			mm_bridge_0_s0_address                          : in    std_logic_vector(29 downto 0) := (others => 'X'); -- address
			mm_bridge_0_s0_write                            : in    std_logic                     := 'X';             -- write
			mm_bridge_0_s0_read                             : in    std_logic                     := 'X';             -- read
			mm_bridge_0_s0_byteenable                       : in    std_logic_vector(3 downto 0)  := (others => 'X'); -- byteenable
			mm_bridge_0_s0_debugaccess                      : in    std_logic                     := 'X';             -- debugaccess
			pio_0_external_connection_export                : out   std_logic_vector(7 downto 0);                     -- export
			reset_reset_n                                   : in    std_logic                     := 'X'              -- reset_n
		);
	end component ddr;

	u0 : component ddr
		port map (
			clk_clk                                         => CONNECTED_TO_clk_clk,                                         --                            clk.clk
			mem_if_ddr3_emif_0_pll_sharing_pll_mem_clk      => CONNECTED_TO_mem_if_ddr3_emif_0_pll_sharing_pll_mem_clk,      -- mem_if_ddr3_emif_0_pll_sharing.pll_mem_clk
			mem_if_ddr3_emif_0_pll_sharing_pll_write_clk    => CONNECTED_TO_mem_if_ddr3_emif_0_pll_sharing_pll_write_clk,    --                               .pll_write_clk
			mem_if_ddr3_emif_0_pll_sharing_pll_locked       => CONNECTED_TO_mem_if_ddr3_emif_0_pll_sharing_pll_locked,       --                               .pll_locked
			mem_if_ddr3_emif_0_pll_sharing_pll_capture0_clk => CONNECTED_TO_mem_if_ddr3_emif_0_pll_sharing_pll_capture0_clk, --                               .pll_capture0_clk
			mem_if_ddr3_emif_0_pll_sharing_pll_capture1_clk => CONNECTED_TO_mem_if_ddr3_emif_0_pll_sharing_pll_capture1_clk, --                               .pll_capture1_clk
			mem_if_ddr3_emif_0_status_local_init_done       => CONNECTED_TO_mem_if_ddr3_emif_0_status_local_init_done,       --      mem_if_ddr3_emif_0_status.local_init_done
			mem_if_ddr3_emif_0_status_local_cal_success     => CONNECTED_TO_mem_if_ddr3_emif_0_status_local_cal_success,     --                               .local_cal_success
			mem_if_ddr3_emif_0_status_local_cal_fail        => CONNECTED_TO_mem_if_ddr3_emif_0_status_local_cal_fail,        --                               .local_cal_fail
			memory_mem_a                                    => CONNECTED_TO_memory_mem_a,                                    --                         memory.mem_a
			memory_mem_ba                                   => CONNECTED_TO_memory_mem_ba,                                   --                               .mem_ba
			memory_mem_ck                                   => CONNECTED_TO_memory_mem_ck,                                   --                               .mem_ck
			memory_mem_ck_n                                 => CONNECTED_TO_memory_mem_ck_n,                                 --                               .mem_ck_n
			memory_mem_cke                                  => CONNECTED_TO_memory_mem_cke,                                  --                               .mem_cke
			memory_mem_cs_n                                 => CONNECTED_TO_memory_mem_cs_n,                                 --                               .mem_cs_n
			memory_mem_dm                                   => CONNECTED_TO_memory_mem_dm,                                   --                               .mem_dm
			memory_mem_ras_n                                => CONNECTED_TO_memory_mem_ras_n,                                --                               .mem_ras_n
			memory_mem_cas_n                                => CONNECTED_TO_memory_mem_cas_n,                                --                               .mem_cas_n
			memory_mem_we_n                                 => CONNECTED_TO_memory_mem_we_n,                                 --                               .mem_we_n
			memory_mem_reset_n                              => CONNECTED_TO_memory_mem_reset_n,                              --                               .mem_reset_n
			memory_mem_dq                                   => CONNECTED_TO_memory_mem_dq,                                   --                               .mem_dq
			memory_mem_dqs                                  => CONNECTED_TO_memory_mem_dqs,                                  --                               .mem_dqs
			memory_mem_dqs_n                                => CONNECTED_TO_memory_mem_dqs_n,                                --                               .mem_dqs_n
			memory_mem_odt                                  => CONNECTED_TO_memory_mem_odt,                                  --                               .mem_odt
			mm_bridge_0_s0_waitrequest                      => CONNECTED_TO_mm_bridge_0_s0_waitrequest,                      --                 mm_bridge_0_s0.waitrequest
			mm_bridge_0_s0_readdata                         => CONNECTED_TO_mm_bridge_0_s0_readdata,                         --                               .readdata
			mm_bridge_0_s0_readdatavalid                    => CONNECTED_TO_mm_bridge_0_s0_readdatavalid,                    --                               .readdatavalid
			mm_bridge_0_s0_burstcount                       => CONNECTED_TO_mm_bridge_0_s0_burstcount,                       --                               .burstcount
			mm_bridge_0_s0_writedata                        => CONNECTED_TO_mm_bridge_0_s0_writedata,                        --                               .writedata
			mm_bridge_0_s0_address                          => CONNECTED_TO_mm_bridge_0_s0_address,                          --                               .address
			mm_bridge_0_s0_write                            => CONNECTED_TO_mm_bridge_0_s0_write,                            --                               .write
			mm_bridge_0_s0_read                             => CONNECTED_TO_mm_bridge_0_s0_read,                             --                               .read
			mm_bridge_0_s0_byteenable                       => CONNECTED_TO_mm_bridge_0_s0_byteenable,                       --                               .byteenable
			mm_bridge_0_s0_debugaccess                      => CONNECTED_TO_mm_bridge_0_s0_debugaccess,                      --                               .debugaccess
			pio_0_external_connection_export                => CONNECTED_TO_pio_0_external_connection_export,                --      pio_0_external_connection.export
			reset_reset_n                                   => CONNECTED_TO_reset_reset_n                                    --                          reset.reset_n
		);

