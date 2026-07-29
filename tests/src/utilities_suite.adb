with Strings_Tests; use Strings_Tests;

with AUnit.Test_Caller;

package body Utilities_Suite is

   package Caller is new AUnit.Test_Caller (Strings_Tests.Test);

   function Suite return Access_Test_Suite is
      Ret : constant Access_Test_Suite := new Test_Suite;
   begin
      Ret.Add_Test (Caller.Create ("Strings - Is_In test", Strings_Tests.Test_Is_In'Access));
      Ret.Add_Test (Caller.Create ("Strings - Starts_with Test", Strings_Tests.Test_Starts_With'Access));

      return Ret;
   end Suite;

end Utilities_Suite;
