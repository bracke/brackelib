with Ada.Calendar;            use Ada.Calendar;
with Ada.Calendar.Formatting; use Ada.Calendar.Formatting;

package body Brackelib.Datetime is

   function Now_ISO return String is
      Now : constant Time := Clock;
   begin
      return Image (Now);
   end Now_ISO;

end Brackelib.Datetime;
