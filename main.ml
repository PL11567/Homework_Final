open Printf
open Lexer

let ic = open_in Sys.argv.(1)

let cin =
		if Array.length Sys.argv > 1
			then ic else stdin
						
let lexbuf = Lexing.from_channel cin 
        
let _ = 
	try
		while true do
		 Parser.init Lexer.tokenize lexbuf;  
		done
		
    with End_of_file -> close_in ic
			| Parsing.Parse_error ->
				Printf.printf "Erro na linha n. %s entre os caracteres n.º [%i - %i] e perto de '%s'! \n" 
				 ((string_of_int !line_num))(Lexing.lexeme_start lexbuf) (Lexing.lexeme_end lexbuf) (Lexing.lexeme lexbuf);
				close_in ic;
				exit(1)
			
			| Failure(x) ->
				Printf.printf "Erro na linha n. %s entre os caracteres n.º [%i - %i] e perto de '%s'! \n" 
				 ((string_of_int !line_num))(Lexing.lexeme_start lexbuf) (Lexing.lexeme_end lexbuf) (Lexing.lexeme lexbuf);
				close_in ic;
				exit(1);;
			

