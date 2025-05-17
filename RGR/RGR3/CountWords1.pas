PROGRAM WordsList(INPUT, OUTPUT);
USES
  WordTypeUnit, 
  NodeWork;      

PROCEDURE CountWords(VAR FIn: TEXT; VAR FOut: TEXT);
VAR
  Ch: CHAR;  
  Word: WordType;      
BEGIN {CountWords}
  WHILE NOT EOF(FIn)
  DO
    BEGIN
      WHILE NOT EOLN(FIn)
      DO
        IF FIn^ IN SupportableChars
        THEN
          BEGIN
            ReadWord(FIn, Word);
            Insert(Word)
          END
        ELSE
          READ(FIn, Ch);
      READLN(FIn)    
    END; 
  Print(FOut) 
END; {CountWords}      

BEGIN
  CountWords(INPUT, OUTPUT)
END. 
