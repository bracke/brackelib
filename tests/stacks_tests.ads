with AUnit;
with AUnit.Test_Fixtures;
with Brackelib.Stacks;

package Stacks_Tests is

   package State_Stacks is new Brackelib.Stacks (Integer);

   use State_Stacks;

   type Test is new AUnit.Test_Fixtures.Test_Fixture with null record;

   procedure Set_Up (T : in out Test);

   procedure Test_Push (T : in out Test);
   procedure Test_Pop (T : in out Test);
   procedure Test_Top (T : in out Test);
   procedure Test_Clear (T : in out Test);

end Stacks_Tests;
