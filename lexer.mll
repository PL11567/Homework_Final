{
	open Parser
	open Printf
	open Lexing
	open String
	open Str
	let line_num = ref 1

let create_hashtable size init =
    let tbl = Hashtbl.create size in
    List.iter (fun (key, data) -> Hashtbl.add tbl key data) init;
    tbl
 
let string_table = create_hashtable 57 
		[  	
		  ("Form", FORM "Form"); 
		  ("Prepared by (fullname)", PREPARED_BY "Prepared by (full name)" ); 
		  ("Date Prepared", DATE_PREPARED "Date Prepared"); 
		  ("Report Type", REPORT_TYPE "Report Type"); 
		  ("If Update", IF_UPDATE "If Update"); 
		  ("Previous Site Log", PREVIOUS_LOG "Previous Site Log"); 
		  ("Modified/Added Sections", MODIFIED_SEC "Modified/Added Sections");
		  ("Site Identification of the GNSS Monument",SITE_IDENTIFICATION "Site Identification of the GNSS Monument");
		  ("Site Name", SITE_NAME "Site Name");
		  ("Four Character ID", FOUR_CHARATER_ID "Four Character ID");
		  ("Monument Inscription", MONUMENT_INSCRIPTION "Monument Inscription");
		  ("IERS DOMES Number", IERS "IERS DOMES Number");
		  ("CDP Number", CDP_NUMBER "CDP Number");
		  ("Monument Description", MONUMENT_DESCRIPTION "Monument Description");
		  ("Height of the Monument", HEIGHT_OF_THE_MONUMENT "Height of the Monument");
		  ("Monument Foundation", MONUMENT_FOUNDATION "Monument Foundation");
		  ("Foundation Depth", FOUNDATION_DEPTH "Foundation Depth");
		  ("Marker Description", MARKER_DESCRIPTION "Marker Description");
          ("Date Installed", DATE_INSTALLED "Date Installed");
          ("Geologic Characteristic", GEOLOGIC_CHARACTERISTIC "Geologic Characteristic");
          ("Bedrock Type", BEDROCK_TYPE "Bedrock Type");
          ("Bedrock Condition", BEDROCK_CONDITION "Bedrock Condition");
          ("Fracture Spacing", FRACTURE_SPACING "Fracture Spacing");
          ("Fault zones nearby", FAULT_ZONES_NEARBY "Fault zones nearby");
          ("Distance/activity", DISTANCE_ACTIVITY "Distance/activity");
          ("Additional Information", ADDITIONAL_INFORMATION "Additional Information");
          ("Site Location Information", SITE_LOCATION_INFORMATION "Site Location Information");
		  ("City or Town", CITY_OR_TOWN "City or Town");
          ("State or Province", STATE_OR_PROVINCE "State or Province");
          ("Country", COUNTRY "Country");
          ("Tectonic Plate", TECTONIC_PLATE "Tectonic Plate");
          ("Approximate Position (ITRF)", APPROXIMATE_POSITION "Approximate Position (ITRF)");
          ("X coordinate (m)", X_COORDINATE "X coordinate (m)");
		  ("Y coordinate (m)", Y_COORDINATE "Y coordinate (m)");
		  ("Z coordinate (m)", Z_COORDINATE "Z coordinate (m)");
		  ("Elevation (m,ellips.)", ELEVATION_CUTOFF_SETTING "Elevation (m,ellips.)");
		  ("GNSS Receiver Information", GNSS_RECEIVER_INFORMATION "GNSS Receiver Information");
		  ("Receiver Type", RECEIVER_TYPE "Receiver Type");
		  ("Satellite System", SATELLITE_SYSTEM "Satellite System");
		  ("Serial Number", SERIAL_NUMBER "Serial Number");
		  ("Firmware Version", FIRMWARE_VERSION "Firmware Version");
		  ("Elevation Cutoff Setting", ELEVATION_CUTOFF_SETTING "Elevation Cutoff Setting");
		  ("Date Removed", DATE_REMOVED "Date Removed");
		  ("Temperature Stabiliz.", TEMPERATURE_STABILIZ "Temperature Stabiliz.");
		  ("GNSS Antenna Information", GNSS_ANTENNA_INFORMATION "GNSS Antenna Information");
		  ("Antenna Type", ANTENNA_TYPE "Antenna Type");
		  ("Antenna Reference Point", ANTENNA_REFERENCE_POINT "Antenna Reference Point");
		  ("Marker->ARP Up Ecc. (m)", MARKUP "Marker->ARP Up Ecc. (m)");
		  ("Marker->ARP North Ecc(m)", MARKNORTH "Marker->ARP North Ecc(m)");
		  ("Marker->ARP East Ecc(m)", MARKEAST "Marker->ARP East Ecc(m)");
		  ("Alignment from True N", ALIGNMENT_FROM_TRUE "Alignment from True N");
		  ("Antenna Radome Type", ANTENNA_RADOME_TYPE "Antenna Radome Type");
		  ("Radome Serial Number", RADOME_SERIAL_NUMBER "Radome Serial Number");
		  ("Antenna Cable Type", ANTENNA_CABLE_TYPE "Antenna Cable Type");
		  ("Antenna Cable Length", ANTENNA_CABLE_LENGHT "Antenna Cable Length");	  
		]
}
let id_dash = ['-']
let id_leftparen = ['(']
let id_rightparen = [')']
let id_twodots = [':']
let digit = ['0'-'9']
let id_datas = 
				digit digit digit digit id_dash digit digit id_dash digit digit['T']digit digit id_twodots digit digit[' ']* ['Z''z'] 
			   | id_leftparen ['C']['C']['Y']['Y']id_dash['M']['M']id_dash['D']['D']['T']['h']['h']id_twodots['m']['m']['Z']id_rightparen
