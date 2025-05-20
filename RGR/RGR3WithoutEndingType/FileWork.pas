UNIT FileWork;

INTERFACE
USES
  WordTypeUnit,
  NodeWork;  

PROCEDURE CopyFile(VAR FIn: TEXT; VAR FOut: TEXT);
PROCEDURE CopyFormated(VAR FIn: TEXT; VAR FOut: TEXT);
PROCEDURE ReadLine(VAR F: TEXT; VAR Base: WordType; VAR FirstEndingPtr: EndingNodePtr; VAR Count: INTEGER);
PROCEDURE WriteLine(VAR F: TEXT; VAR Base: WordType; VAR FirstEndingPtr: EndingNodePtr; VAR Count: INTEGER);
PROCEDURE Merge(VAR F1: TEXT; VAR F2: TEXT; VAR F3: TEXT);

IMPLEMENTATION

PROCEDURE CopyFormated(VAR FIn: TEXT; VAR FOut: TEXT);
VAR
  Base: WordType;
  Ending: WordType;
  Count: INTEGER;
  Ch: CHAR;
BEGIN {CopyFormated}
  RESET(FIn);
  REWRITE(FOut);
  WHILE NOT EOF(FIn)
  DO
    BEGIN
      ReadWord(FIn, Base);
      READ(FIn, Ch);
      WHILE FIn^ IN SupportableChars + [NullEndingChar]
      DO
        BEGIN
          ReadWord(FIn, Ending);
          WriteWord(FOut, Base);
          IF Ending[0] <> NullEndingChar
          THEN
            WriteWord(FOut, Ending);
          READ(FIn, Ch);
          IF FIn^ <> WordAndCountSeparator
          THEN
            WRITE(FOut, BaseAndEndingsSeparator)  
        END;
      READ(FIn, Ch);
      WRITE(FOut, Ch);
      READ(FIn, Count);
      WRITELN(FOut, Count);
      READLN(FIn)    
    END
END; {CopyFormated}  

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

PROCEDURE ReadLine(VAR F: TEXT; VAR Base: WordType; VAR FirstEndingPtr: EndingNodePtr; VAR Count: INTEGER);
VAR
  Ch: CHAR;
  Ending: WordType;
BEGIN {ReadLine}
  ReadWord(F, Base);
  FirstEndingPtr := NIL; 
  WHILE F^ = ','
  DO
    BEGIN
      READ(F, Ch); 
      IF F^ <> ':'
      THEN
        BEGIN
          ReadWord(F, Ending);
          InsertEnding(FirstEndingPtr, Ending) 
        END
    END;
  READ(F, Ch);
  READ(F, Count);
  READLN(F)
END; {ReadLine}

PROCEDURE WriteLine(VAR F: TEXT; VAR Base: WordType; VAR FirstEndingPtr: EndingNodePtr; VAR Count: INTEGER);
VAR
  NewPtr: EndingNodePtr;
BEGIN {WriteLine}
  WriteWord(F, Base);
  WRITE(F, ',');
  NewPtr := FirstEndingPtr;
  WHILE NewPtr <> NIL
  DO
    BEGIN
      WriteWord(F, NewPtr^.Ending);
      WRITE(F, ',');
      NewPtr := NewPtr^.Next
    END;
  WRITELN(F, ':', Count);
  DisposeEndings(FirstEndingPtr)
END; {WriteLine}

PROCEDURE MergeEndings(VAR FirstEndingPtr1: EndingNodePtr; VAR FirstEndingPtr2: EndingNodePtr);
VAR 
  NewPtr: EndingNodePtr;
BEGIN {MergeEndings}
  NewPtr := FirstEndingPtr2;
  WHILE NewPtr <> NIL
  DO
    BEGIN
      InsertEnding(FirstEndingPtr1, NewPtr^.Ending);
      NewPtr := NewPtr^.Next
    END;
  DisposeEndings(FirstEndingPtr2)  
END; {MergeEndings} 

