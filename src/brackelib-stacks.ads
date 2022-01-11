with Ada.Containers.Doubly_Linked_Lists;
use Ada.Containers;

generic
  type T is private;
package Brackelib.Stacks is
--  @summary
--  Implementation of the stack abstract data type

   type Stack is limited private;

   procedure Push (Self : in out Stack; Item : T);
   --  Adds an item to the top of the stack making it the top item.
   --  @param Self The stack
   --  @param Item The item to be added

   function Pop (Self : in out Stack) return T;
   --  Removes the top item off the stack and returns it.
   --  @param Self The stack
   --  @return Item The top item is returned
   --  @exception Stack_Empty Raised if the stack is empty and thus no item can be returned.

   function Top (Self : in Stack) return T;
   --  Returns the top item without removing it from the stack.
   --  @param Self The stack
   --  @return Item The top item is returned
   --  @exception Stack_Empty Raised if the stack is empty and thus no item can be returned.

   function Size (Self : Stack) return Natural;
   --  Returns the number of items in the stack.
   --  @param Self The stack
   --  @return Count Number of items in the stack

   function Is_Empty (Self : Stack) return Boolean;
   --  Returns whether the stack is empty.
   --  @param Self The stack
   --  @return True If the stack is empty

   procedure Clear (Self : in out Stack);
   --  Removes all items from the stack.
   --  @param Self The stack


   Stack_Empty : Exception;

private

   package Stack_Container is new Doubly_Linked_Lists(T);
   use Stack_Container;

   type Stack is record
      Container: List;
   end record;

end Brackelib.Stacks;