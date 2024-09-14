pragma Ada_2022;
pragma Extensions_Allowed (all);

with GNAT.OS_Lib;

with Ada.Text_IO;
with Ada.Characters.Handling;
with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;
with Interfaces.C;

package body Brackelib.Console is

   package C renames Interfaces.C;
   use type C.int;

   function system (command : C.char_array) return C.int
     with Import, Convention => C;

   package IO renames Ada.Text_IO;
   package AU renames Ada.Strings.Unbounded;
   package ACH renames Ada.Characters.Handling;

   function ToU (Source : String) return Unbounded_String renames Ada.Strings.Unbounded.To_Unbounded_String;

   function Ask (Request : String; First : String := "Yes"; Second : String := "No") return Boolean is
      Input : Character;
   begin
      IO.New_Line;
      IO.Put_Line (Request);
      IO.Put_Line (f"1. {First}");
      IO.Put_Line (f"2. {Second}");
      IO.Put_Line ("Enter your choice index (first is default)");
      IO.Put ("> ");

      loop
         IO.Get_Immediate (Input);
         IO.Put (Input);

         return True when Ada.Characters.Handling.Is_Line_Terminator (Input);
         return True when Input = '1';
         return False when Input = '2';
      end loop;
   end Ask;

   function Ask (Request : String) return String is
      Input : AU.Unbounded_String;
   begin
      IO.Put_Line (Request);
      IO.Put ("> ");

      loop
         Input := ToU (IO.Get_Line);

         return AU.To_String (Input) when Length (Input) > 0;
      end loop;

   end Ask;

   function Run (Command : in String) return Boolean is

      CCommand : aliased constant C.char_array := C.To_C (Command);
      Result : C.int;
   begin
      result := system (CCommand);
      Return Result = 0;
  end Run;

end Brackelib.Console;