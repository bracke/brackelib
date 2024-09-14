with Ada.Strings.Fixed;
with Ada.Strings.Maps;
with Ada.Strings.Unbounded;
with Ada.Strings.Maps;
with Ada.Strings.Maps.Constants;

package Brackelib.Strings is
--  @summary
--  String related helper functions

   use Ada.Strings.Maps;
   use Ada.Strings.Fixed;
   use Ada.Strings.Maps.Constants;

   whitespace : constant Character_Set :=
       To_Set (' ' & ASCII.LF & ASCII.HT & ASCII.CR & Character'val(0));

   useless_characters : constant Character_Set := Control_Set and whitespace;


   function Is_In (Text : in String; Set : in Character_Set) return Boolean;
   --  Returns whether all characters of the text are in the set.
   --  @param Text The text
   --  @param Set The character set
   --  @return True if all characters of the text are in the set

   function Starts_With (Text : in Ada.Strings.Unbounded.Unbounded_String; Pattern : in String) return Boolean;
   --  Returns whether the Text starts with the Pattern
   --  @param Text The text
   --  @param Pattern The pattern to look for
   --  @return True if the Text starts with the Pattern

   function Read_All_Text (Filename : in String) return String;
   --  Returns the contents of the file
   --  @param Filename The filename or path of the file to be read
   --  @return Contents of file as a string

   procedure Write_Text (Filename : in String; Text : in String);
   --  Writes the Text to the file pointed to by Filename
   --  @param Filename The filename or path of the file where the Text is going to be written to
   --  @param Text The text to be written to the file. This will overwrite any existing content

   procedure Append_Text (Filename : in String; Text : in String);
   --  Appends the Text to the content of the file pointed to by Filename
   --  @param Filename The filename or path of the file to be read
   --  @param Text The text to be appended to the file.

   procedure Create_Textfile (Filename : in String; Text : in String);
   --  Creates a new file with the name or path Filename and Text as content
   --  @param Filename The filename or path of the new file
   --  @param Text The text to be written to the file.

end Brackelib.Strings;