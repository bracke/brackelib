pragma Ada_2022;
pragma Extensions_Allowed (On);

with VSS.Strings.Conversions; use VSS.Strings.Conversions;
with GNATCOLL.VFS;            use GNATCOLL.VFS;
with GNATCOLL.VFS_Utils;      use GNATCOLL.VFS_Utils;
with GNATCOLL.Strings;

with Ada.Strings;
with Ada.Strings.UTF_Encoding;

package body Brackelib.Files is

   function Compose (Containing_Directory : VSS.Strings.Virtual_String := "";
                     Name : VSS.Strings.Virtual_String;
                     Extension : VSS.Strings.Virtual_String := "")

      return GNATCOLL.VFS.Filesystem_String is

      Converted_Target : constant GNATCOLL.VFS.Filesystem_String :=
        GNATCOLL.VFS.Filesystem_String
          (VSS.Strings.Conversions.To_UTF_8_String (Containing_Directory));

      Converted_Name : constant GNATCOLL.VFS.Filesystem_String :=
        GNATCOLL.VFS.Filesystem_String
          (VSS.Strings.Conversions.To_UTF_8_String (Name));

      Converted_Extension : constant GNATCOLL.VFS.Filesystem_String :=
        GNATCOLL.VFS.Filesystem_String
          (VSS.Strings.Conversions.To_UTF_8_String (Extension));
   begin
      return GNATCOLL.VFS_Utils.Compose (Converted_Target,
         Converted_Name, Converted_Extension);
   end Compose;

   function To_Virtual_String (Input : GNATCOLL.VFS.Filesystem_String)
      return VSS.Strings.Virtual_String is
   begin
      return To_Virtual_String (Ada.Strings.UTF_Encoding.UTF_8_String (Input));
   end To_Virtual_String;

   function Compose (Containing_Directory : VSS.Strings.Virtual_String := "";
                     Name : VSS.Strings.Virtual_String;
                     Extension : VSS.Strings.Virtual_String := "")
      return VSS.Strings.Virtual_String is

      Converted_Target : constant GNATCOLL.VFS.Filesystem_String :=
        GNATCOLL.VFS.Filesystem_String
          (VSS.Strings.Conversions.To_UTF_8_String (Containing_Directory));

      Converted_Name : constant GNATCOLL.VFS.Filesystem_String :=
        GNATCOLL.VFS.Filesystem_String
          (VSS.Strings.Conversions.To_UTF_8_String (Name));

      Converted_Extension : constant GNATCOLL.VFS.Filesystem_String :=
        GNATCOLL.VFS.Filesystem_String
          (VSS.Strings.Conversions.To_UTF_8_String (Extension));
   begin
      return To_Virtual_String (
         GNATCOLL.VFS_Utils.Compose (Converted_Target,
            Converted_Name, Converted_Extension));
   end Compose;

   function Read_All_Text
     (Filename : Virtual_File) return VSS.Strings.Virtual_String is

      Temp : GNATCOLL.Strings.XString;
      Result : VSS.Strings.Virtual_String;
   begin
      Temp := GNATCOLL.VFS.Read_File (Filename);
      Result := To_Virtual_String (GNATCOLL.Strings.To_String (Temp));

      return Result;
   end Read_All_Text;

   procedure Append_Text
     (Filename : VSS.Strings.Virtual_String;
      Text : VSS.Strings.Virtual_String) is

      Converted_Path : constant GNATCOLL.VFS.Filesystem_String :=
        GNATCOLL.VFS.Filesystem_String
          (VSS.Strings.Conversions.To_UTF_8_String (Filename));

      File : constant GNATCOLL.VFS.Virtual_File
           := GNATCOLL.VFS.Create (Converted_Path);
      WFile : GNATCOLL.VFS.Writable_File :=
            GNATCOLL.VFS.Write_File (File, Append => True);
   begin
      if WFile /= GNATCOLL.VFS.Invalid_File then
         GNATCOLL.VFS.Write (WFile,
            VSS.Strings.Conversions.To_UTF_8_String (Text));
         GNATCOLL.VFS.Close (WFile);
      end if;
   end Append_Text;

   procedure Write_Text
     (Filename : VSS.Strings.Virtual_String;
      Text : VSS.Strings.Virtual_String) is

      Converted_Path : constant GNATCOLL.VFS.Filesystem_String :=
        GNATCOLL.VFS.Filesystem_String
          (VSS.Strings.Conversions.To_UTF_8_String (Filename));

      File : constant GNATCOLL.VFS.Virtual_File
           := GNATCOLL.VFS.Create (Converted_Path);
      WFile : GNATCOLL.VFS.Writable_File :=
            GNATCOLL.VFS.Write_File (File, Append => False);
   begin
      if WFile /= GNATCOLL.VFS.Invalid_File then
         GNATCOLL.VFS.Write (WFile,
            VSS.Strings.Conversions.To_UTF_8_String (Text));
         GNATCOLL.VFS.Close (WFile);
      end if;
   end Write_Text;

   function Exists (Path : VSS.Strings.Virtual_String) return Boolean is

      File           : GNATCOLL.VFS.Virtual_File;
      Converted_Path : constant GNATCOLL.VFS.Filesystem_String :=
        GNATCOLL.VFS.Filesystem_String
          (VSS.Strings.Conversions.To_UTF_8_String (Path));
   begin
      File := GNATCOLL.VFS.Create (Converted_Path);
      return GNATCOLL.VFS.Is_Regular_File (File)
        or else GNATCOLL.VFS.Is_Directory (File);
   exception
      when others =>
         return False;
   end Exists;

   function Delete_File (Filepath : VSS.Strings.Virtual_String)
      return Boolean is

      Converted_Path : constant GNATCOLL.VFS.Filesystem_String :=
        GNATCOLL.VFS.Filesystem_String
          (VSS.Strings.Conversions.To_UTF_8_String (Filepath));

      File : constant GNATCOLL.VFS.Virtual_File
         := GNATCOLL.VFS.Create (Converted_Path);
      Success : Boolean := False;
   begin
      GNATCOLL.VFS.Delete (File, Success);
      return Success;
   end Delete_File;

   function Copy_File (Source : VSS.Strings.Virtual_String;
                       Target : VSS.Strings.Virtual_String) return Boolean is

      Converted_Path : constant GNATCOLL.VFS.Filesystem_String
                     := GNATCOLL.VFS.Filesystem_String
                     (VSS.Strings.Conversions.To_UTF_8_String (Source));

      File : constant GNATCOLL.VFS.Virtual_File
         := GNATCOLL.VFS.Create (Converted_Path);

      Converted_Target : constant GNATCOLL.VFS.Filesystem_String
                       := GNATCOLL.VFS.Filesystem_String (
                        VSS.Strings.Conversions.To_UTF_8_String (Target));

      Success : Boolean := False;
   begin
      GNATCOLL.VFS.Copy (File, Converted_Target, Success);
      return Success;
   end Copy_File;

   procedure Copy_Files
     (Source              : VSS.Strings.Virtual_String;
      Target              : VSS.Strings.Virtual_String;
      Pattern             : VSS.Strings.Virtual_String;
      Overwrite           : Boolean := False;
      Delete_Source_Files : Boolean := False) is

      Success : Boolean;
      Skip_File  : Boolean := False;
      Files : GNATCOLL.VFS.File_Array_Access;

      Converted_Target : constant GNATCOLL.VFS.Filesystem_String :=
        GNATCOLL.VFS.Filesystem_String
          (VSS.Strings.Conversions.To_UTF_8_String (Target));

      Converted_Source : constant GNATCOLL.VFS.Filesystem_String :=
        GNATCOLL.VFS.Filesystem_String
          (VSS.Strings.Conversions.To_UTF_8_String (Source));

      File : constant GNATCOLL.VFS.Virtual_File
         := GNATCOLL.VFS.Create (Converted_Source);
   begin
      Files := GNATCOLL.VFS.Read_Dir (File, GNATCOLL.VFS.Files_Only);

      for filehandle of Files.all loop
         declare
            Source      : constant GNATCOLL.VFS.Filesystem_String
               := GNATCOLL.VFS.Full_Name (filehandle);
            Source_VS   : constant VSS.Strings.Virtual_String
               := To_Virtual_String (Source);
            Filename    : constant GNATCOLL.VFS.Filesystem_String
               := GNATCOLL.VFS.Base_Name (filehandle);
            Target_Path : constant VSS.Strings.Virtual_String
               := To_Virtual_String (
                  GNATCOLL.VFS_Utils.Compose (Converted_Target, Filename));
         begin
            if Exists (Target_Path) then
               if Overwrite then
                  Success := Delete_File (Target_Path);
               else
                  Skip_File := True;
               end if;
            end if;
            if not Skip_File then
               Success := Copy_File (Source_VS, Target_Path);
               if Success and then Delete_Source_Files then
                  Success := Delete_File (Source_VS);
               end if;
            end if;
            Skip_File := False;
         end;
      end loop;

      GNATCOLL.VFS.Unchecked_Free (Files);

   end Copy_Files;

   procedure Move_Files
     (Source    : VSS.Strings.Virtual_String;
      Target    : VSS.Strings.Virtual_String;
      Pattern   : VSS.Strings.Virtual_String;
      Overwrite : Boolean := False) is
   begin
      Copy_Files
        (Source, Target, Pattern, Overwrite, Delete_Source_Files => True);
   end Move_Files;

end Brackelib.Files;