PROCEDURE Merge(VAR F1: TEXT; VAR F2: TEXT; VAR F3: TEXT);
VAR 
  Base2, Base3: WordType;
  FirstEndingPtr2, FirstEndingPtr3: EndingNodePtr;
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
    ReadLine(F2, Base2, FirstEndingPtr2, Count2);
  IF NOT IsEmpty3
  THEN
    ReadLine(F3, Base3, FirstEndingPtr3, Count3);  
  IF NOT IsEmpty2 AND NOT IsEmpty3
  THEN
    BEGIN  
      WHILE (NOT (EOF(F2))) AND (NOT (EOF(F3)))
      DO
        BEGIN
          IF IsBigger(Base2, Base3)
          THEN
            BEGIN
              WriteLine(F1, Base3, FirstEndingPtr3, Count3);
              ReadLine(F3, Base3, FirstEndingPtr3, Count3)
            END
          ELSE
            IF IsEquals(Base2, Base3)
            THEN
              BEGIN
                Count2 := Count2 + Count3;
                MergeEndings(FirstEndingPtr2, FirstEndingPtr3);
                WriteLine(F1, Base2, FirstEndingPtr2, Count2);
                ReadLine(F2, Base2, FirstEndingPtr2, Count2);
                ReadLine(F3, Base3, FirstEndingPtr3, Count3)
              END  
            ELSE
              BEGIN
                WriteLine(F1, Base2, FirstEndingPtr2, Count2);
                ReadLine(F2, Base2, FirstEndingPtr2, Count2)
              END  
        END;
      IF NOT EOF(F2)
      THEN
        BEGIN  
          WHILE NOT EOF(F2) AND (NOT IsBigger(Base2, Base3)) AND (NOT IsEquals(Base3, Base2))
          DO
            BEGIN
              WriteLine(F1, Base2, FirstEndingPtr2, Count2);
              ReadLine(F2, Base2, FirstEndingPtr2, Count2)
            END;
          IF IsBigger(Base2, Base3) OR IsEquals(Base2, Base3)
          THEN
            BEGIN
              IsUsed3 := TRUE;
              IF IsBigger(Base2, Base3)
              THEN
                WriteLine(F1, Base3, FirstEndingPtr3, Count3)
              ELSE
                BEGIN
                  Count2 := Count2 + Count3;
                  MergeEndings(FirstEndingPtr2, FirstEndingPtr3)
                END  
            END;    
          WHILE NOT EOF(F2)
          DO
            BEGIN
              WriteLine(F1, Base2, FirstEndingPtr2, Count2);
              ReadLine(F2, Base2, FirstEndingPtr2, Count2)    
            END  
        END;
      IF NOT EOF(F3)
      THEN
        BEGIN  
          WHILE NOT EOF(F3) AND (NOT IsBigger(Base3, Base2)) AND (NOT IsEquals(Base2, Base3))
          DO
            BEGIN
              WriteLine(F1, Base3, FirstEndingPtr3, Count3);
              ReadLine(F3, Base3, FirstEndingPtr3, Count3)
            END;
          IF IsBigger(Base3, Base2) OR IsEquals(Base3, Base2)
          THEN
            BEGIN
              IsUsed2 := TRUE;
              IF IsBigger(Base3, Base2)
              THEN
                WriteLine(F1, Base2, FirstEndingPtr2, Count2)
              ELSE
                BEGIN
                  MergeEndings(FirstEndingPtr3, FirstEndingPtr2);
                  Count3 := Count3 + Count2
                END 
            END;    
          WHILE NOT EOF(F3)
          DO
            BEGIN
              WriteLine(F1, Base3, FirstEndingPtr3, Count3);
              ReadLine(F3, Base3, FirstEndingPtr3, Count3)    
            END  
        END;
      IF NOT IsUsed2 AND NOT IsUsed3
      THEN
        IF IsBigger(Base2, Base3)
        THEN
          BEGIN
            WriteLine(F1, Base3, FirstEndingPtr3, Count3);
            WriteLine(F1, Base2, FirstEndingPtr2, Count2)
          END  
        ELSE
          IF IsEquals(Base2, Base3)
          THEN
            BEGIN
              Count2 := Count2 + Count3;
              MergeEndings(FirstEndingPtr2, FirstEndingPtr3);
              WriteLine(F1, Base2, FirstEndingPtr2, Count2)
            END
          ELSE
            BEGIN
              WriteLine(F1, Base2, FirstEndingPtr2, Count2);
              WriteLine(F1, Base3, FirstEndingPtr3, Count3)
            END     
      ELSE
        IF IsUsed2
        THEN
          WriteLine(F1, Base3, FirstEndingPtr3, Count3)
        ELSE
          IF IsUsed3
          THEN
            WriteLine(F1, Base2, FirstEndingPtr2, Count2)
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
