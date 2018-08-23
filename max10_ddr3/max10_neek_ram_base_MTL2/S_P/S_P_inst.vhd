	component S_P is
		port (
			source : out std_logic_vector(63 downto 0);                    -- source
			probe  : in  std_logic_vector(63 downto 0) := (others => 'X')  -- probe
		);
	end component S_P;

	u0 : component S_P
		port map (
			source => CONNECTED_TO_source, -- sources.source
			probe  => CONNECTED_TO_probe   --  probes.probe
		);

