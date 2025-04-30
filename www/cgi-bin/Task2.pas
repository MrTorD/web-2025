PROGRAM PrintEnvironment(INPUT, OUTPUT);
USES
  DOS;
VAR
  S: STRING;
BEGIN
  WRITELN('Content-Type: text/plain');
  WRITELN;
  S := GetEnv('QUERY_STRING');
  WRITELN(S);
  IF S = 'lanterns=1'
  THEN
    WRITELN('The British are coming by sea')
  ELSE
    IF S = 'lanterns=2'
    THEN
      WRITELN('The British are coming by land')
    ELSE
      WRITELN('Sarah didn''t say');
  WRITELN
END.
