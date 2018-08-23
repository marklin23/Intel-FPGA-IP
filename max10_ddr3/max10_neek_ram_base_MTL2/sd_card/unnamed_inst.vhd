	component unnamed is
		port (
			i_avalon_chip_select : in    std_logic                     := 'X';             -- chipselect
			i_avalon_address     : in    std_logic_vector(7 downto 0)  := (others => 'X'); -- address
			i_avalon_read        : in    std_logic                     := 'X';             -- read
			i_avalon_write       : in    std_logic                     := 'X';             -- write
			i_avalon_byteenable  : in    std_logic_vector(3 downto 0)  := (others => 'X'); -- byteenable
			i_avalon_writedata   : in    std_logic_vector(31 downto 0) := (others => 'X'); -- writedata
			o_avalon_readdata    : out   std_logic_vector(31 downto 0);                    -- readdata
			o_avalon_waitrequest : out   std_logic;                                        -- waitrequest
			i_clock              : in    std_logic                     := 'X';             -- clk
			i_reset_n            : in    std_logic                     := 'X';             -- reset_n
			b_SD_cmd             : inout std_logic                     := 'X';             -- b_SD_cmd
			b_SD_dat             : inout std_logic                     := 'X';             -- b_SD_dat
			b_SD_dat3            : inout std_logic                     := 'X';             -- b_SD_dat3
			o_SD_clock           : out   std_logic                                         -- o_SD_clock
		);
	end component unnamed;

	u0 : component unnamed
		port map (
			i_avalon_chip_select => CONNECTED_TO_i_avalon_chip_select, -- avalon_sdcard_slave.chipselect
			i_avalon_address     => CONNECTED_TO_i_avalon_address,     --                    .address
			i_avalon_read        => CONNECTED_TO_i_avalon_read,        --                    .read
			i_avalon_write       => CONNECTED_TO_i_avalon_write,       --                    .write
			i_avalon_byteenable  => CONNECTED_TO_i_avalon_byteenable,  --                    .byteenable
			i_avalon_writedata   => CONNECTED_TO_i_avalon_writedata,   --                    .writedata
			o_avalon_readdata    => CONNECTED_TO_o_avalon_readdata,    --                    .readdata
			o_avalon_waitrequest => CONNECTED_TO_o_avalon_waitrequest, --                    .waitrequest
			i_clock              => CONNECTED_TO_i_clock,              --                 clk.clk
			i_reset_n            => CONNECTED_TO_i_reset_n,            --               reset.reset_n
			b_SD_cmd             => CONNECTED_TO_b_SD_cmd,             --         conduit_end.b_SD_cmd
			b_SD_dat             => CONNECTED_TO_b_SD_dat,             --                    .b_SD_dat
			b_SD_dat3            => CONNECTED_TO_b_SD_dat3,            --                    .b_SD_dat3
			o_SD_clock           => CONNECTED_TO_o_SD_clock            --                    .o_SD_clock
		);

