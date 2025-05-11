PROGRAM TestUnit(INPUT, OUTPUT);
USES
  WordTypeUnit;
VAR
  Word1, Word2: WordType;
  Ch: CHAR; 
  I: INTEGER;   
BEGIN {WordsList}
  ReadWord(INPUT, Word1);
  READ(Ch);
  ReadWord(INPUT, Word2);
  WriteWord(OUTPUT, Word1);
  WRITELN;
  WriteWord(OUTPUT, Word2);
  WRITELN;
  IF IsBigger(Word1, Word2)
  THEN 
    WRITELN('Is bigger');
  IF IsEquals(Word1, Word2)
  THEN 
    WRITELN('Is equals');   
  {I := 0;  
  WHILE I < 256
  DO
    BEGIN
      WRITELN(chr(I), ' - ', I);
      I := I + 1
    END;
  {168 - '¨'}
  {184 - '¸'}
   WRITELN(Chr(168));
   WRITELN(chr(184));
   WRITELN(Chr(255)) 
END. {WordsList}             
