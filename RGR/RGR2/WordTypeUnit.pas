UNIT WordTypeUnit;

INTERFACE
CONST
  MaxWordLen = 32;
  SupportableChars = ['0'..'9', 'A'..'Z', 'a'..'z', '''', 'À'..'ß', 'à'..'ÿ', '¸', '¨'];
  EndWordChar = '$';

TYPE 
  WordType = ARRAY [0..(MaxWordLen + 1)] OF CHAR;

PROCEDURE ReadWord(VAR FIn: TEXT; VAR Word: WordType);  
PROCEDURE WriteWord(VAR FOut: TEXT; VAR Word: WordType);
FUNCTION IsBigger(VAR Word1: WordType; VAR Word2: WordType) : BOOLEAN;
FUNCTION IsEquals(VAR Word1: WordType; VAR Word2: WordType) : BOOLEAN;

IMPLEMENTATION

PROCEDURE ToLowerCase(VAR Ch: CHAR);
BEGIN {ToLowerCase}
  CASE Ch OF
    'A': Ch := 'a';
    'B': Ch := 'b';
    'C': Ch := 'c';
    'D': Ch := 'd';
    'E': Ch := 'e';
    'F': Ch := 'f';
    'G': Ch := 'g';
    'H': Ch := 'h';
    'I': Ch := 'i';
    'J': Ch := 'j';
    'K': Ch := 'k';
    'L': Ch := 'l';
    'M': Ch := 'm';
    'N': Ch := 'n';
    'O': Ch := 'o';
    'P': Ch := 'p';
    'Q': Ch := 'q';
    'R': Ch := 'r';
    'S': Ch := 's';
    'T': Ch := 't';
    'U': Ch := 'u';
    'V': Ch := 'v';
    'W': Ch := 'w';
    'X': Ch := 'x';
    'Y': Ch := 'y';
    'Z': Ch := 'z';
    'À': Ch := 'à';
    'Á': Ch := 'á';
    'Â': Ch := 'â';
    'Ã': Ch := 'ã';
    'Ä': Ch := 'ä';
    'Å': Ch := 'å';
    '¨': Ch := '¸';
    'Æ': Ch := 'æ';
    'Ç': Ch := 'ç';
    'È': Ch := 'è';
    'É': Ch := 'é';
    'Ê': Ch := 'ê';
    'Ë': Ch := 'ë';            
    'Ì': Ch := 'ì';
    'Í': Ch := 'í';
    'Î': Ch := 'î';
    'Ï': Ch := 'ï';
    'Ð': Ch := 'ð';
    'Ñ': Ch := 'ñ';
    'Ò': Ch := 'ò';
    'Ó': Ch := 'ó';
    'Ô': Ch := 'ô';
    'Õ': Ch := 'õ';
    'Ö': Ch := 'ö';
    '×': Ch := '÷';
    'Ø': Ch := 'ø';
    'Ù': Ch := 'ù';
    'Ú': Ch := 'ú';
    'Û': Ch := 'û';
    'Ü': Ch := 'ü';
    'Ý': Ch := 'ý';
    'Þ': Ch := 'þ';
    'ß': Ch := 'ÿ';
  END      
END; {ToLowerCase}
  
PROCEDURE ReadWord(VAR FIn: TEXT; VAR Word: WordType);
VAR
  I: INTEGER;
  Ch: CHAR;
BEGIN {ReadWord}
  I := 0;
  WHILE (FIn^ IN SupportableChars + ['-']) AND (I <= MaxWordLen) 
  DO
    BEGIN
      READ(FIn, Ch);
      IF Ch IN ['a'..'z', '-', '''', 'à'..'ÿ', '¸']
      THEN
        Word[I] := Ch
      ELSE
        BEGIN
          ToLowerCase(Ch);
          Word[I] := Ch
        END;    
      I := I + 1
    END;  
  Word[I] := EndWordChar
END; {ReadWord}

PROCEDURE WriteWord(VAR FOut: TEXT; VAR Word: WordType);
VAR
  I: INTEGER;
BEGIN {WriteWord}
  I := 0;
  WHILE Word[I] <> EndWordChar
  DO
    BEGIN
      WRITE(FOut, Word[I]);
      I := I + 1
    END 
END; {WriteWord}

FUNCTION IsBigger(VAR Word1: WordType; VAR Word2: WordType) : BOOLEAN;
VAR
  I: INTEGER;
  Bigger: BOOLEAN;
BEGIN {IsBigger}
  I := 0;
  Bigger := FALSE;
  WHILE (Word1[I] <> EndWordChar) AND (Word2[I] <> EndWordChar) AND (Word1[I] = Word2[I])
  DO
    I := I + 1;
  IF (Word1[I] <> EndWordChar) AND (Word2[I] <> EndWordChar)
  THEN
    Bigger := Word1[I] > Word2[I]
  ELSE
    IF (Word1[I] <> EndWordChar) AND (Word2[I] = EndWordChar)
    THEN
      Bigger := TRUE;
  IsBigger := Bigger   
END; {IsBigger}

FUNCTION IsEquals(VAR Word1: WordType; VAR Word2: WordType) : BOOLEAN;
VAR
  I: INTEGER;
  Equality: BOOLEAN;
BEGIN {IsEquals}
  I := 0;
  Equality := TRUE;
  WHILE (Word1[I] <> EndWordChar) AND (Word2[I] <> EndWordChar) AND Equality
  DO
    IF Word1[I] <> Word2[I]
    THEN
      Equality := FALSE
    ELSE
      I := I + 1;  
  IF (Word1[I] <> EndWordChar) OR (Word2[I] <> EndWordChar)
  THEN
    Equality := FALSE;    
  IsEquals := Equality      
END; {IsEquals}  


BEGIN
END. 
