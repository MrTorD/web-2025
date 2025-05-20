UNIT NodeWork;

INTERFACE
USES
   WordTypeUnit;

TYPE
  Tree = ^NodeType;
  EndingNodePtr = ^EndingNode;
  EndingNode = RECORD
                  Ending: EndingType;
                  Right, Left: EndingNodePtr
                END;
            
  NodeType = RECORD
               Base: WordType;
               RootEndingsTree: EndingNodePtr; 
               Count: INTEGER;
               LLink, RLink: Tree
             END;         

PROCEDURE Insert(VAR Ptr: Tree; VAR Word: WordType);
PROCEDURE InsertEnding(VAR Ptr: EndingNodePtr; VAR Ending: EndingType);
PROCEDURE PrintTree(VAR FOut: TEXT; VAR Ptr: Tree);
PROCEDURE DisposeMemory(VAR Ptr: Tree);

IMPLEMENTATION

PROCEDURE InsertEnding(VAR Ptr: EndingNodePtr; VAR Ending: EndingType);
VAR
  NewPtr: EndingNodePtr;
BEGIN {InsertEnding}
  IF Ptr = NIL
  THEN
    BEGIN
      NEW(Ptr);
      Ptr^.Ending := Ending;
      Ptr^.Left := NIL;
      Ptr^.Right := NIL
    END    
  ELSE
    IF IsBiggerEnding(Ptr^.Ending, Ending)
    THEN
      InsertEnding(Ptr^.Left, Ending)
    ELSE
      IF NOT IsEqualsEnding(Ptr^.Ending, Ending) 
      THEN
        InsertEnding(Ptr^.Right, Ending)  
END; {InsertEnding} 

PROCEDURE WriteEndings(VAR FOut: TEXT; VAR Ptr: EndingNodePtr);
BEGIN {WriteEndings}
  IF Ptr <> NIL
  THEN
    BEGIN
      WriteEndings(FOut, Ptr^.Left);
      WriteEnding(FOut, Ptr^.Ending);
      WRITE(FOut, ',');
      WriteEndings(FOut, Ptr^.Right)
    END 
END; {WriteEndings}
 
PROCEDURE Insert(VAR Ptr: Tree; VAR Word: WordType);
VAR
  Base: WordType;
  Ending: EndingType;
BEGIN {Insert}
  SplitWord(Word, Base, Ending);
  IF Ptr = NIL
  THEN
    BEGIN 
      NEW(Ptr);
      Ptr^.Base := Base;
      Ptr^.RootEndingsTree := NIL;
      IF Ending <> NullEnding
      THEN
        InsertEnding(Ptr^.RootEndingsTree, Ending);  
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
          InsertEnding(Ptr^.RootEndingsTree, Ending)
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
      WRITE(FOUT, ',');
      WriteEndings(FOut, Ptr^.RootEndingsTree); 
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

