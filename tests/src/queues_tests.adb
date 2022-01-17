with AUnit.Assertions; use AUnit.Assertions;
with Brackelib;

package body Queues_Tests is

   Container : State_Queues.Queue;

   procedure Set_Up (T : in out Test) is
   begin
      null;
   end Set_Up;

   procedure Test_Enqueue (T : in out Test) is
   begin
      Assert (Size (Container) = 0, "Incorrect size before push");
      Enqueue (Container, 314);
      Assert (Size (Container) = 1, "Incorrect size after push");
   end Test_Enqueue;

   procedure Test_Dequeue (T : in out Test) is
   begin
      Assert (Size (Container) = 1, "Incorrect size before push");
      declare
         Item : Integer := Dequeue (Container);
      begin
         Assert (Size (Container) = 0, "Incorrect size after push");
      end;
      Assert (Dequeue (Container) = 1234, "Exception Stack_Empty not raised");
   exception
   when Queue_Empty =>
      null;
   end Test_Dequeue;

   procedure Test_Clear (T : in out Test) is
   begin
      Assert (Size (Container) = 0, "Incorrect size before push");
      Enqueue (Container, 314);
      Assert (Size (Container) = 1, "Incorrect size after push");
      Clear (Container);
      Assert (Is_Empty (Container), "Incorrect Is_Empty response after clear");
   end Test_Clear;

   procedure Test_Empty (T : in out Test) is
   begin
      Assert (Size (Container) = 0, "Incorrect size before Is_Empty");
      Assert (Is_Empty (Container), "Incorrect Is_Empty response");
      Enqueue (Container, 314);
      Assert (not Is_Empty (Container), "Incorrect Is_Empty response");
   end Test_Empty;

end Queues_Tests;
