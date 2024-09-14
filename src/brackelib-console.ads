package Brackelib.Console is
--  @summary
--  Console related helper functions

   function Ask (Request : in String; First : in String := "Yes"; Second : in String := "No") return Boolean;
   --  Ask the user a Yes/No question and get the answer as a Boolean
   --  @param Request The question to be asked
   --  @param First The text to be displayed for the True value
   --  @param Second The text to be displayed for the False value
   --  @return The answer as a Boolean

   function Ask (Request : in String) return String;
   --  Ask the user a question and gets the answer as a String
   --  @param Request The question to be asked
   --  @return The answer as a String

   function Run (Command : in String) return Boolean;
   --  Runs a Command with Arguments and returns the status as an Integer
   --  @param Command The command to be run
   --  @param Arguments The arguments for the command to be run
   --  @return Whether the command was run successfully.

private
end Brackelib.Console;