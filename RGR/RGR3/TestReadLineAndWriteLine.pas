PROGRAM Testing(INPUT, OUTPUT);
USES
  WordTypeUnit,
  NodeWork,
  FileWork;
VAR
  Base: WordType;
  FirstEndingPtr: EndingNodePtr;
  Count: INTEGER;
BEGIN
  ReadLine(INPUT, Base, FirstEndingPtr, Count);
  WriteLine(OUTPUT, Base, FirstEndingPtr, Count)

END .
