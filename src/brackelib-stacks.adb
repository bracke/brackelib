package body Brackelib.Stacks is

  procedure Push (Self: in out Stack; Item : T) is
  begin
    Self.Container.Append (Item);
  end Push;

  procedure Clear (Self: in out Stack) is
  begin
    Self.Container.Clear;
  end Clear;

  function Top(Self: in Stack) return T is
  begin
    if Is_Empty (Self) then
      raise Stack_Empty;
    end if;

    return Last_Element (Self.Container);
  end Top;

  function Pop(Self: in out Stack) return T is

    Result: T;
  begin
    if Is_Empty (Self) then
      raise Stack_Empty;
    end if;

    Result := Last_Element (Self.Container);
    Delete_Last (Self.Container);

    return Result;
  end Pop;

  function Size(Self: Stack) return Integer is
  begin
    return Natural (Length (Self.Container));
  end Size;

  function Is_Empty(Self: Stack) return Boolean is
  begin
    return Size(Self) = 0;
  end Is_Empty;

end Brackelib.Stacks;