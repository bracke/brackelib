with Stacks_Tests; use Stacks_Tests;
with Queues_Tests; use Queues_Tests;
with AUnit.Test_Caller;

package body Container_Suite is

   package Caller is new AUnit.Test_Caller (Stacks_Tests.Test);
   package Caller2 is new AUnit.Test_Caller (Queues_Tests.Test);

   function Suite return Access_Test_Suite is
      Ret : constant Access_Test_Suite := new Test_Suite;
   begin
      Ret.Add_Test (Caller.Create ("Stacks - Push test", Test_Push'Access));
      Ret.Add_Test (Caller.Create ("Stacks - Pop Test", Test_Pop'Access));
      Ret.Add_Test (Caller.Create ("Stacks - Top Test", Test_Top'Access));
      Ret.Add_Test (Caller.Create ("Stacks - Clear Test", Test_Clear'Access));

      Ret.Add_Test (Caller2.Create ("Queues - Enqueue test", Test_Enqueue'Access));
      Ret.Add_Test (Caller2.Create ("Queues - Dequeue Test", Test_Dequeue'Access));
      Ret.Add_Test (Caller2.Create ("Queues - Clear Test", Test_Clear'Access));
      Ret.Add_Test (Caller2.Create ("Queues - Is_Empty Test", Test_Empty'Access));

      return Ret;
   end Suite;

end Container_Suite;
