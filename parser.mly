%{
open Printf
open Lexing
%}

%token <int>INTEIRO
%token <float>REAL
%token <string>FICHEIRO
%token <string>DATAS
%token <string>DATASIMPLES
%token <string>DATASVAZIAS
%token <string>STRINGS
%token <char>DOT
%token <char>TWODOTS
%token <char>ENTER 
%token <string>KEYWORD
%token <string>STNAME
%token <string>COORDENADA
%token <string>LATLONG
%token <string>FRACSPACING
%token <string>NSITE
%token <string>FORM
%token <string>PREPARED_BY
%token <string>DATE_PREPARED
%token <string>REPORT_TYPE
%token <string>IF_UPDATE
%token <string>PREVIOUS_LOG
%token <string>MODIFIED_SEC
%token <string>SITE_IDENTIFICATION
%token <string>SITE_NAME
%token <string>FOUR_CHARATER_ID
%token <string>MONUMENT_INSCRIPTION
%token <string>IERS
%token <string>CDP_NUMBER
%token <string>MONUMENT_DESCRIPTION
%token <string>HEIGHT_OF_THE_MONUMENT
%token <string>MONUMENT_FOUNDATION
%token <string>FOUNDATION_DEPTH
%token <string>MARKER_DESCRIPTION
%token <string>DATE_INSTALLED
%token <string>GEOLOGIC_CHARACTERISTIC
%token <string>BEDROCK_TYPE
%token <string>BEDROCK_CONDITION
%token <string>FRACTURE_SPACING
%token <string>FAULT_ZONES_NEARBY
%token <string>DISTANCE_ACTIVITY
%token <string>ADDITIONAL_INFORMATION
%token <string>SITE_LOCATION_INFORMATION
%token <string>CITY_OR_TOWN
%token <string>STATE_OR_PROVINCE
%token <string>COUNTRY
%token <string>TECTONIC_PLATE
%token <string>APPROXIMATE_POSITION
%token <string>X_COORDINATE
%token <string>Y_COORDINATE
%token <string>Z_COORDINATE
%token <string>ELEVATION_CUTOFF_SETTING
%token <string>GNSS_RECEIVER_INFORMATION
%token <string>RECEIVER_TYPE
%token <string>SATELLITE_SYSTEM
%token <string>SERIAL_NUMBER
%token <string>FIRMWARE_VERSION
%token <string>ELEV1
%token <string>ELEVATION_CUTOFF_SETTING
%token <string>DATE_REMOVED
%token <string>METERS
%token <string>TEMPERATURE_STABILIZ
%token <string>GNSS_ANTENNA_INFORMATION
%token <string>ANTENNA_TYPE
%token <string>ANTENNA_REFERENCE_POINT
%token <string>MARKUP
%token <string>MARKNORTH 
%token <string>MARKEAST
%token <string>ALIGNMENT_FROM_TRUE
%token <string>ANTENNA_RADOME_TYPE
%token <string>RADOME_SERIAL_NUMBER
%token <string>ANTENNA_CABLE_TYPE
%token <string>ANTENNA_CABLE_LENGHT
%token <string>DATE_STANDART 
%token <string>REPORT_STANDART
%token <string>FILE_LOG_STANDART
%token <string>MODIFIED_SEC_STANDART
%token <string>ALPHANUMERIC_A4
%token <string>ALPHANUMERIC_A9
%token <string>METERS_STANDART
%token <string>MONUMENT_FOUNDATION_STANDART
%token <string>MONUMENT_DESCRIPTION_STANDART
%token <string>MARKER_DESCRIPTION_STANDART
%token <string>GEOLOGIC_CHARACTERISTIC_STANDART
%token <string>BEDROCK_TYPE_STANDART
%token <string>BEDROCK_CONDITION_STANDART
%token <string>FRACTURE_SPACING_STANDART
%token <string>FAULT_ZONES_NEARBY_STANDART
%token <string>MULTIPLE_LINES
%token <string>COORDINATES_STANDARTS
%token <string>FLOAT_7_1_STANDART 
%token <string>ELEVATION_CUTOFF_SETTING_STANDART 
%token <string>TEMPERATURE_STABILIZ_STANDART 
%token <string>FLOAT_8_4_STANDART 
%token <string>RECEIVER_TYPE_STANDART 
%token <string>SATELLITE_SYSTEM_STANDART 
%token <string>SERIAL_NUMBER_STANDART 
%token <string>FIRMWARE_VERSION_STANDART 
%token <string>ANTENNA_REFERENCE_POINT 
%token <string>ALIGNEMENT 
%token <string>RADOME_TYPE_STANDARD
%token <string>VENDOR_TYPE_NUMBER
%token <string>ALIGNMENT_CLOCKWISE

%start init
%type <unit> init
%%

