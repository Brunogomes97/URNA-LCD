library verilog;
use verilog.vl_types.all;
entity digitos is
    port(
        key1            : in     vl_logic;
        key2            : in     vl_logic;
        hex1            : out    vl_logic_vector(6 downto 0);
        hex2            : out    vl_logic_vector(6 downto 0);
        rst             : in     vl_logic;
        bcd1            : out    vl_logic_vector(3 downto 0);
        bcd2            : out    vl_logic_vector(3 downto 0);
        teste           : out    vl_logic;
        d3              : out    vl_logic_vector(3 downto 0)
    );
end digitos;
