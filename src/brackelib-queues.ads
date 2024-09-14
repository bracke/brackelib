with Ada.Containers.Doubly_Linked_Lists;
use Ada.Containers;

generic
  type T is private;
package Brackelib.Queues is
--  @summary
--  Simplistic implementation of the queue abstract data type

   type Queue is limited private;

   procedure Enqueue (Self : in out Queue; Item : T);
   --  Adds an item to the end of the queue.
   --  @param Self The queue
   --  @param Item The item to be added

   function Dequeue (Self : in out Queue) return T;
   --  Removes the first item off the queue and returns it.
   --  @param Self The queue
   --  @return Item The first item is returned
   --  @exception Queue_Empty Raised if the queue is empty and thus no item can be returned.

   function Size (Self : Queue) return Integer;
   --  Returns the number of items in the queue.
   --  @param Self The queue
   --  @return Count Number of items in the queue

   function Is_Empty (Self : Queue) return Boolean;
   --  Returns whether the queue is empty.
   --  @param Self The queue
   --  @return True If the queue is empty

   procedure Clear (Self : in out Queue);
   --  Removes all items from the queue.
   --  @param Self The queue

   Queue_Empty : Exception;

private

   package Queue_Container is new Doubly_Linked_Lists(T);
   use Queue_Container;

   type Queue is record
      Container: List;
   end record;

end Brackelib.Queues;