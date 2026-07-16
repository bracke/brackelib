pragma Ada_2022;
with Brackelib.Strings;
with Brackelib.Files;
with VSS.Command_Line;
with Ada.Strings.Fixed; use Ada.Strings.Fixed;
with Ada.Characters.Conversions;

package body Brackelib.Templates is

   package BS renames Brackelib.Strings;
   package BF renames Brackelib.Files;

   function Fill_In (Template : Virtual_String;
                     Values : Template_Values_Map.Map) return Virtual_String is

      C  : Template_Values_Map.Cursor
         := Template_Values_Map.First (Values);

      Key, Element :  Virtual_String := "";
      Content : Virtual_String := Template;
   begin
      while Template_Values_Map.Has_Element (C) loop

         Key := To_Virtual_String (Template_Values_Map.Key (C));
         Element := Template_Values_Map.Element (C);
         BS.Replace (Content, Key, Element);

         Template_Values_Map.Next (C);
      end loop;

      return Content;
   end Fill_In;

   procedure Write_Template (Target_Filename   : Virtual_String;
                             Template_Filename : Virtual_File;
                             Values            : Template_Values_Map.Map;
                             Append            : Boolean := False) is

      Template : constant Virtual_String :=
        BF.Read_All_Text (Template_Filename);

      Content  : constant Virtual_String := Fill_In (Template, Values);
   begin
      if Append and then BF.Exists (Target_Filename) then
         BF.Append_Text (Target_Filename, Content);
      else
         BF.Write_Text (Target_Filename, Content);
      end if;

   end Write_Template;

end Brackelib.Templates;
