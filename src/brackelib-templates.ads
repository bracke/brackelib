with Ada.Containers;
with Ada.Containers.Indefinite_Hashed_Maps;
with VSS.Strings; use VSS.Strings;
with GNATCOLL.VFS; use GNATCOLL.VFS;
with Ada.Strings.Wide_Wide_Hash;

package Brackelib.Templates is
--  A simple template system

   package Template_Values_Map is new Ada.Containers.Indefinite_Hashed_Maps
     (Key_Type          => Wide_Wide_String,
      Element_Type      => Virtual_String,
      Hash              => Ada.Strings.Wide_Wide_Hash,
      Equivalent_Keys   => "=");
   --  The instantiated generic hashmap that is used as a container
   --  for the values for filling into the template.

   function Fill_In (Template : Virtual_String;
                     Values   : Template_Values_Map.Map)
                     return VSS.Strings.Virtual_String;
   --  Replace placeholders with matching values.
   --  @param Template The string containing placeholders which are to replaced
   --    with matching values.
   --  @param Values The hashmap containing the values which are to be inserted
   --    into the template.
   --  @return The template with placeholders replaced by values.

   procedure Write_Template (Target_Filename   : Virtual_String;
                             Template_Filename : Virtual_File;
                             Values            : Template_Values_Map.Map;
                             Append            : Boolean := False);
   --  Create content by filling in values into template and write the content
   --    to file.
   --  @param Target_Filename The name of the file the content should be
   --    written to.
   --  @param Template_Filename The file containing the template.
   --  @param Values The hashmap containing the values which are to be inserted
   --    into the template.
   --  @param Append Should the content be appended to an existing file or
   --    should it overwrite existing content.

end Brackelib.Templates;
