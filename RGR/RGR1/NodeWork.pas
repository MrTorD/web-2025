UNIT NodeWork;

INTERFACE
USES
   WordTypeUnit;

TYPE
  NodePtr = ^Node;
  Node = RECORD
           Word: WordType;
           Count: INTEGER;
           Next: NodePtr;
         END; 
VAR 
  FirstPtr: NodePtr;                

PROCEDURE Insert(VAR Word: WordType);
PROCEDURE FindInsertionPoint(VAR Prev: NodePtr; VAR Curr: NodePtr; VAR NewPtr: NodePtr);
PROCEDURE Print(VAR FOut: TEXT);
PROCEDURE DisposeMemory();

IMPLEMENTATION
   
PROCEDURE Insert(VAR Word: WordType);
VAR
  Curr, Prev, NewPtr: NodePtr;
BEGIN {Insert}
  NEW(NewPtr);
  NewPtr^.Word := Word;
  Prev := NIL;
  Curr := FirstPtr;
  FindInsertionPoint(Prev, Curr, NewPtr);
  IF (Curr <> NIL) AND IsEquals(NewPtr^.Word, Curr^.Word)
  THEN
    BEGIN
      Curr^.Count := Curr^.Count + 1;
      DISPOSE(NewPtr)
    END  
  ELSE
    BEGIN
       NewPtr^.Next := Curr;
       NewPtr^.Count := 1;
       IF Prev = NIL
       THEN
         FirstPtr := NewPtr
       ELSE
         Prev^.Next := NewPtr
    END      
END; {Insert}

PROCEDURE FindInsertionPoint(VAR Prev: NodePtr; VAR Curr: NodePtr; VAR NewPtr: NodePtr);
VAR
  Found: BOOLEAN;
BEGIN {FindInsertPoint}
  Found := FALSE;
  WHILE (Curr <> NIL) AND (NOT Found)
  DO
    IF IsBigger(NewPtr^.Word, Curr^.Word)
    THEN
      BEGIN
        Prev := Curr;
        Curr := Curr^.Next
      END
    ELSE
      Found := TRUE    
END; {FindInsertPoint}

PROCEDURE Print(VAR FOut: TEXT);
VAR
  NewPtr: NodePtr;
BEGIN {Print}
  NewPtr := FirstPtr;
  WHILE NewPtr <> NIL
  DO
    BEGIN
      WriteWord(FOut, NewPtr^.Word);
      WRITE(FOut, ':', NewPtr^.Count);
      WRITELN(FOut);
      NewPtr := NewPtr^.Next
    END;
  DisposeMemory;  
END; {Print}

PROCEDURE DisposeMemory;
VAR
  TempPtr: NodePtr;
BEGIN {DisposeMemory}
  WHILE FirstPtr <> NIL
  DO
    BEGIN
      TempPtr := FirstPtr^.Next;
      DISPOSE(FirstPtr);
      FirstPtr := TempPtr
    END
END; {DisposeMemory}

BEGIN
  FirstPtr := NIL   
END.
