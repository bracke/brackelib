with Ada.Locales;           use Ada.Locales;
with Ada.Containers.Indefinite_Hashed_Maps;
with VSS.Strings; use VSS.Strings;
with Ada.Strings.Wide_Wide_Hash;

package Brackelib.Intl is
   --
   --  Reading language texts
   --
   --  This package provides functionality for handling and using language
   --    texts.
   --  It expects languagetexts to be specified in separate files in a
   --    simplified yaml format.
   --
   --  Each language file represents a specific language and is named with the
   --    languagecode for that language (e.g. eng.yaml).
   --  The language code is as specified in ISO/IEC 639-3:2007
   --    (https://iso639-3.sil.org/code_tables/639/data)
   --  and as described in the Rationale for Ada 2012:
   --    http://www.ada-auth.org/standards/12rat/html/Rat12-7-4.html
   --
   --  To start using intl, a variable of type Intl must be declared.
   --
   --     Language_Texts : Intl;
   --
   --  The location where the language files should be places is called
   --    Resource Location
   --  and should be defined by calling the Set_Resources_Location procedure.
   --
   --     Set_Resources_Location (Language_Texts, "path_to_my_app/resources");
   --
   --  The language to use, defaults to whatever is returned by the
   --    Ada.Locales.Language function.
   --  You can change this by calling Set_Language afterwards.
   --
   --     Set_Language (Language_Texts, "deu");
   --
   --  With the resource location and language set, you now look up
   --    languagetexts!
   --  Each text is identified by a token, a string which can be any text, but
   --    may not contain whitespace nor ":"
   --  and also not a "#" as that marks the start of a comment.
   --  Furthermore the token needs to unique. No other line in the same
   --    language file may have a token of that name.
   --  The lookup of tokens is case sensitive.
   --
   --  To lookup a particular language text with a given token you call the
   --    function T.
   --
   --     T (Language_Texts, "hello");
   --
   --  This will return the languagetext corresponding to the token "hello".
   --  The lookup will look in the file "path_to_my_app/resources/deu.yaml".
   --  If that file does not exist then it will look in
   --    "path_to_my_app/resources/eng.yaml".
   --  If that file does not exist either then the exception Resource_Not_Found
   --    is raised.
   --
   --  The lookup kan take parameters which are inserted into the language
   --    text.
   --  The parameters must be named in the language text.
   --
   --  The line in the languagetext:
   --
   --     hello: Hello {name1} and {name2}!
   --
   --  How it is read:
   --
   --     T (Language_Texts, "hello", "name1=Jasmine,name2=Eric");
   --
   --  The result:
   --
   --     Hello Jasmine and Eric!
   --

   type Intl is limited private;
   --  Type for main Intl data type.

   function T
     (E           : in out Intl;
      Token       : Virtual_String;
      Parameters  : Virtual_String := "") return Virtual_String;
   --  The T helper accepts a translation key and returns a translated string.
   --  @param E The intl element.
   --  @param Token The token which identifies the requested text.
   --  @param Parameters Values to be inserted into the languagetext.
   --  @return The languagetext matching the token.

   --  The exception is raised when the language resource file can not be
   --  found at the Resources_Location.
   Resource_Not_Found : exception;

   procedure Set_Resources_Location
     (E : in out Intl;
     Resources_Location : Virtual_String);
   --  Change resources location and reload tokens.
   --  @param E The intl element.
   --  @param Resources_Location  The path to the folder containing the
   --    language resources.
   --  @exception Resource_Not_Found Raised if language resource can not be
   --    found in location.

   function Get_Resources_Location (E : Intl) return Virtual_String;
   --  Get resources location used by intl.
   --  @param E The intl element.
   --  @return The resources location.

   procedure Set_Language (E : in out Intl;
                           Language : Language_Code);
   --  Change language and reload tokens.
   --  @param E The intl element.
   --  @param Language Language_Code of the language to be set.
   --  @exception Resource_Not_Found Raised if language resource can not be
   --    found.

   function Get_Language (E : Intl) return Language_Code;
   --  Get language currently used by intl.
   --  @param E The intl element.
   --  @return Language_Code of the current language.

private

   package Template_Values_Map is new Ada.Containers.Indefinite_Hashed_Maps
     (Key_Type       => Wide_Wide_String,
      Element_Type   => Virtual_String,
      Hash           => Ada.Strings.Wide_Wide_Hash,
      Equivalent_Keys => "="
      );

   type Intl is record
      Tokens_Loaded      : Boolean := False;
      Tokens             : Template_Values_Map.Map;
      Resources_Location : Virtual_String := "";
      Language           : Language_Code := Ada.Locales.Language;
   end record;

end Brackelib.Intl;
