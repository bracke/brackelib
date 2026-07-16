with Ada.Text_IO.Text_Streams;

package Brackelib.Console is
--  Functionality to query user at commandline and execute cli commands.
   use Ada.Text_IO.Text_Streams;

   function Ask (Request : String;
                 First   : String := "Yes";
                 Second  : String := "No") return Boolean;
   --  Ask the user a Yes/No question and get the answer as a Boolean.
   --  @param Request The question to be asked
   --  @param First The text to be displayed for the True value
   --  @param Second The text to be displayed for the False value
   --  @return The answer as a Boolean

   function Ask (Request : String) return String;
   --  Ask the user a question and gets the answer as a String.
   --  @param Request The question to be asked
   --  @return The answer as a String

   function Run (Command : String) return Boolean;
   --  Runs a Command with Arguments and returns the status as an Integer.
   --  @param Command The command to be run
   --  @param Arguments The arguments for the command to be run
   --  @return Whether the command was run successfully.

   procedure Message (Stream  : Stream_Access;
                      Message : String);
   --  Write message to stream with linefeed before and after.
   --  @param Stream The stream the message will be written to
   --  @param Message The message which is written to the stream

   procedure Error_Message (Stream  : Stream_Access;
                            Message : String);
   --  Write message in red color to stream with linefeed before and after.
   --  @param Stream The stream the message will be written to
   --  @param Message The message which is written to the stream

   procedure Success_Message (Stream   : Stream_Access;
                              Message  : String);
   --  Write success message to stream with linefeed after.
   --  @param Stream The stream the message will be written to
   --  @param Message The message which is written to the stream

private
end Brackelib.Console;