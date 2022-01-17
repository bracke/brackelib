with AUnit.Assertions; use AUnit.Assertions;
with Brackelib;

package body Stacks_Tests  is

   Container : State_Stacks.Stack;

   procedure Set_Up (T : in out Test) is
   begin
      null;
   end Set_Up;

   procedure Test_Push (T : in out Test) is
   begin
      Assert (Size (Container) = 0, "Incorrect size before push");
      Push (Container, 314);
      Assert (Size (Container) = 1, "Incorrect size after push");
   end Test_Push;

   procedure Test_Pop (T : in out Test) is
   begin
      Assert (Size (Container) = 1, "Incorrect size after push");
      Assert (Pop (Container) = 314, "Incorrect value from pop");
      Assert (Size (Container) = 0, "Incorrect size after pop");

      Assert (Pop (Container) = 1234, "Exception Stack_Empty not raised");
   exception
   when Stack_Empty =>
      null;
   end Test_Pop;

   procedure Test_Top (T : in out Test) is
   begin
      Push (Container, 315);
      Assert (Size (Container) = 1, "Incorrect size after push");
      Assert (Top (Container) = 315, "Incorrect value from top");
      Assert (Size (Container) = 1, "Incorrect size after top");
   end Test_Top;

   procedure Test_Clear (T : in out Test) is
   begin
      Push (Container, 316);
      Assert (Size (Container) = 2, "Incorrect size after push");
      Clear (Container);
      Assert (Size (Container) = 0, "Incorrect size after clear");
   end Test_Clear;

end Stacks_Tests;