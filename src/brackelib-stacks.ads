with Ada.Containers.Doubly_Linked_Lists;
use Ada.Containers;

generic
  type T is private;

package Brackelib.Stacks is

   type Stack is limited private;

   procedure Push (Self : in out Stack; Item : T);
   function Pop (Self : in out Stack) return T;
   function Top (Self : in Stack) return T;
   function Size (Self : Stack) return Integer;
   function Is_Empty (Self : Stack) return Boolean;
   procedure Clear (Self : in out Stack);

   Stack_Empty : Exception;

private

   package Stack_Container is new Doubly_Linked_Lists(T);
   use Stack_Container;

   type Stack is record
      Container: List;
   end record;

end Brackelib.Stacks;