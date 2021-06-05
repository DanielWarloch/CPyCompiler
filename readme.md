# Kompilator języka C, napisany w języku Python

## 1. Tytuł programu:

Kompilator języka C, napisany w języku Python

## 4. Założenia programu:

### a) ogólne cele programu

* obsługa słów kluczowych
* obsługa operatorów
* obsługa struktur i unii
* obsługa instrukcji warunkowych
* obsługa pętli

### b) rodzaj translatora

  * kompilator

### c) planowany wynik działania programu

  * kompilator języka C do kodu Asseblera na procesory MISP.

### d) planowany język implementacji

  * Python 

### e) sposób realizacji parsera

  * użycie generatora parserów PLY

## 5. Opis tokenów:


# Reserved words
```
reserved_map = {
    'break': 'BREAK',
    'char': 'CHAR',
    'continue': 'CONTINUE',
    'do': 'DO',
    'else': 'ELSE',
    'for': 'FOR',
    'if': 'IF',
    'int': 'INT',
    'float': 'FLOAT',
    'return': 'RETURN',
    'void': 'VOID',
    'while': 'WHILE',
    'asm': 'ASM',
    'printf': 'PRINTF'
}
tokens = tuple(reserved_map.values()) + (
    'ID', 'NUMBER', 'S_CONST', 'C_CONST',

    # Operators (||, &&, <=, >=, ==, !=)
    'LOR', 'LAND',
    'LE', 'GE', 'EQ', 'NE',

    # Assignment (*=, /=, +=, -=, &=, ^=, |=)
    'TIMESEQUAL', 'DIVEQUAL', 'PLUSEQUAL', 'MINUSEQUAL',
    'ANDEQUAL', 'XOREQUAL', 'OREQUAL',

    # Increment/decrement (++,--)
    'PLUSPLUS', 'MINUSMINUS',
)

literals = '=+-*/&|^~(){}[];,!<>'```
```

## 6. Opis gramatyki:


```
file : unit
     | file unit

unit : fun_def
     | declaration ";" 
            
fun_def : declaration_specifier ID "(" ")" compound_statement
        | declaration_specifier ID "(" declaration_list ")" compound_statement
               
statement : expression ";"
          | declaration ";"
          | compound_statement

expression : ID "(" ")"
           | ID "(" expression_list ")" 
                                                  
expression : ASM "(" S_CONST ")" 

expression : PRINTF "(" S_CONST ")" 

declaration_specifier : VOID
                      | INT
                      | CHAR
                      | FLOAT
                      | INT pointer
                      | CHAR pointer
                      | FLOAT pointer
                             
statement : RETURN expression ";"
          | RETURN ";"                           
                           
statement : BREAK ";" 

statement : CONTINUE ";" 

statement : WHILE "(" expression ")" statement
                           
statement : DO statement WHILE "(" expression ")" ";" 

statement : FOR "(" expression ";" expression ";" expression ")" statement   

statement : IF "(" expression ")" statement

statement : IF "(" expression ")" statement ELSE statement
   
declaration : declaration_specifier ID "[" NUMBER "]" "=" "{" expression_list "}"
            | declaration_specifier ID "[" NUMBER "]"
            | declaration_specifier ID "[" FLOAT "]" "=" "{" expression_list "}"
            | declaration_specifier ID "[" FLOAT "]" 
                   
declaration : declaration_specifier ID "=" expression
            | declaration_specifier ID 

expression : MINUSMINUS ID 

expression : ID MINUSMINUS

expression : PLUSPLUS ID 

expression : ID PLUSPLUS 

expression : ID XOREQUAL expression
                                   
expression : ID ANDEQUAL expression

expression : ID OREQUAL expression

expression : ID TIMESEQUAL expression

expression : ID DIVEQUAL expression

expression : ID PLUSEQUAL expression

expression : ID MINUSEQUAL expression

expression : ID "=" expression

expression_list : expression
                | expression_list ',' expression
                       
declaration_list : declaration
                 | declaration_list ',' declaration
                        
expression : expression '+' expression
           | expression '-' expression
           | expression '*' expression
           | expression '/' expression
           | expression '&' expression
           | expression '|' expression
           | expression '^' expression 
                  
expression : '~' expression %prec UMINUS

expression : '-' expression %prec UMINUS

expression : '(' expression ')' 

expression : ID '[' expression ']'

expression : ID '[' expression ']' '=' expression

expression : NUMBER
           | FLOAT
                  
expression : ID

expression : '&' ID

expression : '&' ID '[' expression ']' 

expression : "*" ID "=" expression

expression : '*' ID

pointer : '*'
        | pointer '*'
                       
expression : C_CONST
           
expression : eq_exp

