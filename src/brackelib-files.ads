with VSS.Strings;
with GNATCOLL.VFS;

package Brackelib.Files is
--  Copy and move operations.

   function Read_All_Text (Filename : GNATCOLL.VFS.Virtual_File)
      return VSS.Strings.Virtual_String;
   --  Returns the contents of the file.
   --  @param Filename The filename or path of the file to be read.
   --  @return Contents of file as a string.

   procedure Write_Text (Filename   : VSS.Strings.Virtual_String;
                         Text       : VSS.Strings.Virtual_String);
   --  Writes the Text to the file pointed to by Filename.
   --  The file is created if it does not exist already.
   --  @param Filename The filename or path of the file where the Text is going
   --    to be written to.
   --  @param Text The text to be written to the file. This will overwrite any
   --    existing content.

   procedure Append_Text (Filename  : VSS.Strings.Virtual_String;
                          Text      : VSS.Strings.Virtual_String);
   --  Appends the Text to the content of the file pointed to by Filename.
   --  @param Filename The filename or path of the file to be read.
   --  @param Text The text to be appended to the file.

   function Exists (Path : VSS.Strings.Virtual_String) return Boolean;
   --  Returns true if the path exists.
   --  @param Filepath The path.
   --  @return True if the path exists.

   function Delete_File (Filepath : VSS.Strings.Virtual_String) return Boolean;
   --  Removes file from the disk.
   --  @param Filepath The path of the file.
   --  @return Indicates whether the delete operation was successfull.

   function To_Virtual_String (Input : GNATCOLL.VFS.Filesystem_String)
      return VSS.Strings.Virtual_String;
   --  Convert Filesystem_String to Virtual_String.
   --  @param Input The Filesystem_String.
   --  @return The converted string.

   function Compose (Containing_Directory : VSS.Strings.Virtual_String := "";
                     Name : VSS.Strings.Virtual_String;
                     Extension : VSS.Strings.Virtual_String := "")
                     return VSS.Strings.Virtual_String;
   --  Composes a path.
   --  @param Containing_Directory The directory containing Name.
   --  @param Name The filename.
   --  @param Extension The extension of the file.
   --  @return The complete path of the file.

   function Compose (Containing_Directory : VSS.Strings.Virtual_String := "";
                     Name : VSS.Strings.Virtual_String;
                     Extension : VSS.Strings.Virtual_String := "")
                     return GNATCOLL.VFS.Filesystem_String;
   --  Composes a path.
   --  @param Containing_Directory The directory containing Name.
   --  @param Name The filename.
   --  @param Extension The extension of the file.
   --  @return The complete path of the file.

   function Copy_File (Source : VSS.Strings.Virtual_String;
                       Target : VSS.Strings.Virtual_String) return Boolean;
   --  Copy a file or directory.
   --  @param Source The filename or path of the source directory.
   --  @param Target The filename or path of the target directory.
   --  @return Indicates whether the delete operation was successfull.

   procedure Copy_Files (Source     : VSS.Strings.Virtual_String;
                         Target     : VSS.Strings.Virtual_String;
                         Pattern    : VSS.Strings.Virtual_String;
                         Overwrite  : Boolean := False;
                         Delete_Source_Files : Boolean := False);
   --  Copies all files at the Source which fullfill the Pattern to Target.
   --  @param Source The filename or path of the source directory
   --  @param Target The filename or path of the target directory
   --  @param Pattern The search pattern (e.g. *.ad* for all Ada files) that
   --    determines which files in Source are copied to Target
   --  @param Overwrite If True then any files in Target with the same name as
   --    those in Source, will be overwritten.
   --  @param Delete_Source_Files If True then any files in Source which
   --    fullfill the Pattern, are deleted after being copied to Target

   procedure Move_Files (Source     : VSS.Strings.Virtual_String;
                         Target     : VSS.Strings.Virtual_String;
                         Pattern    : VSS.Strings.Virtual_String;
                         Overwrite  : Boolean := False);
   --  Moves all files at the Source which fullfill the Pattern to Target.
   --  @param Source The filename or path of the source directory
   --  @param Target The filename or path of the target directory
   --  @param Pattern The search pattern (e.g. *.ad* for all Ada files) that
   --    determines which files in Source are copied to Target
   --  @param Overwrite If True then any files in Target with the same name as
   --    those in Source, will be overwritten.

end Brackelib.Files;