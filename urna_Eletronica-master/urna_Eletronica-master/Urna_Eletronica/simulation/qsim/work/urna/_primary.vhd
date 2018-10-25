library verilog;
use verilog.vl_types.all;
entity urna is
    port(
        reset           : in     vl_logic;
        clock           : in     vl_logic;
        key0            : in     vl_logic;
        key1            : in     vl_logic;
        key2            : in     vl_logic;
        HEX0            : out    vl_logic_vector(6 downto 0);
        teste           : out    vl_logic_vector(2 downto 0);
        confirma        : out    vl_logic;
        finalizar       : in     vl_logic;
        apuracao        : out    vl_logic;
        corrigir        : in     vl_logic;
        valor1          : out    vl_logic_vector(3 downto 0);
        valor2          : out    vl_logic_vector(3 downto 0);
        flag            : out    vl_logic;
        LCD_ON          : out    vl_logic;
        LCD_BLON        : out    vl_logic;
        LCD_RW          : out    vl_logic;
        LCD_EN          : out    vl_logic;
        LCD_RS          : out    vl_logic;
        LCD_DATA        : inout  vl_logic_vector(7 downto 0)
    );
end urna;
