pragma Ada_2022;
pragma Extensions_Allowed (All_Extensions);

with Ada.Strings.Unbounded;
with AUnit.Assertions; use AUnit.Assertions;
with Brackelib;
with Ada.Strings.Fixed;
with Ada.Strings.Maps;
with Ada.Strings.Maps.Constants;

package body Strings_Tests is

   package AU renames Ada.Strings.Unbounded;
   package BS renames Brackelib.Strings;

   use Ada.Strings.Maps;
   use Ada.Strings.Maps.Constants;

   function ToU (Source : String) return Ada.Strings.Unbounded.Unbounded_String renames Ada.Strings.Unbounded.To_Unbounded_String;

   procedure Set_Up (T : in out Test) is
   begin
      null;
   end Set_Up;

   procedure Test_Is_In (T : in out Test) is

      whitespace : constant Character_Set :=
       To_Set (' ' & ASCII.LF & ASCII.HT & ASCII.CR & Character'val(0));

      useless_characters : constant Character_Set := Control_Set and To_Set (' ');
   begin
      Assert (not BS.Is_In ("blah",whitespace), "Problem with whitespace test");
      Assert (BS.Is_In ("",whitespace), "Problem with whitespace test - empty text");
      Assert (BS.Is_In (" ",whitespace), "Problem with whitespace test - empty text");
      Assert (not BS.Is_In ("  d",whitespace), "Problem with whitespace test - nonempty text");
      Assert (BS.Is_In (f" \n \t \n",whitespace), "Problem with whitespace test - complex whitespace");
   end Test_Is_In;

   procedure Test_Starts_With (T : in out Test) is
   begin
      Assert (not BS.Starts_With (ToU (""), "#"), "Problem with empty string");
      Assert (not BS.Starts_With (ToU (""), ""), "Problem with empty string");
      Assert (BS.Starts_With (ToU ("#"), "#"), "Problem single character match");
      Assert (not BS.Starts_With (ToU ("#"), "# "), "Problem with single character match when pattern is multi character");
      Assert (BS.Starts_With (ToU ("# "), "# "), "Problem with multi character pattern");
   end Test_Starts_With;

end Strings_Tests;