PROGRAM TestMerge(INPUT, OUTPUT);
USES
  WordTypeUnit,
  NodeWork;

VAR
  F1, F2, F3: TEXT;

PROCEDURE ReadLine(VAR F: TEXT; VAR Word: WordType; VAR Count: INTEGER);
VAR
  Ch: CHAR;
BEGIN {ReadLine}
  ReadWord(F, Word);
  READ(F, Ch);
  READ(F, Count);
  READLN(F)
END; {ReadLine}

PROCEDURE WriteLine(VAR F: TEXT; VAR Word: WordType; VAR Count: INTEGER);
BEGIN {WriteLine}
  WriteWord(F, Word);
  WRITELN(F, ':', Count)
END; {WriteLine}
  
PROCEDURE Merge(VAR F1: TEXT; VAR F2: TEXT; VAR F3: TEXT);
VAR 
  Word2, Word3: WordType;
  Count2, Count3: INTEGER; 
  IsEmpty2, IsEmpty3: BOOLEAN;
BEGIN {Merge}
  RESET(F2);
  RESET(F3);
  REWRITE(F1);
  IsEmpty2 := TRUE;
  IsEmpty3 := TRUE;
  IF NOT EOF(F2)
  THEN 
    BEGIN
      ReadLine(F2, Word2, Count2);
      IsEmpty2 := FALSE
    END;  
  IF NOT EOF(F3)
  THEN 
    BEGIN
      ReadLine(F3, Word3, Count3);
      IsEmpty3 := FALSE;
    END;  
  WHILE (NOT (EOF(F2))) AND (NOT (EOF(F3)))
  DO
    BEGIN
      WRITELN('Main while is here');
      IF IsBigger(Word3, Word2)
      THEN 
        BEGIN 
          WriteLine(F1, Word2, Count2);
          ReadLine(F2, Word2, Count2)
        END  
      ELSE
        BEGIN
          IF IsEquals(Word3, Word2)
          THEN
            BEGIN
              Count2 := Count2 + Count3;
              WriteLine(F1, Word2, Count2);
              ReadLine(F2, Word2, Count2);
              ReadLine(F3, Word3, Count3)  
            END
          ELSE 
            BEGIN   
              WriteLine(F1, Word3, Count3);
              ReadLine(F3, Word3, Count3)
            END  
        END
    END;
  IF NOT IsEmpty2 AND NOT IsEmpty3
  THEN
    BEGIN   
      WHILE NOT EOF(F2) AND NOT (IsBigger(Word2, Word3)) AND (IsEquals(Word2, Word3))
      DO
        BEGIN
          WriteLine(F1, Word2, Count2);
          ReadLine(F2, Word2, Count2)
        END;
      IF IsBigger(Word2, Word3)
      THEN                   
        WriteLine(F1, Word3, Count3) 
      ELSE
        IF IsEquals(Word3, Word2)
        THEN
          BEGIN 
            Count3 := Count3 + Count2;
            WriteLine(F1, Word3, Count3)
          END;    
      WHILE NOT EOF(F2)
      DO
        BEGIN
          WriteLine(F1, Word2, Count2);
          ReadLine(F2, Word2, Count2)
        END;
  
      WHILE NOT EOF(F3) AND NOT (IsBigger(Word3, Word2)) AND (IsEquals(Word3, Word2))
      DO
        BEGIN
          WriteLine(F1, Word3, Count3);
          ReadLine(F3, Word3, Count3)
        END;
      IF IsBigger(Word3, Word2)
      THEN                   
        WriteLine(F1, Word2, Count2) 
      ELSE
        IF IsEquals(Word2, Word3)
        THEN
          BEGIN 
            Count2 := Count2 + Count3;
            WriteLine(F1, Word2, Count2)
          END;    
        WHILE NOT EOF(F3)
        DO
          BEGIN
            WriteLine(F1, Word3, Count3);
            ReadLine(F3, Word3, Count3)
          END
    END  
  ELSE
    IF NOT IsEmpty2
    THEN
      BEGIN
        WriteLine(F1, Word2, Count2);
        WHILE NOT EOF(F2)
        DO
          BEGIN 
            ReadLine(F2, Word2, Count2);
            WriteLine(F1, Word2, Count2)
          END      
      END
    ELSE
      IF NOT IsEmpty3
      THEN
        BEGIN
          WriteLine(F1, Word3, Count3);
          WHILE NOT EOF(F3)
          DO
            BEGIN
              ReadLine(F3, Word3, Count3);
              WriteLine(F1, Word3, Count3)
            END  
        END                               
END;

BEGIN
  ASSIGN(F1, 'F1.txt');
  ASSIGN(F2, 'F2.txt');
  ASSIGN(F3, 'F3.txt');
  Merge(F1, F2, F3)
END.
