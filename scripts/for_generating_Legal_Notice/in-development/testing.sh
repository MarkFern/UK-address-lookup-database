#!/bin/bash

more Page_1.json |  sed -E 's/^[[:space:]]*\{([[:space:]]*\"([^\"\\\cG\cH\cI\cJ\cK\cL\cM\cZ\c[\x00]|\\([\"\\\/bfnrt]|u[0-9A-F]{4}))+\"[[:space:]]*:[[:space:]]*(\{[[:space:]]*\"([^\"\\\cG\cH\cI\cJ\cK\cL\cM\cZ\c[\x00]|\\([\"\\\/bfnrt]|u[0-9A-F]{4}))+\"[[:space:]]*:[[:space:]]*)*(\"([^\"\\\cG\cH\cI\cJ\cK\cL\cM\cZ\c[\x00]|\\([\"\\\/bfnrt]|u[0-9A-F]{4}))+\"|[0-9]+)[[:space:]]*}?[[:space:]]*,?[[:space:]]*)+\"contributors\"[[:space:]]*:[[:space:]]*\[[[:space:]]*//i' | more 






# SED code for matching JSON string token,
#sed  -E 's/([^\"\\\cG\cH\cI\cJ\cK\cL\cM\cZ\c[\x00]|\\([\"\\\/bfnrt]|u[0-9A-F]{4}))/__TEST___/i'


# Control characters escaped according to `Sed` specs: \x00 \cG \cH \cI \cJ \cK \cL \cM \cZ \c[
#           ([^\"\\\cG\cH\cI\cJ\cK\cL\cM\cZ\c[\x00]|\\([\"\\\/bfnrt]|u[0-9A-F]{4}))



############################ NOTES ############################

# REGULAR EXPRESSION FOR MATCHING BEGINNING OF JSON BEFORE CONTRIBUTOR NAMES BEGIN.
# PRETTY-PRINTED FORM USING RECURSION:
# 	[[:space:]]*\{
# 	(
# 						[[:space:]]*
# 								\"([^\"\\\cG\cH\cI\cJ\cK\cL\cM\cZ\c[\x00]|\\([\"\\\/bfnrt]|u[0-9A-F]{4}))+\"
# 						[[:space:]]*
# 								:
# 						[[:space:]]*
# 													(
# 																	\{
# 																		(
# 																			(?R)
# 																		)*
# 																	\}?
# 															|
# 																	\"
# 																		([^\"\\\cG\cH\cI\cJ\cK\cL\cM\cZ\c[\x00]|\\([\"\\\/bfnrt]|u[0-9A-F]{4}))+
# 																	\"
# 															|
# 																	[0-9]+
# 													
# 													)+
# 			[[:space:]]*
# 			,?
# 			[[:space:]]*											
# 	)+
# WITHOUT RECURSION (BECAUSE `SED` COMMAND DOESN'T APPEAR TO SUPPORT RECURSIVE REGULAR EXPRESSIONS), AND CLOSE TO THE SAME:
# ^[[:space:]]*\{
# 	(
# 						[[:space:]]*
# 								\"([^\"\\\cG\cH\cI\cJ\cK\cL\cM\cZ\c[\x00]|\\([\"\\\/bfnrt]|u[0-9A-F]{4}))+\"
# 						[[:space:]]*
# 								:
# 						[[:space:]]*
# 						
# 																(
# 																	\{
# 																	[[:space:]]*
# 																			\"([^\"\\\cG\cH\cI\cJ\cK\cL\cM\cZ\c[\x00]|\\([\"\\\/bfnrt]|u[0-9A-F]{4}))+\"
# 																	[[:space:]]*
# 																			:
# 																	[[:space:]]*
# 																)*
# 						(
# 								\"
# 									([^\"\\\cG\cH\cI\cJ\cK\cL\cM\cZ\c[\x00]|\\([\"\\\/bfnrt]|u[0-9A-F]{4}))+
# 								\"
# 						|
# 								[0-9]+
# 						)
# 			[[:space:]]*
# 			}?
# 			[[:space:]]*
# 			,?
# 			[[:space:]]*											
# 	)+
# \"contributors\"[[:space:]]*:[[:space:]]*\[[[:space:]]*
# 
# ABOVE (NON-RECURSIVE REGEXP) ALL ON ONE LINE:	
# 	[[:space:]]*\{([[:space:]]*\"([^\"\\\cG\cH\cI\cJ\cK\cL\cM\cZ\c[\x00]|\\([\"\\\/bfnrt]|u[0-9A-F]{4}))+\"[[:space:]]*:[[:space:]]*(\{[[:space:]]*\"([^\"\\\cG\cH\cI\cJ\cK\cL\cM\cZ\c[\x00]|\\([\"\\\/bfnrt]|u[0-9A-F]{4}))+\"[[:space:]]*:[[:space:]]*)*(\"([^\"\\\cG\cH\cI\cJ\cK\cL\cM\cZ\c[\x00]|\\([\"\\\/bfnrt]|u[0-9A-F]{4}))+\"|[0-9]+)[[:space:]]*}?[[:space:]]*,?[[:space:]]*)+
