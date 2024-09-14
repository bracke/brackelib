# brackelib
![Build](https://github.com/bracke/brackelib/actions/workflows/ada.yml/badge.svg)
![Tests](https://github.com/bracke/brackelib/actions/workflows/unit-tests.yml/badge.svg)
[![Alire](https://img.shields.io/endpoint?url=https://alire.ada.dev/badges/brackelib.json)](https://alire.ada.dev/crates/brackelib.html)

Ada library which contains various utility packages. Mainly related to console and file and string operations.

- Console
  - Ask: Ask the user a Yes/No question and get the answer as a Boolean.
  - Ask: Ask the user a question and gets the answer as a String.
  - Run: Run a Command with Arguments and returns the status as an Integer.
- Files
  - Copy_Files: Copy all files at the Source which fullfill the Pattern to Target.
  - Move_Files: Moves all files at the Source which fullfill the Pattern to Target.
- Strings
  - Is_In: Returns whether all characters of a text are in a set.
  - Starts_With: Returns whether the Text starts with a Pattern.
  - Read_All_Text: Returns the contents of the file.
  - Write_Text: Writes the Text to the file pointed to by Filename.
  - Append_Text: Appends the Text to the content of the file pointed to by Filename.
  - Create_Textfile: Creates a new file with the name or path Filename and Text as content.
