pragma Ada_2022;
pragma Extensions_Allowed (all);

with Ada.Directories;
with Ada.Text_IO;

package body Brackelib.Files is

   package AD renames Ada.Directories;
   package IO renames Ada.Text_IO;

   procedure Copy_Files (Source : in String; Target : in String; Pattern : in String; Overwrite : in Boolean := False; Delete_Source_Files : in Boolean := False) is

      Skip_File : Boolean := False;
      Dir : AD.Directory_Entry_Type;
      Dir_Search : AD.Search_Type;
   begin
      AD.Start_Search (
         Search      => Dir_Search,
         Directory   => Source,
         Pattern     => "*.ad*"
      );
      loop
         AD.Get_Next_Entry (Dir_Search, Dir);
         declare
            Source      : constant String := AD.Full_Name (Dir);
            Filename    : constant String := AD.Simple_Name (Dir);
            Target_Path : constant String := AD.Compose (Target, Filename);
         begin
            if AD.Exists (Target_Path) then
               if Overwrite then
                  AD.Delete_File (Target_Path);
               else
                  Skip_File := True;
               end if;
            end if;
            if not Skip_File then
               --  IO.Put_Line (f"S_{Source}_ T: _{Target_Path}_ ");
               AD.Copy_File (Source, Target_Path);
               if Delete_Source_Files then
                  AD.Delete_File (Source);
               end if;
            end if;
            Skip_File := false;
         end;
         exit when not AD.More_Entries (Dir_Search);
      end loop;
   end Copy_Files;

   procedure Move_Files (Source : in String; Target : in String; Pattern : in String; Overwrite : in Boolean := False) is
   begin
      Copy_Files (Source, Target, Pattern, Overwrite, Delete_Source_Files => True);
   end Move_Files;

end Brackelib.Files;