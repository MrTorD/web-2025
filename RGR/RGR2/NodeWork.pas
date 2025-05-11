UNIT NodeWork;

INTERFACE
USES
   WordTypeUnit;

TYPE
  Tree = ^NodeType;
  NodeType = RECORD
           Word: WordType;
           Count: INTEGER;
           LLink, RLink: Tree
         END;         

PROCEDURE Insert(VAR Ptr: Tree; VAR Word: WordType);
PROCEDURE PrintTree(VAR FOut: TEXT; VAR Ptr: Tree);
PROCEDURE DisposeMemory(VAR Ptr: Tree);
PROCEDURE Merge(VAR F1: TEXT; VAR F2: TEXT; VAR F3: TEXT);
PROCEDURE CopyFile(VAR FIn: TEXT; VAR FOut: TEXT);

IMPLEMENTATION

PROCEDURE CopyFile(VAR FIn: TEXT; VAR FOut: TEXT);
VAR
  Ch: CHAR;
BEGIN {CopyFile}
  RESET(FIn);
  REWRITE(FOut);
  WHILE NOT EOF(FIn)
  DO
    BEGIN
      WHILE NOT EOLN(FIn)
      DO
        BEGIN
          READ(FIn, Ch);
          WRITE(FOut, Ch)
        END;
      READLN(FIn);
      WRITELN(FOut)    
    END
END; {CopyFile}
   
PROCEDURE Insert(VAR Ptr: Tree; VAR Word: WordType);
BEGIN {Insert}
  IF Ptr = NIL
  THEN
    BEGIN 
      NEW(Ptr);
      Ptr^.Word := Word;
      Ptr^.Count := 1;
      Ptr^.LLink := NIL;
      Ptr^.RLink := NIL
    END
  ELSE
    IF IsBigger(Ptr^.Word, Word)
    THEN
      Insert(Ptr^.LLink, Word)   
    ELSE 
      IF IsEquals(Ptr^.Word, Word)
      THEN
        Ptr^.Count := Ptr^.Count + 1
      ELSE   
        Insert(Ptr^.RLink, Word) 
END;  {Insert}

PROCEDURE PrintTree(VAR FOut: TEXT; VAR Ptr: Tree);
BEGIN {PrintTree}
  IF Ptr <> NIL
  THEN
    BEGIN
      PrintTree(FOut, Ptr^.LLink);
      WriteWord(FOut, Ptr^.Word);
      WRITELN(FOut, ':', Ptr^.Count);
      PrintTree(FOut, Ptr^.RLink)
    END
END;  {PrintTree}

PROCEDURE DisposeMemory(VAR Ptr: Tree);
BEGIN {DisposeMemory}
  IF Ptr <> NIL
  THEN
    BEGIN
      DisposeMemory(Ptr^.LLink);
      DisposeMemory(Ptr^.RLink);
      DISPOSE(Ptr)
    END
END; {DisposeMemory}

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
  IsEmpty2, IsEmpty3, IsUsed2, IsUsed3: BOOLEAN;
BEGIN {Merge}
  RESET(F2);
  RESET(F3);
  REWRITE(F1);
  IsEmpty2 := EOF(F2);
  IsEmpty3 := EOF(F3);
  IsUsed2 := FALSE;
  IsUsed3 := FALSE;
  IF NOT IsEmpty2
  THEN
    ReadLine(F2, Word2, Count2);
  IF NOT IsEmpty3
  THEN
    ReadLine(F3, Word3, Count3);  
  IF NOT IsEmpty2 AND NOT IsEmpty3
  THEN
    BEGIN  
      WHILE (NOT (EOF(F2))) AND (NOT (EOF(F3)))
      DO
        BEGIN
          IF IsBigger(Word2, Word3)
          THEN
            BEGIN
              WriteLine(F1, Word3, Count3);
              ReadLine(F3, Word3, Count3)
            END
          ELSE
            IF IsEquals(Word2, Word3)
            THEN
              BEGIN
                Count2 := Count2 + Count3;
                WriteLine(F1, Word2, Count2);
                ReadLine(F2, Word2, Count2);
                ReadLine(F3, Word3, Count3)
              END  
            ELSE
              BEGIN
                WriteLine(F1, Word2, Count2);
                ReadLine(F2, Word2, Count2)
              END  
        END;
      IF NOT EOF(F2)
      THEN
        BEGIN  
          WHILE NOT EOF(F2) AND (NOT IsBigger(Word2, Word3)) AND (NOT IsEquals(Word3, Word2))
          DO
            BEGIN
              WriteLine(F1, Word2, Count2);
              ReadLine(F2, Word2, Count2)
            END;
          IF IsBigger(Word2, Word3) OR IsEquals(Word2, Word3)
          THEN
            BEGIN
              IsUsed3 := TRUE;
              IF IsBigger(Word2, Word3)
              THEN
                WriteLine(F1, Word3, Count3)
              ELSE
                Count2 := Count2 + Count3
            END;    
          WHILE NOT EOF(F2)
          DO
            BEGIN
              WriteLine(F1, Word2, Count2);
              ReadLine(F2, Word2, Count2)    
            END  
        END;
      IF NOT EOF(F3)
      THEN
        BEGIN  
          WHILE NOT EOF(F3) AND (NOT IsBigger(Word3, Word2)) AND (NOT IsEquals(Word2, Word3))
          DO
            BEGIN
              WriteLine(F1, Word3, Count3);
              ReadLine(F3, Word3, Count3)
            END;
          IF IsBigger(Word3, Word2) OR IsEquals(Word3, Word2)
          THEN
            BEGIN
              IsUsed2 := TRUE;
              IF IsBigger(Word3, Word2)
              THEN
                WriteLine(F1, Word2, Count2)
              ELSE
                Count3 := Count3 + Count2; 
            END;    
          WHILE NOT EOF(F3)
          DO
            BEGIN
              WriteLine(F1, Word3, Count3);
              ReadLine(F3, Word3, Count3)    
            END  
        END;
      IF NOT IsUsed2 AND NOT IsUsed3
      THEN
        IF IsBigger(Word2, Word3)
        THEN
          BEGIN
            WriteLine(F1, Word3, Count3);
            WriteLine(F1, Word2, Count2)
          END  
        ELSE
          IF IsEquals(Word2, Word3)
          THEN
            BEGIN
              Count2 := Count2 + Count3;
              WriteLine(F1, Word2, Count2)
            END
          ELSE
            BEGIN
              WriteLine(F1, Word2, Count2);
              WriteLine(F1, Word3, Count3)
            END     
      ELSE
        IF IsUsed2
        THEN
          WriteLine(F1, Word3, Count3)
        ELSE
          IF IsUsed3
          THEN
            WriteLine(F1, Word2, Count2)
    END                                 
  ELSE
    IF IsEmpty2
    THEN
      BEGIN
        RESET(F3);
        CopyFile(F3, F1)
      END
    ELSE
      IF IsEmpty3
      THEN
        BEGIN
          RESET(F2);
          CopyFile(F2, F1)
        END            
END; {Merge}

BEGIN
END.

