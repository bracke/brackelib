with VSS.Regular_Expressions;
with VSS.Regular_Expressions.Utilities;
with VSS.Characters;
with VSS.Strings.Character_Iterators;

use  VSS.Characters;
with VSS.Transformers.Casing;
with Ada.Characters.Conversions;

package body Brackelib.Strings is

   use VSS.String_Vectors;
   package VSSRE renames VSS.Regular_Expressions;

   function To_Virtual_String (Input : String) return Virtual_String is

      Wide_Input : constant Wide_Wide_String :=
        Ada.Characters.Conversions.To_Wide_Wide_String (Input);
   begin
      return VSS.Strings.To_Virtual_String (Wide_Input);
   end To_Virtual_String;

   function Is_In (Text : String; Set : Character_Set) return Boolean is
   begin
      for C of Text loop
         if not Ada.Strings.Maps.Is_In (C, Set) then
            return False;
         end if;
      end loop;
      return True;
   end Is_In;

   procedure Replace
     (Source  : in out Virtual_String;
      Pattern : Virtual_String;
      By      : Virtual_String) is

      RE_Options  : constant VSSRE.Pattern_Options
                  := (VSSRE.Multiline => True, others => False);

      Escaped_Pattern : constant Virtual_String
                      := VSS.Regular_Expressions.Utilities.Escape (Pattern);

      RE : constant VSSRE.Regular_Expression
         := VSSRE.To_Regular_Expression (Escaped_Pattern, RE_Options);

      Match  : VSSRE.Regular_Expression_Match;
      Temp   : Virtual_String := "";
      Result : Virtual_String := Source;
   begin
      Match := RE.Match (Result);
      while Match.Has_Match loop
         Temp.Append (Result.Head_Before (Match.First_Marker));
         Temp.Append (By);
         Temp.Append (Result.Tail_From (Match.Last_Marker));
         Result := Temp;
         Temp := "";
         Match := RE.Match (Result);
      end loop;
      Source := Result;
   end Replace;

   function To_Upper
     (Input : VSS.Characters.Virtual_Character)
      return VSS.Characters.Virtual_Character
   is

      Input_String : Virtual_String := VSS.Strings."*" (1, Input);
      I            :
        constant VSS.Strings.Character_Iterators.Character_Iterator :=
          Input_String.At_First_Character;

   begin
      Input_String :=
        Input_String.Transform (VSS.Transformers.Casing.To_Uppercase);
      return I.Element;
   end To_Upper;

   function Replace_Character
     (Input : Virtual_String;
      C     : VSS.Characters.Virtual_Character;
      R     : VSS.Characters.Virtual_Character) return Virtual_String is

      I : VSS.Strings.Character_Iterators.Character_Iterator :=
        Input.Before_First_Character;
      Result : Virtual_String := "";
   begin
      while I.Forward loop
         if I.Element = C then
            Result.Append (R);
         else
            Result.Append (I.Element);
         end if;
      end loop;

      return Result;
   end Replace_Character;

   function Fancy_Uppercase
     (Input : Virtual_String) return Virtual_String
   is
      I : VSS.Strings.Character_Iterators.Character_Iterator
        := Input.At_First_Character;
      Result : Virtual_String := "";
      Previous_Was_Relevant : Boolean := False;
   begin
      Result.Append (Get_Uppercase_Mapping (I.Element));

      while I.Forward loop

         if Previous_Was_Relevant then
            Result.Append (Get_Uppercase_Mapping (I.Element));
         else
            Result.Append (I.Element);
         end if;

         Previous_Was_Relevant := I.Element = '.';
      end loop;

      return Result;

   end Fancy_Uppercase;

   procedure Read_Token
     (Source    : Virtual_String;
      Token     : out Virtual_String;
      Value     : out Virtual_String;
      Separator : Virtual_String := ": ") is

      Escaped_Pattern : constant Virtual_String :=
        VSS.Regular_Expressions.Utilities.Escape (Separator);
      RE : constant VSSRE.Regular_Expression :=
        VSSRE.To_Regular_Expression (Escaped_Pattern,
        (VSSRE.Multiline => True, others => False));

      Match  : constant VSSRE.Regular_Expression_Match := RE.Match (Source);
   begin
      if Match.Has_Match then
         Token := Source.Head_Before (Match.First_Marker);
         Value := Source.Tail_From (Match.Last_Marker);
      else
         Token := ""; Value := "";
      end if;
   end Read_Token;

   function Split
     (Source  : Virtual_String;
      Pattern : Virtual_String)
      return VSS.String_Vectors.Virtual_String_Vector is

      Escaped_Pattern : constant Virtual_String :=
        VSS.Regular_Expressions.Utilities.Escape (Pattern);
      RE : constant VSSRE.Regular_Expression :=
        VSSRE.To_Regular_Expression (Escaped_Pattern,
        (VSSRE.Multiline => True, others => False));

      Result : Virtual_String_Vector;
      Temp   : Virtual_String := Source;
      Match  : VSSRE.Regular_Expression_Match := RE.Match (Temp);
   begin
      Match := RE.Match (Temp);
      while Match.Has_Match loop
         Result.Append (Temp.Head_Before (Match.First_Marker));
         Temp := Temp.Tail_From (Match.Last_Marker);
         Match := RE.Match (Temp);
      end loop;

      return Result;
   end Split;

end Brackelib.Strings;
