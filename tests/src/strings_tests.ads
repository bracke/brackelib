with AUnit;
with AUnit.Test_Fixtures;
with Brackelib.Strings;

package Strings_Tests is

   type Test is new AUnit.Test_Fixtures.Test_Fixture with null record;

   procedure Set_Up (T : in out Test);

   procedure Test_Is_In (T : in out Test);
   procedure Test_Starts_With (T : in out Test);

end Strings_Tests;