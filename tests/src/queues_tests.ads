with AUnit;
with AUnit.Test_Fixtures;
with Brackelib.Queues;

package Queues_Tests is

   package State_Queues is new Brackelib.Queues (Integer);
   use State_Queues;

   type Test is new AUnit.Test_Fixtures.Test_Fixture with null record;

   procedure Set_Up (T : in out Test);

   procedure Test_Enqueue (T : in out Test);
   procedure Test_Dequeue (T : in out Test);
   procedure Test_Clear (T : in out Test);
   procedure Test_Empty (T : in out Test);

end Queues_Tests;
