PROGRAM WordsList(INPUT, OUTPUT);
USES
  WordTypeUnit, 
  NodeWork,
  FileWork;

CONST
  NodesMaxCount = 10000000000;          

PROCEDURE CountWords(VAR FIn: TEXT; VAR FOut: TEXT);
VAR
  Ch: CHAR;  
  Word: WordType; 
  F, TreeF, TempF: TEXT;
  Root: Tree;
  NodesCounter: INTEGER;     
BEGIN {CountWords}
  NodesCounter := 0;
  Root := NIL;
  REWRITE(F);
  WHILE NOT EOF(FIn)
  DO
    BEGIN
      WHILE NOT EOLN(FIn)
      DO
        IF FIn^ IN SupportableChars
        THEN
          BEGIN
            ReadWord(FIn, Word);
            Insert(Root, Word);
            NodesCounter := NodesCounter + 1;
            IF NodesCounter > NodesMaxCount
            THEN
              BEGIN
                RESET(F); 
                REWRITE(TempF); 
                REWRITE(TreeF);
                PrintTree(TreeF, Root);            
                Merge(TempF, F, TreeF);
                CopyFile(TempF, F);
                DisposeMemory(Root);
                Root := NIL;
                NodesCounter := 0
              END 
          END
        ELSE
          READ(FIn, Ch);
      READLN(FIn)    
    END;
  REWRITE(TreeF);  
  PrintTree(TreeF, Root);
  DisposeMemory(Root);
  Merge(TempF, F, TreeF);
  CopyFile(TempF, FOut);
  CopyFile(TempF, F);       
  CopyFormated(F, FOut)
END; {CountWords}      

BEGIN
  CountWords(INPUT, OUTPUT)
END. 
