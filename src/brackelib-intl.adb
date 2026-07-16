pragma Ada_2022;
with VSS.String_Vectors; use VSS.String_Vectors;
with Brackelib.Strings;  use Brackelib.Strings;
with Brackelib.Templates;
with Brackelib.Files;
with GNATCOLL.VFS_Utils;
with GNATCOLL.VFS; use GNATCOLL.VFS;
with VSS.Strings.Conversions; use VSS.Strings.Conversions;

package body Brackelib.Intl is

   package BS renames Brackelib.Strings;
   package BT renames Brackelib.Templates;
   package BF renames Brackelib.Files;

   procedure Load_Tokens (E : in out Intl; Source : Virtual_String) is

      Converted_Path : constant GNATCOLL.VFS.Filesystem_String :=
        GNATCOLL.VFS.Filesystem_String
          (VSS.Strings.Conversions.To_UTF_8_String (Source));

      File : constant GNATCOLL.VFS.Virtual_File
         := GNATCOLL.VFS.Create (Converted_Path);

      Content : constant Virtual_String := BF.Read_All_Text (File);
      Lines   : constant Virtual_String_Vector := Split_Lines (Content);
      Token, Value : Virtual_String := "";
   begin
      for Line of Lines loop
         if not Line.Is_Empty then
            if not Line.Starts_With ("#") then
               BS.Read_Token (Line, Token, Value);
               if not Token.Is_Empty then
                  E.Tokens.Include (To_Wide_Wide_String (Token), Value);
               end if;
            end if;
         end if;
      end loop;
   end Load_Tokens;

   procedure Load (E : in out Intl) is

      Converted_Source : constant GNATCOLL.VFS.Filesystem_String :=
        GNATCOLL.VFS.Filesystem_String
          (VSS.Strings.Conversions.To_UTF_8_String (E.Resources_Location));

      Source_Path : constant Virtual_String :=
        BF.To_Virtual_String (
         GNATCOLL.VFS_Utils.Compose (Converted_Source,
            GNATCOLL.VFS.Filesystem_String (E.Language), ".yaml"));

      Source_Path_Default : constant Virtual_String :=
        BF.To_Virtual_String (
         GNATCOLL.VFS_Utils.Compose (Converted_Source, "eng", ".yaml"));
   begin
      if BF.Exists (Source_Path) then
         Load_Tokens (E, Source_Path);
      elsif BF.Exists (Source_Path_Default) then
         Load_Tokens (E, Source_Path_Default);
      else
         raise Resource_Not_Found;
      end if;
      E.Tokens_Loaded := True;
   end Load;

   function T
     (E          : in out Intl;
      Token      : Virtual_String;
      Parameters : Virtual_String := "") return Virtual_String
   is

      Text, Key, Value : Virtual_String;
      P_List           : constant Virtual_String_Vector :=
        BS.Split (Parameters, ",");

      T_Values : BT.Template_Values_Map.Map;
   begin
      if not E.Tokens_Loaded then
         Load (E);
      end if;

      for element of P_List loop
         BS.Read_Token (element, Key, Value, Separator => "=");
         T_Values.Include (To_Wide_Wide_String ("{" & Key & "}"), Value);
      end loop;

      Text := E.Tokens.Element (To_Wide_Wide_String (Token));

      return BT.Fill_In (Text, T_Values);
   end T;

   procedure Set_Resources_Location
     (E : in out Intl; Resources_Location : Virtual_String) is
   begin
      E.Resources_Location := Resources_Location;
      E.Tokens.Clear;
      E.Tokens_Loaded := False;
   end Set_Resources_Location;

   function Get_Resources_Location (E : Intl) return Virtual_String is
   begin
      return E.Resources_Location;
   end Get_Resources_Location;

   procedure Set_Language (E : in out Intl; Language : Language_Code) is
   begin
      E.Language := Language;
      E.Tokens.Clear;
      E.Tokens_Loaded := False;
   end Set_Language;

   function Get_Language (E : Intl) return Language_Code is
   begin
      return E.Language;
   end Get_Language;

end Brackelib.Intl;
