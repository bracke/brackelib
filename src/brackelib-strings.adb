with Ada.Text_IO;
with Ada.Characters.Latin_1;
with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;

package body Brackelib.Strings is

   package IO renames Ada.Text_IO;
   package AU renames Ada.Strings.Unbounded;

   function Is_In
     (Text : in String; Set : in Character_Set) return Boolean is
   begin
      for C of Text loop
         if not Ada.Strings.Maps.Is_In(C, Set) then
            return false;
         end if;
      end loop;
      return True;
   end Is_In;

   function Starts_With (Text : in Ada.Strings.Unbounded.Unbounded_String; Pattern : in String) return Boolean is
   begin
      return AU.Index (Text, Pattern, 1) = 1;
   end Starts_With;

   function Read_All_Text (Filename : in String) return String is

      File : IO.File_Type;
      Textbuffer : AU.Unbounded_String := AU.To_Unbounded_String ("");
   begin
      IO.Open (File, IO.In_File, Filename);

      loop
         Textbuffer := Textbuffer & IO.Get_Line (File) & Ada.Characters.Latin_1.LF;
      end loop;
   exception
      when others => IO.Close (File); return AU.To_String (Textbuffer);
   end Read_All_Text;

   procedure Write_Text (Filename : in String; Text : in String) is

      File : IO.File_Type;
   begin
      IO.Open (File, IO.Out_File, Filename);
      IO.Put (File, Text);
      IO.Close (File);
   end Write_Text;

   procedure Append_Text (Filename : in String; Text : in String) is

      File : IO.File_Type;
   begin
      IO.Open (File, IO.Append_File, Filename);
      IO.Put (File, Text);
      IO.Close (File);
   end Append_Text;

   procedure Create_Textfile (Filename : in String; Text : in String) is

      File : IO.File_Type;
   begin
      IO.Create (File, IO.Out_File, Filename);
      IO.Put (Text);
      IO.Close (File);
   end Create_Textfile;

end Brackelib.Strings;