UNIT NodeWork;

INTERFACE
USES
   WordTypeUnit;

TYPE
  Tree = ^NodeType;
  EndingNodePtr = ^EndingNode;
  EndingNode = RECORD
                  Ending: WordType;
                  Next: EndingNodePtr
                END;
            
  NodeType = RECORD
               Base: WordType;
               FirstEndingPtr: EndingNodePtr; 
               Count: INTEGER;
               LLink, RLink: Tree
             END;         

PROCEDURE Insert(VAR Ptr: Tree; VAR Word: WordType);
PROCEDURE InsertEnding(VAR FirstEndingPtr: EndingNodePtr; VAR Ending: WordType);
PROCEDURE PrintTree(VAR FOut: TEXT; VAR Ptr: Tree);
PROCEDURE DisposeMemory(VAR Ptr: Tree);
PROCEDURE DisposeEndings(VAR FirstEndingPtr: EndingNodePtr);

IMPLEMENTATION

PROCEDURE DisposeEndings(VAR FirstEndingPtr: EndingNodePtr);
VAR
  NewPtr: EndingNodePtr;
BEGIN {DisposeEndings}
  WHILE FirstEndingPtr <> NIL
  DO
    BEGIN
      NewPtr := FirstEndingPtr;
      DISPOSE(FirstEndingPtr);
      FirstEndingPtr := NewPtr^.Next    
    END;
  DISPOSE(NewPtr)  
END; {DisposeEndings}

PROCEDURE FindInsertionPoint(VAR Prev: EndingNodePtr; VAR Curr: EndingNodePtr; VAR NewPtr: EndingNodePtr);
VAR
  Found: BOOLEAN;
BEGIN {FindInsertPoint}
  Found := FALSE;
  WHILE (Curr <> NIL) AND (NOT Found)
  DO
    IF IsBigger(NewPtr^.Ending, Curr^.Ending)
    THEN
      BEGIN
        Prev := Curr;
        Curr := Curr^.Next
      END
    ELSE
      Found := TRUE    
END; {FindInsertPoint}

PROCEDURE WriteEndings(VAR FOut: TEXT; VAR FirstEndingPtr: EndingNodePtr);
VAR 
  NewPtr: EndingNodePtr;
BEGIN {WriteEndings}
  NewPtr := FirstEndingPtr;
  WHILE NewPtr <> NIL
  DO
    BEGIN
      WriteWord(FOut, NewPtr^.Ending);
      WRITE(FOut, ',');
      NewPtr := NewPtr^.Next
    END
END; {WriteEndings}

PROCEDURE InsertEnding(VAR FirstEndingPtr: EndingNodePtr; VAR Ending: WordType);
VAR
  NewPtr, Prev, Curr: EndingNodePtr;
BEGIN {InsertEnding}
  NEW(NewPtr);
  NewPtr^.Ending := Ending;
  Prev := NIL;
  Curr := FirstEndingPtr;
  FindInsertionPoint(Prev, Curr, NewPtr);
  IF (Curr <> NIL) AND (IsEquals(NewPtr^.Ending, Curr^.Ending))
  THEN
    DISPOSE(NewPtr)
  ELSE
    BEGIN
      NewPtr^.Next := Curr;
      IF Prev = NIL
      THEN 
        FirstEndingPtr := NewPtr
      ELSE
        Prev^.Next := NewPtr  
    END     
END; {InsertEnding} 
 
PROCEDURE Insert(VAR Ptr: Tree; VAR Word: WordType);
VAR
  Base: WordType;
  Ending: WordType;
BEGIN {Insert}
  SplitWord(Word, Base, Ending);
  IF Ptr = NIL
  THEN
    BEGIN 
      NEW(Ptr);
      Ptr^.Base := Base;
      Ptr^.FirstEndingPtr := NIL;
      InsertEnding(Ptr^.FirstEndingPtr, Ending);  
      Ptr^.Count := 1;
      Ptr^.LLink := NIL;
      Ptr^.RLink := NIL
    END
  ELSE
    IF IsBigger(Ptr^.Base, Base)
    THEN
      Insert(Ptr^.LLink, Word)   
    ELSE 
      IF IsEquals(Ptr^.Base, Base)
      THEN
        BEGIN
          Ptr^.Count := Ptr^.Count + 1;
          InsertEnding(Ptr^.FirstEndingPtr, Ending)
        END  
      ELSE   
        Insert(Ptr^.RLink, Word) 
END;  {Insert}

PROCEDURE PrintTree(VAR FOut: TEXT; VAR Ptr: Tree);
BEGIN {PrintTree}
  IF Ptr <> NIL
  THEN
    BEGIN
      PrintTree(FOut, Ptr^.LLink);
      WriteWord(FOut, Ptr^.Base);
      WRITE(FOut, ',');
      WriteEndings(FOut, Ptr^.FirstEndingPtr); 
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
      DisposeEndings(Ptr^.FirstEndingPtr);
      DISPOSE(Ptr)
    END
END; {DisposeMemory}

BEGIN
END.

