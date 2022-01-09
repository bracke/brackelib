with AUnit.Reporter.Text;
with AUnit.Run;
with Container_Suite; use Container_Suite;

procedure Test_Brackelib is
   procedure Runner is new AUnit.Run.Test_Runner (Suite);
   Reporter : AUnit.Reporter.Text.Text_Reporter;
begin
   AUnit.Reporter.Text.Set_Use_ANSI_Colors (Reporter, True);
   Runner (Reporter);
end Test_Brackelib;
