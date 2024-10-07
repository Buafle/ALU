
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity ALU is
  port (  A : in std_logic_vector(7 downto 0);
          B : in std_logic_vector(7 downto 0);
            ALU_Sel: in std_logic_vector(7 downto 0);
            NZVC: out std_logic_vector(3 downto 0);
          ALU_Result: out std_logic_vector(7 downto 0)
       
  );
end ALU;

architecture Behavioral of ALU is

begin


ALU_PROCESS : process (A, B, ALU_Sel)
variable Ope: std_logic_vector(8 downto 0);
begin

if (ALU_Sel="00000011") then 
    Ope :=('0'&A)+('0'&B);
    --ALU_Result <= (Sum(7 downto 0));
    --- Negative Flag (N) -------------------------------
    NZVC(3) <= Ope(7);
    --- Zero Flag (Z) ----------------------------------
        if (std_logic_vector(Ope(7 downto 0)) = "00000000") then
        NZVC(2) <= '1';
        else
        NZVC(2) <= '0';
        end if;
    --- Overflow Flag (V) -------------------------------
        if ((A(7)='0' and B(7)='0' and Ope(7)='1') or (A(7)='1' and B(7)='1' and Ope(7)='0')) then
        NZVC(1) <= '1';
        else
        NZVC(1) <= '0';
        end if;
    --- Carry Flag (C) ------------------------------------
    NZVC(0) <= Ope(8);
else

    if (ALU_Sel="00000101") then 
    Ope := '0'&(A and B);
    --- Negative Flag (N) -------------------------------
        NZVC(3) <= Ope(7);
    --- Zero Flag (Z) ----------------------------------
        if (Ope(7 downto 0) = "00000000") then
        NZVC(2) <= '1';
        else
        NZVC(2) <= '0';
        end if;
    end if;
end if;
ALU_Result <= std_logic_vector(Ope(7 downto 0));
end process ALU_PROCESS;

end Behavioral;
