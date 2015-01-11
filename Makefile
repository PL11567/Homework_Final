OCAMLC=ocamlc
OCAMLLEX=ocamllex
OCAMLYACC=ocamlyacc
all: parser.cmo lexer.cmo main.cmo
	ocamlc -o teste str.cma lexer.cmo parser.cmo main.cmo 
main.cmo: main.ml parser.cmo lexer.cmo
	ocamlc -c main.ml

lexer.cmo: lexer.ml
	ocamlc -c lexer.ml

parser.cmo: parser.ml parser.cmi
	ocamlc -c parser.ml

parser.cmi: parser.mli
	ocamlc -c parser.mli

parser.mli parser.ml: parser.mly
	ocamlyacc parser.mly

lexer.ml: lexer.mll parser.cmi
	ocamllex lexer.mll
clean:
	rm *.cmo *.cmi *.mli
