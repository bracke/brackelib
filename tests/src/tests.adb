with AUnit.Reporter.Text;
with AUnit.Run;
with Utilities_Suite; use Utilities_Suite;

procedure Tests is
   procedure Utilities_Runner is new AUnit.Run.Test_Runner (Utilities_Suite.Suite);
   Reporter : AUnit.Reporter.Text.Text_Reporter;
begin
   AUnit.Reporter.Text.Set_Use_ANSI_Colors (Reporter, True);
   Utilities_Runner (Reporter);
end Tests;
