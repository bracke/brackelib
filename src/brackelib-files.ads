package Brackelib.Files is
--  @summary
--  File related helper functions

   procedure Copy_Files (Source : in String; Target : in String; Pattern : in String; Overwrite : in Boolean := False; Delete_Source_Files : in Boolean := False);
   --  Copies all files at the Source which fullfill the Pattern to Target.
   --  @param Source The filename or path of the source directory
   --  @param Target The filename or path of the target directory
   --  @param Pattern The search pattern (e.g. *.ad* for all Ada files) that determines which files in Source are copied to Target
   --  @param Overwrite If True then any files in Target with the same name as those in Source, will be overwritten.
   --  @param Delete_Source_Files If True then any files in Source which fullfill the Pattern, are deleted after being copied to Target

   procedure Move_Files (Source : in String; Target : in String; Pattern : in String; Overwrite : in Boolean := False);
   --  Moves all files at the Source which fullfill the Pattern to Target.
   --  @param Source The filename or path of the source directory
   --  @param Target The filename or path of the target directory
   --  @param Pattern The search pattern (e.g. *.ad* for all Ada files) that determines which files in Source are copied to Target
   --  @param Overwrite If True then any files in Target with the same name as those in Source, will be overwritten.

end Brackelib.Files;