init:
| header init{}
| secform {}
| secsite {}
| siteloc {}
| gnss_rec_info {}
| gnss_ant_info {}

/************************* CABEÇALHO **********************************/

header:
	STRINGS 
	STRINGS  
	STRINGS TWODOTS 
	STNAME
	{ }
;
/************************** 0 FORM SECTION ****************************/

secform:

| INTEIRO DOT FORM {}
| STRINGS TWODOTS STRINGS  {}
| DATE_PREPARED TWODOTS DATASIMPLES  {}
| REPORT_TYPE TWODOTS STRINGS {}
| IF_UPDATE TWODOTS  {}
| PREVIOUS_LOG TWODOTS FICHEIRO {}
| MODIFIED_SEC TWODOTS STRINGS DOT STRINGS DOT STRINGS DOT DOT DOT STRINGS{}
;
/*********** 1 Site Identification of the GNSS Monument ***************/

secsite:

| INTEIRO DOT SITE_IDENTIFICATION  {}
| SITE_NAME TWODOTS STRINGS  { Printf.printf "%s\n" $3 ; flush stdout}
| FOUR_CHARATER_ID TWODOTS STRINGS  {Printf.printf "%s\n" $3 ; flush stdout}
| MONUMENT_INSCRIPTION TWODOTS  {}
| IERS TWODOTS INTEIRO STRINGS INTEIRO  {Printf.printf "%i%s%i\n" $3 $4 $5 ; flush stdout}
| CDP_NUMBER TWODOTS STRINGS INTEIRO STRINGS  {}
| MONUMENT_DESCRIPTION TWODOTS STRINGS  {Printf.printf "%s\n" $3; flush stdout}
| HEIGHT_OF_THE_MONUMENT TWODOTS STRINGS  {}
| MONUMENT_FOUNDATION TWODOTS STRINGS  {}
| FOUNDATION_DEPTH TWODOTS STRINGS  {}
| MARKER_DESCRIPTION TWODOTS STRINGS  {}
| DATE_INSTALLED TWODOTS DATAS  {Printf.printf "%s\n" (String.uppercase $3); flush stdout}	
| GEOLOGIC_CHARACTERISTIC TWODOTS STRINGS  {}
| BEDROCK_TYPE TWODOTS STRINGS  {}
| BEDROCK_CONDITION TWODOTS STRINGS  {}
| FRACTURE_SPACING TWODOTS STRINGS FRACSPACING STRINGS FRACSPACING STRINGS FRACSPACING STRINGS INTEIRO STRINGS  {}
| FAULT_ZONES_NEARBY TWODOTS STRINGS  {}
| DISTANCE_ACTIVITY TWODOTS STRINGS  {}
| ADDITIONAL_INFORMATION TWODOTS STRINGS  {Printf.printf "%s\n" $3; flush stdout}
;
/************** 2 Site Location Information ***************************/

siteloc:

| INTEIRO DOT SITE_LOCATION_INFORMATION  {}
| CITY_OR_TOWN TWODOTS STRINGS  {Printf.printf "%s\n" $3; flush stdout}
| STATE_OR_PROVINCE TWODOTS STRINGS  {Printf.printf "%s\n" $3; flush stdout}
| COUNTRY TWODOTS STRINGS  {Printf.printf "%s\n" $3; flush stdout}
| TECTONIC_PLATE TWODOTS STRINGS  {Printf.printf "%s\n" $3; flush stdout}
| APPROXIMATE_POSITION {}
| X_COORDINATE TWODOTS REAL  {Printf.printf "%f\n" $3; flush stdout}
| Y_COORDINATE TWODOTS COORDENADA 	{Printf.printf "%s\n" $3; flush stdout}
| Z_COORDINATE TWODOTS REAL  	{Printf.printf "%f\n" $3; flush stdout}
| LATLONG TWODOTS COORDENADA {Printf.printf "%s\n"$3; flush stdout}
| LATLONG TWODOTS COORDENADA {Printf.printf "%s\n" $3; flush stdout}
| ELEV1 TWODOTS REAL {Printf.printf "%f\n" $3; flush stdout}
| ADDITIONAL_INFORMATION TWODOTS STRINGS  {Printf.printf "%s\n" $3; flush stdout}
;

/************** 3 GNSS Receiver Information  **************************/

gnss_rec_info:

