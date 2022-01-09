with Ada.Containers.Doubly_Linked_Lists;
use Ada.Containers;

generic
  type T is private;

package Brackelib.Queues is

   type Queue is limited private;

   procedure Enqueue (Self : in out Queue; Item : T);

   function Dequeue (Self : in out Queue) return T;

   function Size (Self : Queue) return Integer;

   function Is_Empty (Self : Queue) return Boolean;

   procedure Clear (Self : in out Queue);

   Queue_Empty : Exception;

private

   package Queue_Container is new Doubly_Linked_Lists(T);
   use Queue_Container;

   type Queue is record
      Container: List;
   end record;

end Brackelib.Queues;