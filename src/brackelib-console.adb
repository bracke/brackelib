with GNAT.OS_Lib;
with CLIC.TTY;
with Ada.Text_IO;
with Ada.Characters.Handling;
with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;
with Interfaces.C;

package body Brackelib.Console is

   package TT renames CLIC.TTY;
   package C renames Interfaces.C;
   use type C.int;

   function system (command : C.char_array) return C.int
     with Import, Convention => C;

   package IO renames Ada.Text_IO;
   package AU renames Ada.Strings.Unbounded;
   package ACH renames Ada.Characters.Handling;

   function ToU (Source : String) return Unbounded_String
     renames Ada.Strings.Unbounded.To_Unbounded_String;

   function Ask (Request : String; First : String := "Yes";
                 Second : String := "No") return Boolean is
      Input : Character;
   begin
      IO.New_Line;
      IO.Put_Line (Request);
      IO.Put_Line ("1. " & First);
      IO.Put_Line ("2. " & Second);
      IO.Put_Line ("Enter your choice index (first is default)");
      IO.Put ("> ");

      loop
         IO.Get_Immediate (Input);
         IO.Put (Input);

         if Ada.Characters.Handling.Is_Line_Terminator (Input) then
            return True;
         elsif Input = '1' then
            return True;
         elsif Input = '2' then
            return False;
         end if;
      end loop;
   end Ask;

   function Ask (Request : String) return String is
      Input : AU.Unbounded_String;
   begin
      IO.Put_Line (Request);
      IO.Put ("> ");

      loop
         Input := ToU (IO.Get_Line);
         if Length (Input) > 0 then
            return AU.To_String (Input);
         end if;
      end loop;

   end Ask;

   function Run (Command : String) return Boolean is

      CCommand : aliased constant C.char_array := C.To_C (Command);
      Result : C.int;
   begin
      Result := system (CCommand);
      return Result = 0;
   end Run;

   procedure Message (Stream : Stream_Access; Message : String) is
   begin
      Character'Write (Stream, ASCII.LF);
      String'Write (Stream, Message);
      Character'Write (Stream, ASCII.LF);
   end Message;

   procedure Error_Message (Stream : Stream_Access; Message : String) is
   begin
      TT.Enable_Color (True);
      Brackelib.Console.Message (Stream, TT.Error (Message));
   end Error_Message;

   procedure Success_Message (Stream : Stream_Access; Message : String) is
   begin
      TT.Enable_Color (True);
      String'Write (Stream, TT.Success (Message));
      Character'Write (Stream, ASCII.LF);
   end Success_Message;

end Brackelib.Console;