| INTEIRO DOT GNSS_RECEIVER_INFORMATION  {}
| REAL RECEIVER_TYPE TWODOTS STRINGS INTEIRO STRINGS  {Printf.printf "%s %i %s\n" $4 $5 $6}
| SATELLITE_SYSTEM TWODOTS SATELLITE_SYSTEM_STANDART  {Printf.printf "%s\n" $3}
| SERIAL_NUMBER TWODOTS INTEIRO  {Printf.printf "%i\n" $3}
| FIRMWARE_VERSION TWODOTS STRINGS INTEIRO STRINGS  {Printf.printf "%s %i %s\n" $3 $4 $5}
| ELEVATION_CUTOFF_SETTING TWODOTS STRINGS  {}
| DATE_INSTALLED TWODOTS DATAS  {Printf.printf "%s\n" (String.uppercase $3)}
| DATE_REMOVED TWODOTS DATAS  {Printf.printf "%s\n" (String.uppercase $3)}
| STRINGS DOT TWODOTS STRINGS  {}
| ADDITIONAL_INFORMATION TWODOTS STRINGS  {Printf.printf "%s\n" $3}

/***  3.x  ***/

| INTEIRO DOT STRINGS TWODOTS STRINGS {}
| SATELLITE_SYSTEM TWODOTS STRINGS 	{Printf.printf "%s\n" $3}
| SERIAL_NUMBER TWODOTS STRINGS {Printf.printf "%s\n" $3}
| FIRMWARE_VERSION TWODOTS STRINGS 	{Printf.printf "%s\n" $3}
| ELEVATION_CUTOFF_SETTING TWODOTS STRINGS 	{}
| DATE_INSTALLED TWODOTS DATAS	{Printf.printf "%s\n" (String.uppercase $3)}
| DATE_REMOVED TWODOTS DATAS {Printf.printf "%s\n" (String.uppercase $3)}
| STRINGS DOT TWODOTS STRINGS {}
| ADDITIONAL_INFORMATION TWODOTS STRINGS {Printf.printf "%s\n" $3}
;

/************** 4 GNSS Antenna Information  ***************************/

gnss_ant_info:

| INTEIRO DOT GNSS_ANTENNA_INFORMATION  {}
| REAL ANTENNA_TYPE TWODOTS STRINGS INTEIRO STRINGS  {Printf.printf "%s %i %s\n" $4 $5 $6}
| SERIAL_NUMBER TWODOTS STRINGS {Printf.printf "%s\n" $3}
| ANTENNA_REFERENCE_POINT TWODOTS STRINGS 	{Printf.printf "%s\n" $3}
| MARKUP TWODOTS REAL  {Printf.printf "%f\n" $3}
| MARKNORTH TWODOTS REAL  {Printf.printf "%f\n" $3}
| MARKEAST TWODOTS REAL  {Printf.printf "%f\n" $3}
| ALIGNMENT_FROM_TRUE TWODOTS REAL  {}
| ANTENNA_RADOME_TYPE TWODOTS STRINGS 	{Printf.printf "%s\n" $3}
| RADOME_SERIAL_NUMBER TWODOTS  {}
| ANTENNA_CABLE_TYPE TWODOTS  {}
| ANTENNA_CABLE_LENGHT TWODOTS INTEIRO STRINGS  {}
| DATE_INSTALLED TWODOTS DATAS  {Printf.printf "%s\n" (String.uppercase $3)}
| DATE_REMOVED TWODOTS DATAS 	{Printf.printf "%s\n" (String.uppercase $3)}
| ADDITIONAL_INFORMATION TWODOTS STRINGS {Printf.printf "%s\n" $3}	
	
/***   4.x  ***/

| INTEIRO DOT STRINGS TWODOTS STRINGS INTEIRO STRINGS DOT STRINGS STRINGS 	{}
| SERIAL_NUMBER TWODOTS STRINGS INTEIRO STRINGS INTEIRO STRINGS  {}
| ANTENNA_REFERENCE_POINT TWODOTS STRINGS STRINGS DOT STRINGS STRINGS DOT STRINGS 	{}
| MARKUP DOT STRINGS TWODOTS REAL 	{Printf.printf "%f\n" $5}
| MARKNORTH TWODOTS REAL  {Printf.printf "%f\n" $3}
| MARKEAST TWODOTS REAL  {Printf.printf "%f\n" $3}
| ALIGNMENT_FROM_TRUE TWODOTS STRINGS STRINGS STRINGS 	{}
| ANTENNA_RADOME_TYPE TWODOTS STRINGS DOT STRINGS STRINGS 	{Printf.printf "%s%c%s%s\n" $3 $4 $5 $6}
| RADOME_SERIAL_NUMBER TWODOTS STRINGS	{}
| ANTENNA_CABLE_TYPE TWODOTS STRINGS STRINGS {}
| ANTENNA_CABLE_LENGHT TWODOTS STRINGS  {}	
| DATE_INSTALLED TWODOTS DATAS {Printf.printf "%s\n" (String.uppercase $3)}
| DATE_REMOVED TWODOTS DATAS {Printf.printf "%s\n" (String.uppercase $3)}
| ADDITIONAL_INFORMATION TWODOTS STRINGS {Printf.printf "%s\n" $3}
;
