with Ada.Strings.Maps;
with Ada.Strings.Maps.Constants;
with VSS.Strings; use VSS.Strings;
with VSS.String_Vectors;
with VSS.Characters;

package Brackelib.Strings is
   --  String related helper functions

   use Ada.Strings.Maps;
   use Ada.Strings.Maps.Constants;

   whitespace : constant Character_Set :=
     To_Set (' ' & ASCII.LF & ASCII.HT & ASCII.CR & Character'Val (0));
   --  A character set that contains various whitespace characters.

   useless_characters : constant Character_Set := Control_Set and whitespace;
   --  A character set that contains various whitespace characters and control
   --    characters.

   function To_Virtual_String (Input : String) return Virtual_String;
   --  Converts fixed string to virtual string
   --  @param Input The fixed string.
   --  @return The input string as a virtual string

   function Is_In (Text : String; Set : Character_Set) return Boolean;
   --  Returns whether all characters of the text are in the set.
   --  @param Text The text.
   --  @param Set The character set.
   --  @return True if all characters of the text are in the set.

   function Replace_Character
     (Input : Virtual_String;
      C     : VSS.Characters.Virtual_Character;
      R     : VSS.Characters.Virtual_Character)
      return Virtual_String;
   --  Replace all occurences of C in Input with R.
   --  @param Input The string containing the character which is to be
   --    replaced.
   --  @param C The character which is to be replaced.
   --  @param R The character that will replace C in the source.

   procedure Replace
     (Source  : in out Virtual_String;
      Pattern : Virtual_String;
      By      : Virtual_String);
   --  Replace all occurences of Pattern in Source with By.
   --  @param Source The string containing the pattern which is to be replaced.
   --  @param Pattern The pattern which is to be replaced.
   --  @param By The text that will replace the pattern in the source.
   --  @return The resulting string.

   function Fancy_Uppercase
     (Input : Virtual_String) return Virtual_String;
   --  Uppercase first character and first character after every dot.
   --  @param Input The string which is to be fancy-uppercased.
   --  @return The resulting fancy-uppercased string.

   procedure Read_Token
     (Source    : Virtual_String;
      Token     : out Virtual_String;
      Value     : out Virtual_String;
      Separator : Virtual_String := ": ");
   --  Read token and value from a string containing a separator.
   --  @param Source The string containing the token and value.
   --  @param Token The variable which will contain the extracted token.
   --  @param Value The variable which will contain the extracted value.
   --  @param Separator The character/string that separates the token from the
   --    value.

   function Split
     (Source  : Virtual_String;
      Pattern : Virtual_String)
      return VSS.String_Vectors.Virtual_String_Vector;
   --  Split source string into parts wherever the Pattern occurs.
   --  @param Source The string to be split.
   --  @param Pattern the pattern that separates the parts.
   --  @return A vector containing access values pointing to the parts.

end Brackelib.Strings;
