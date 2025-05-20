PROGRAM TestMerge(INPUT, OUTPUT);
USES
  WordTypeUnit,
  NodeWork;

VAR
  F1, F2, F3: TEXT;

PROCEDURE ReadLine(VAR F: TEXT; VAR Word: WordType; VAR Count: INTEGER);
VAR
  Ch: CHAR;
BEGIN {ReadLine}
  ReadWord(F, Word);
  READ(F, Ch);
  READ(F, Count);
  READLN(F)
END; {ReadLine}

PROCEDURE WriteLine(VAR F: TEXT; VAR Word: WordType; VAR Count: INTEGER);
BEGIN {WriteLine}
  WriteWord(F, Word);
  WRITELN(F, ':', Count)
END; {WriteLine}
  
PROCEDURE Merge(VAR F1: TEXT; VAR F2: TEXT; VAR F3: TEXT);
VAR 
  Word2, Word3: WordType;
  Count2, Count3: INTEGER; 
  Has2, Has3: BOOLEAN;
BEGIN 
  RESET(F2);
  RESET(F3);
  REWRITE(F1);

  // Проверяем, пусты ли файлы изначально
  Has2 := NOT EOF(F2);
  Has3 := NOT EOF(F3);

  IF Has2 AND Has3 THEN
  BEGIN
    // Читаем первые элементы из обоих файлов
    ReadLine(F2, Word2, Count2);
    ReadLine(F3, Word3, Count3);

    // Основной цикл слияния
    WHILE Has2 AND Has3 DO
    BEGIN
      IF IsBigger(Word2, Word3) THEN
      BEGIN
        WriteLine(F1, Word3, Count3);
        Has3 := NOT EOF(F3);
        IF Has3 THEN ReadLine(F3, Word3, Count3);
      END
      ELSE IF IsEquals(Word2, Word3) THEN
      BEGIN
        Count2 := Count2 + Count3;
        WriteLine(F1, Word2, Count2);
        Has2 := NOT EOF(F2);
        IF Has2 THEN ReadLine(F2, Word2, Count2);
        Has3 := NOT EOF(F3);
        IF Has3 THEN ReadLine(F3, Word3, Count3);
      END
      ELSE
      BEGIN
        WriteLine(F1, Word2, Count2);
        Has2 := NOT EOF(F2);
        IF Has2 THEN ReadLine(F2, Word2, Count2);
      END;
    END;

    // Дописываем остатки из F2
    WHILE Has2 DO
    BEGIN
      WriteLine(F1, Word2, Count2);
      Has2 := NOT EOF(F2);
      IF Has2 THEN ReadLine(F2, Word2, Count2);
    END;

    // Дописываем остатки из F3
    WHILE Has3 DO
    BEGIN
      WriteLine(F1, Word3, Count3);
      Has3 := NOT EOF(F3);
      IF Has3 THEN ReadLine(F3, Word3, Count3);
    END;
  END
  ELSE
  BEGIN
    // Если один из файлов пуст, копируем другой
    IF Has2 THEN CopyFile(F2, F1)
    ELSE IF Has3 THEN CopyFile(F3, F1);
  END;
END; {Merge}
BEGIN
  ASSIGN(F1, 'F1.txt');
  ASSIGN(F2, 'F2.txt');
  ASSIGN(F3, 'F3.txt');
  Merge(F1, F2, F3)
END.
