package body Brackelib.Queues is

   procedure Enqueue (Self : in out Queue; Item : T) is
   begin
      Self.Container.Append (Item);
   end Enqueue;

   function Dequeue (Self : in out Queue) return T is

      Result: T;
   begin
      if Is_Empty (Self) then
         raise Queue_Empty;
      end if;

      Result := Last_Element (Self.Container);
      Delete_Last (Self.Container);
      return Result;
   end Dequeue;

   function Size (Self : Queue) return Integer is
   begin
      return Natural (Length (Self.Container));
   end Size;

   function Is_Empty (Self : Queue) return Boolean is
   begin
      return Size(Self) = 0;
   end Is_Empty;

   procedure Clear (Self : in out Queue) is
   begin
      Self.Container.Clear;
   end Clear;

end Brackelib.Queues;