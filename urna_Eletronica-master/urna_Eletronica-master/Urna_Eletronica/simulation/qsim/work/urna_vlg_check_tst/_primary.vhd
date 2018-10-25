library verilog;
use verilog.vl_types.all;
entity urna_vlg_check_tst is
    port(
        HEX0            : in     vl_logic_vector(6 downto 0);
        LCD_BLON        : in     vl_logic;
        LCD_DATA        : in     vl_logic_vector(7 downto 0);
        LCD_EN          : in     vl_logic;
        LCD_ON          : in     vl_logic;
        LCD_RS          : in     vl_logic;
        LCD_RW          : in     vl_logic;
        apuracao        : in     vl_logic;
        confirma        : in     vl_logic;
        flag            : in     vl_logic;
        teste           : in     vl_logic_vector(2 downto 0);
        valor1          : in     vl_logic_vector(3 downto 0);
        valor2          : in     vl_logic_vector(3 downto 0);
        sampler_rx      : in     vl_logic
    );
end urna_vlg_check_tst;