eq_exp : expression EQ expression
       | expression NE expression
       | expression LOR expression
       | expression LAND expression
       | expression '<' expression
       | expression '>' expression
       | expression GE expression
       | expression LE expression
              
compound_statement : "{" statement_list "}"
                   | "{" "}" 
                          
statement_list : statement
               | statement_list statement                                                                                                         
```


## 7. Opis i schemat struktury programu:
Kod źródłowy zostaje wczytany z pliku.

Następnie wczytane dane zostają przekazane do obiektu skanera - obiektu 'lexer', który analizuje tokeny.
Przeanalizowane tokeny zostają przekazane do parsera - obiektu parser, który zwraca drzewo składniowe.     
Dla łatwiejszego debugowania wynik działania parsera można zapisać także do pliku. 

Kolejnym krokiem jest przekazanie outputu z parsera do funkcji parse() generatora.

Generator analizuje otrzymane drzewo i na jego podstawie tworzy wynikowy kod assemblera, który następnie zapisuje pod wskazaną nazwą. 
Drzewo składni jest zaimplementowane w krotkach. Główną ideą jest to, że jeśli podczas parsowania drzewa napotkamy krotkę, 
to funkcja parsowania jest uruchamiana ponownie, aż do napotkania węzła końcowego, dla którego generowane są instrukcje.

W przypadku wystąpienia błędów (zarówno parsera jak i skanera) zostaje wypisany odpowiedni komunikat po czym program przerywa pracę.
## 8. Informacje o stosowanych generatorach skanerów/parserów, pakietach zewnętrznych:
W naszym projekcie zastosowaliśmy generator prarserów PLY. PLY to w 100% implementacja w Pythonie narzędzi lex i yacc powszechnie używanych do pisania parserów i kompilatorów. Parsowanie opiera się na tym samym algorytmie LALR(1) używanym przez wiele narzędzi yacc. 
Oto kilka godnych uwagi funkcji:
* PLY zapewnia bardzo obszerne raportowanie błędów i informacje diagnostyczne, aby pomóc w konstruowaniu parsera. Oryginalna implementacja została opracowana w celach instruktażowych. Dzięki temu system stara się zidentyfikować najczęstsze rodzaje błędów popełnianych przez początkujących użytkowników.
* PLY zapewnia pełną obsługę pustych produkcji, usuwanie błędów, specyfikatory pierwszeństwa i umiarkowanie niejednoznaczne gramatyki.
* PLY może być używany do budowania parserów dla „prawdziwych” języków programowania. Chociaż nie jest ultraszybki ze względu na implementację w Pythonie, PLY może być używany do analizowania gramatyk składających się z kilkuset reguł.

Korzystamy także z biblioteki argparse na potrzeby parsowania parametrów podawanych przy uruchamianiu programu. Takich jak ścieżka do pliku źródłowego, ścieżka do pliku wynikowego oraz kilku innych opcji. 
## 9. Informacje o zastosowaniu specyficznych metod rozwiązania problemu:
Język MIPS asembler jest to po prostu język asemblera procesora z rodziny MIPS. 
Termin MIPS jest akronimem od Microprocessor without Interlocked Pipeline Stages. Jest to architektura o zredukowanym zestawie instrukcji opracowana przez organizację o nazwie MIPS Technologies.

Język asemblerowy MIPS jest popularny ponieważ wiele systemów wbudowanych działa na procesorach MIPS. 
Natomiast my wybraliśmy go ze względu na zredukowaną liczbę instrukcji które obsługuje, a także świetne narzędzie do testowania działania kodu asemblera na procesory MISP jakim jest program "Mars".

## 10. Krótka instrukcja obsługi:
Przed uruchomieniem programu należy upewnić się, że mamy dostępny PLY. 
Instalacji można dokonać poprzez komendę `pip install ply`.

Program uruchamiamy w konsoli w folderze `src` należącym do projektu poleceniem:
`python3 main.py -source_file [source_file_path] -dest_file [output_file_path] --ast_file [ast_output_file_path] --table_file [table_output_file_path]`
Dla wyświetlenia wszystkich dostępnych opcji wraz z opisami należy wpisać:
`python3 main.py --help`

## 11. Testy, przykłady:
* Syntax error
* Scope
* Reversed Christmas tree
* While loop
* Arithmetic sequence(while loop inside for loop)
* Quick sort (pointers, arrays)

## 12. Możliwe rozszerzenia programu:
* Obsługa programów wieloplikowych
* Obsługa tablic wielowymiarowych
* Obsługa funkcji pobierających dane od użytkownika
* Obsługa argumentów funkcji printf formatujących tekst

## 13. Ograniczenia programu:
Nie obsługuje includów
Nie obsługuje funkcji pobierających dane od użytkownika
Nie obsługuje tablic wielowymiarowych
Nie obsługuje argumentów funkcji printf formatujących tekst
