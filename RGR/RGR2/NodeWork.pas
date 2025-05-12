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

IMPLEMENTATION
   
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

BEGIN
END.

