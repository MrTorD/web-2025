UNIT WordTypeUnit;

INTERFACE
CONST
  MaxWordLen = 30;
  MaxConfigLen = 100;
  SupportableChars = ['0'..'9', 'A'..'Z', 'a'..'z', '''', 'À'..'ß', 'à'..'ÿ', '¸', '¨'];
  EndWordChar = '$';
  NullEndingChar = '#';
  BaseAndEndingsSeparator = ',';
  WordAndCountSeparator = ':';

TYPE 
  WordType = ARRAY [0..(MaxWordLen + 1)] OF CHAR;
  EndingsConfig = ARRAY [0..(MaxConfigLen + 1)] OF WordType;
  
VAR
  NullEnding: WordType;  
  EndingsConfigFile: TEXT;
  Config: EndingsConfig;
  EndOfConfig: WordType;
  
PROCEDURE ReadWord(VAR FIn: TEXT; VAR Word: WordType);  
PROCEDURE WriteWord(VAR FOut: TEXT; VAR Word: WordType);
PROCEDURE SplitWord(VAR Word: WordType; VAR Base: WordType; VAR Ending: WordType);
FUNCTION IsEndOf(VAR Ending: WordType; VAR Word: WordType) : BOOLEAN;
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
  WHILE (FIn^ IN SupportableChars + ['-'] + [NullEndingChar]) AND (I <= MaxWordLen) 
  DO
    BEGIN
      READ(FIn, Ch);
      IF Ch IN ['À'..'ß', 'A'..'Z', '¨']
      THEN
        BEGIN
          ToLowerCase(Ch);
          Word[I] := Ch
        END  
      ELSE
        Word[I] := Ch;    
      I := I + 1
    END;  
  Word[I] := EndWordChar
END; {ReadWord}

{PROCEDURE ReadEnding(VAR FIn: TEXT; VAR Ending: WordType);
VAR
  I: INTEGER;
  Ch: CHAR;
BEGIN {ReadEnding}
{  I := 0;
  WHILE (FIn^ IN SupportableChars + [NullEndingChar]) AND (I <= MaxEndingLen) 
  DO
    BEGIN
      READ(FIn, Ch);
      Ending[I] := Ch; 
      I := I + 1
    END;  
  Ending[I] := EndWordChar
END; {ReadEnding}

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
    BEGIN
      IF (Word1[I] <> '¸') AND (Word2[I] <> '¸')
      THEN
        Bigger := Word1[I] > Word2[I]
      ELSE
        IF Word1[I] = '¸'
        THEN          
          Bigger := Word2[I] <= 'å'
        ELSE
          IF Word2[I] = '¸'
          THEN               
            Bigger := Word1[I] > 'å' 
    END                   
  ELSE
    IF (Word1[I] <> EndWordChar) AND (Word2[I] = EndWordChar)
    THEN
      Bigger := TRUE;
  IsBigger := Bigger   
END; {IsBigger} 

FUNCTION IsEndOf(VAR Ending: WordType; VAR Word: WordType) : BOOLEAN;
VAR
  IWord, IEnd: INTEGER;
  IsEnd: BOOLEAN;
BEGIN {IsEndOf}
  IWord := 0;
  IEnd := 0;
  WHILE Word[IWord] <> EndWordChar
  DO
    IWord := IWord + 1;
  WHILE Ending[IEnd] <> EndWordChar
  DO
    IEnd := IEnd + 1;
  IsEnd := TRUE;  
  WHILE (IEnd > 0) AND (IWord > 0) AND IsEnd 
  DO
    BEGIN
      IWord := IWord - 1;
      IEnd := IEnd - 1;
      IF Word[IWord] <> Ending[IEnd]
      THEN
        IsEnd := FALSE          
    END;
  IF IEnd <> 0
  THEN
    IsEnd := FALSE;
  IsEndOf := IsEnd          
END; {IsEndOf}

PROCEDURE GetBase(VAR Word: WordType; VAR Ending: WordType; VAR Base: WordType);
VAR
  IWord, IEnd, I: INTEGER;
BEGIN {GetBase}
  IWord := 0;
  IEnd := 0;
  I := 0;
  WHILE Word[IWord] <> EndWordChar
  DO
    IWord := IWord + 1;
  WHILE Ending[IEnd] <> EndWordChar
  DO
    IEnd := IEnd + 1;
  IWord := IWord - IEnd;
  WHILE I < IWord
  DO
    BEGIN
      Base[I] := Word[I];
      I := I + 1
    END;
  Base[I] := EndWordChar    
END; {GetBase}

PROCEDURE SplitWord(VAR Word: WordType; VAR Base: WordType; VAR Ending: WordType);
VAR 
  IWord, IEnd: INTEGER;
  ICfg: INTEGER;
BEGIN {SplitWord}
  ICfg := 0;
  Ending := Config[ICfg];
  WHILE (Config[ICfg] <> EndOfConfig) AND (NOT IsEndOf(Ending, Word)) 
  DO  
    BEGIN
      Ending := Config[ICfg];
      ICfg := ICfg + 1
    END; 
  IF IsEndOf(Ending, Word)
  THEN
    GetBase(Word, Ending, Base)
  ELSE
    BEGIN
      Base := Word;
      Ending := NullEnding
    END           
END; {SplitWord} 

PROCEDURE CreateConfig(VAR Config: EndingsConfig; VAR EndingsConfigFile: TEXT);
VAR
  I: INTEGER;
  Ending: WordType;
BEGIN {CreateConfig}
  I := 0;
  WHILE NOT EOF(EndingsConfigFile)
  DO
    BEGIN
      ReadWord(EndingsConfigFile, Ending);
      Config[I] := Ending;
      READLN(EndingsConfigFile);
      I := I + 1
    END;
  Config[I] := EndOfConfig  
END; {CreateConfig}  
                                                     

BEGIN
  NullEnding[0] := NullEndingChar;
  NullEnding[1] := EndWordChar; 
  EndOfConfig[0] := '.';
  EndOfConfig[1] := EndWordChar;
  ASSIGN(EndingsConfigFile, 'EndingsConfig.txt');
  RESET(EndingsConfigFile);
  CreateConfig(Config, EndingsConfigFile);  
END. 
