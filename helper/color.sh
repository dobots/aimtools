#!/bin/bash

################################################################################
# Enables colors
################################################################################

# Example usage:
# echo -e ${RedF}This text will be red!${Reset}
# echo -e ${BlueF}${BoldOn}This will be blue and bold!${BoldOff} - and this is just blue!${Reset}
# echo -e ${RedB}${BlackF}This has a red background and black font!${Reset}and everything after the reset is normal text!
colors() {
	Escape="\033";
	BlackF="${Escape}[30m"; RedF="${Escape}[31m";   GreenF="${Escape}[32m";
	YellowF="${Escape}[33m";  BlueF="${Escape}[34m";    PurpleF="${Escape}[35m";
	CyanF="${Escape}[36m";    WhiteF="${Escape}[37m";
	BlackB="${Escape}[40m";     RedB="${Escape}[41m";     GreenB="${Escape}[42m";
	YellowB="${Escape}[43m";    BlueB="${Escape}[44m";    PurpleB="${Escape}[45m";
	CyanB="${Escape}[46m";      WhiteB="${Escape}[47m";
	BoldOn="${Escape}[1m";      BoldOff="${Escape}[22m";
	ItalicsOn="${Escape}[3m";   ItalicsOff="${Escape}[23m";
	UnderlineOn="${Escape}[4m";     UnderlineOff="${Escape}[24m";
	BlinkOn="${Escape}[5m";   BlinkOff="${Escape}[25m";
	InvertOn="${Escape}[7m";  InvertOff="${Escape}[27m";
	Reset="${Escape}[0m";
}

colors

msg_hello() {
                                          
echo -e ${BlueF}                                         
echo "                                         iYi              "
echo "                                       ti+==+i            "
echo "                                      It+====it           "
echo "                                     IIti===+iII          "
echo "                               =:    IIIti++itII          "
echo "                               +t    XIIIttttIII          "
echo "                               +     tRRIRiRIIRR     #    "
echo "                              t      t+=:V+:X;+i     +    "
echo "                              ;      t+=:.B.:;+i     =    "
echo "                        Itii+ ;       +;:. ,:;+   ti=R+   "
echo "                      Itti+++RR+       ;:. ,:=   It+===i  "
echo "                    IItti++====++i              IIIi+=+tY "
echo "                   IIItti+======++i             YIIttitII "
echo "                  IIIItii+=======+it  t=t       iRIIRIIII "
echo "                 IIIIItii+=======+it RI++  ;    i=:iRRRRY "
echo "                 IIIIItti+======++itI =    +    i=:.B:;+# "
echo "                RVIIIItti++====++ittI            ;: .:=i  "
echo "                tRIIIIItti++++++iitII       ;       .:    "
echo "                ttRYIIIIttiiiiiiittIII      + i+          "
echo "                tiiRRIIIItttiittttIIII     tR+===++       "
echo "                ti+=RRRIRRRRttttIIIIII   IIti+====+i      "
echo "                ti+=;iRRt iRRIIIIIIIII  YIIt+=====+it     "
echo "                ii+=;::R=RRR+IIIIIIIR   IIIti+====+itI    "
echo "                t++=;:,.RRR.RRRRRRRRX  IIIIti++==++itI    "
echo "                 +=;;:,.RRRR,:;;=+iit  IIIIIti+++iitIYR   "
echo "                 +=;;:,.  .,::;==+ii   IIIIIIttiittIXRt   "
echo "                  =;:,,.  .,:;;=++it   IIIIIIIRRRIIRR+i   "
echo "                   ;:,..  .,:;;=+ii    IIIIIIYRR=RR;=+i   "
echo "                  ..:,.  .,,:;==+      RRRYVXRR+.R:;=+i   "
echo "                  .,:;.  .,::;==.      ttiVVi,RRR,:;=+    "
echo "                  .,,:;==:,:;:,..       ti+=;:,  .,:;=    "
echo "                   .,,::;;;::,..         i+=;:,. .,:;     "
echo "                    ...,,,,,..            +=;:,. .,:.     "
echo "                                           +=;:.  ,,.     "
echo "                                           .,::;;:,.      "
echo "                                            ..,,,..       "
echo -e ${Reset}
}
                                          
msg_prefix="#"
msg_init() {
	msg_prefix=$1
	msg_hello
}

msg_error() {
	echo -e ${RedF}"[$msg_prefix] $(date +"%x %R") - Error: $1"${Reset}
}

msg_warning() {
	echo -e ${YellowF}"[$msg_prefix] $(date +"%x %R") - Warning: $1"${Reset}
}

msg_info() {
	echo -e ${GreenF}"[$msg_prefix] $(date +"%x %R") - Info: $1"${Reset}
}

msg_debug() {
	echo -e ${BlueF}"[$msg_prefix] $(date +"%x %R") - Debug: $1"${Reset}
}

binary_question() {
	# allows for a second optional argument
	local __result=$2
	# if not set the result will be an echo (not so useful in this context)
	local myresult=0
	local questionstr="$1"

	echo -en ${GreenF}"[$msg_prefix] $(date +"%x %R") - Question: $questionstr"${Reset}
	
	read input
	if [[ "$input" == "y" ]]; then
		myresult=1
	fi

	if [[ "$__result" ]]; then
		eval $__result="'$myresult'"
	else
		echo "$myresult"
	fi
}

question() {
	# allows for a second optional argument
	local __result=$2
	# if not set the result will be an echo (not so useful in this context)
	local myresult=""
	local questionstr="$1"

	echo -en ${GreenF}"[$msg_prefix] $(date +"%x %R") - Question: $questionstr"${Reset}
	
	read myresult

	if [[ "$__result" ]]; then
		eval $__result="'$myresult'"
	else
		echo "$myresult"
	fi
}

