PROGRAM TestEndings(INPUT, OUTPUT);
USES 
  WordTypeUnit;

VAR
  Word1, Word2, Base1, Base2: WordType;
  Ending1, Ending2: EndingType;
  Ch: CHAR; 
  
BEGIN
  ReadWord(INPUT, Word1);
  SplitWord(Word1, Base1, Ending1);
  READ(INPUT, Ch);
  ReadWord(INPUT, Word2);
  SplitWord(Word2, Base2, Ending2);
  IF IsEqualsEnding(Ending1, Ending2)
  THEN
    WRITELN('Endings are equals')
  ELSE
    WRITELN('Ending are not equals')  
  
END.  
