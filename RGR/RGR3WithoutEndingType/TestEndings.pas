PROGRAM TestEndings(INPUT, OUTPUT);
USES 
  WordTypeUnit;

VAR
  Word1, Word2, Base1, Base2: WordType;
  Ending1, Ending2: EndingType;
  Ch: CHAR; 
  
BEGIN
  {ReadWord(INPUT, Word1);
  SplitWord(Word1, Base1, Ending1);
  READ(INPUT, Ch);
  ReadWord(INPUT, Word2);
  SplitWord(Word2, Base2, Ending2);
  WRITE(OUTPUT, 'Ending1 is ');
  WriteEnding(OUTPUT, Ending1);
  WRITELN;
  WRITE(OUTPUT, 'Ending2 is ');
  WriteEnding(OUTPUT, Ending2);
  WRITELN;
  IF IsBiggerEnding(Ending1, Ending2)
  THEN
    WRITELN('Ending1 is bigger')
  ELSE
    WRITELN('Ending2 is not bigger');  
  IF IsEqualsEnding(Ending1, Ending2)
  THEN
    WRITELN('Endings are equals')
  ELSE
    WRITELN('Ending are not equals')}
    
  ReadWord(INPUT, Word1);
  READ(INPUT, Ch);
  ReadWord(INPUT, Word2);
  WriteWord(OUTPUT, Word1);
  IF IsBigger(Word1, Word2)
  THEN
    WRITE(' is bigger than ')
  ELSE
    WRITE(' is not bigger than ');
  WriteWord(OUTPUT, Word2)        
  
END.  
