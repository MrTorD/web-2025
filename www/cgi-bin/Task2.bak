PROGRAM PrintEnvironment(INPUT, OUTPUT);
USES
  DOS;
FUNCTION GetQueryStringParameter(KEY: STRING): STRING;
VAR
  QueryString, Parameter: STRING;
  PosParameter, ParameterLength, ParameterEnd: INTEGER;
BEGIN
  QueryString := GetEnv('QUERY_STRING');
  IF Pos(KEY, QueryString) = 0
  THEN
    Exit('')
  ELSE
  PosParameter := Pos(KEY, QueryString);
  ParameterEnd := Pos('&', QueryString);
  WHILE ParameterEnd < PosParameter
  DO
    BEGIN
      Delete(QueryString, ParameterEnd, 1);
      Insert('$', QueryString, ParameterEnd);
      ParameterEnd := Pos('&', QueryString);
      IF ParameterEnd = 0
      THEN
        ParameterEnd := ParameterEnd + 1
    END;
  IF ParameterEnd = 0
  THEN
    ParameterLength := 32000
  ELSE
    ParameterLength := ParameterEnd - (PosParameter + Length(KEY) + 1);
  Parameter := Copy(QueryString, PosParameter + Length(KEY) + 1, ParameterLength);
  Exit(Parameter)
END;

BEGIN
  WRITELN('Content-Type: text/plain');
  WRITELN;
  WRITELN('First Name: ', GetQueryStringParameter('first_name'));
  WRITELN('Last Name: ', GetQueryStringParameter('last_name'));
  WRITELN('Age: ', GetQueryStringParameter('age'));
  WRITELN
END.
