import argparse
from src.parser.parser_ply import ParseException, lexer, parser
from src.generator.generator import parse

debug_level = 0
arg_parser = argparse.ArgumentParser(description='')
arg_parser.add_argument('-source_file', type=open)
arg_parser.add_argument('-dest_file', type=argparse.FileType('w+'))
arg_parser.add_argument('--ast_file', type=argparse.FileType('w+'))
arg_parser.add_argument('--table_file', type=argparse.FileType('w'))
arg_parser.add_argument('--debug', type=bool, default=False)
args = arg_parser.parse_args()


# arg_parser.add_argument('dest_file', type=argparse.FileType('w+', encoding='latin-1'))
def get_table(text_to_tokenize):
    strings = ""
    for i in text_to_tokenize:
        strings += i
    lexer.input(strings)
    while 1:
        token = lexer.token()  # Get a token
        if not token: break  # No more tokens
        args.table_file.write(f"TOKEN TYPE: {token.type}, VALUE: '{token.value}', LINE: {token.lineno}\n")


if __name__ == "__main__":
    text = args.source_file.read()

    if args.table_file:  # Zapisuje listę tokenów do pliku
        get_table(text)

    try:
        ast = parser.parse(input=text, lexer=lexer, debug=args.debug)
        if args.ast_file:
            args.ast_file.write(str(ast))
        parse(ast, args.dest_file)
    except ParseException as e:
        print(e)
    except:
        print("Illegal token")
