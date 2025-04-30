PROGRAM PrintEnvironment(INPUT, OUTPUT);
USES
  DOS;
VAR
  QueryString, Name: STRING;
  PosName, NameLength, NameEnd: INTEGER;
BEGIN
  WRITELN('Content-Type: text/plain');
  WRITELN;
  QueryString := GetEnv('QUERY_STRING');
  PosName := Pos('name=', QueryString) + 5;
  NameEnd := Pos('&', QueryString);
  IF NameEnd = 0
  THEN
    NameLength := 32000
  ELSE
    NameLength := NameEnd - PosName;
  Name := Copy(QueryString, PosName, NameLength);
  WRITELN(Name);
  WRITELN
END.