let id_plus = ['+']
let id_datasimples = digit digit digit digit id_dash digit digit id_dash digit digit
let id_dot = ['.']
let id_espaco = [' ']+
let id_slash = ['/']
let id_strings = ['a'-'z' 'A'-'Z' '_' ',' '(' ')' ' ' '/''>']*
let id_stname = id_strings id_twodots id_slash id_slash id_strings id_dot id_strings id_dot id_strings id_dot id_strings id_slash id_strings id_slash id_strings id_slash id_strings id_slash id_strings id_dot id_strings
let id_inteiro = digit+
let id_fracspacing = (id_inteiro id_dash id_inteiro)
let id_real =  (id_inteiro id_dot id_inteiro)
let id_coordenada = (id_plus id_real) | (id_dash id_real)
let id_ficheiro =  (id_strings id_inteiro+ id_dot 'l''o''g') |  ('(''s''s''s''s''_''c''c''y''y''m''m''d''d' '.' 'l''o''g'')')
let id_latlong = 
				('L''a''t''i''t''u''d''e'' ''(''N'' ''i''s'' '(id_plus)')'' ') 
				| ('L''o''n''g''i''t''u''d''e'' ''(''E'' ''i''s'' '(id_plus)')'' ')
let id_tempstab = ('T''e''m''p''e''r''a''t''u''r''e'' ''S''t''a''b''i''l''i''z'(id_dot))
let id_markup = ('M''a''r''k''e''r''-''>''A''R''P'' ''U''p'' ''E''c''c'(id_dot)' ''(''m'')')
let id_marknorth = ('M''a''r''k''e''r''-''>''A''R''P'' ''N''o''r''t''h'' ''E''c''c''(''m'')')
let id_markeast = ('M''a''r''k''e''r''-''>''A''R''P'' ''E''a''s''t'' ''E''c''c''(''m'')')
let id_elev1 =(id_strings '(''m'',''e''l''l''i''p''s''.'')')
let id_blank = [' ''\r''\t']
let id_enter = ['\n']

rule tokenize = parse
 | id_inteiro as inteiro { INTEIRO (int_of_string inteiro) } 
 | id_real as real 
  { 
	let remove_blanks = Str.global_replace (Str.regexp "[ ]+") "" in REAL (float_of_string(remove_blanks real))
  }
 | id_dot as dot { DOT (dot)}
 | id_fracspacing as fracspacing { FRACSPACING (fracspacing)}
 | id_blank* (id_latlong as latlong) { LATLONG (latlong)}
 | id_tempstab as tempstab { TEMPERATURE_STABILIZ (tempstab) }
 | id_blank* (id_markup as markup) { MARKUP (markup) }
 | id_blank* (id_marknorth as marknorth) { MARKNORTH (marknorth)}
 | id_blank*  (id_markeast as markeast) { MARKEAST (markeast)}
 
 | id_elev1 as elev1
  { 
   let remove_blanks = Str.global_replace (Str.regexp "[ ]+") "" in ELEV1 (remove_blanks elev1)
  }
 | id_blank*(id_twodots as twodots) id_blank* { TWODOTS (twodots)}
 | id_ficheiro as ficheiro { FICHEIRO (ficheiro) }
 | id_datasimples as datasimples { DATASIMPLES (datasimples) }
 | (id_stname as stname) { STNAME (stname) }
 | id_blank* (id_coordenada as coordenada) { COORDENADA (coordenada) }
 | id_enter as enter { incr line_num; tokenize lexbuf }
 | id_datas as datas 
		{ 
		let remove_blanks = Str.global_replace (Str.regexp "[ ]+") "" in DATAS (remove_blanks datas)
		}
 | id_blank *(id_strings as word) id_blank *
  		{ 
			
  			let word_no_spaces = String.trim word in 
  			try 
				(let res =  Hashtbl.find string_table word_no_spaces in res)
		  	with 
				Not_found -> STRINGS word
  		}
 | _ { tokenize lexbuf  }
 | eof { raise End_of_file }

{

	    
}
