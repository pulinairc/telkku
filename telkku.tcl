# telkku.tcl - TV shows for Eggdrop IRC bot
# by Roni "rolle" Laukkarinen
# rolle @ irc.quakenet.org, rolle_ @ IRCnet

# Updated when:
set versijonummero "0.2.20150616"
#------------------------------------------------------------------------------------
# Elä herran tähen mäne koskemaan tai taivas putoaa niskaas!
# Minun reviiri alkaa tästä.

package require Tcl 8.5
package require http 2.1
package require tdom

bind pub - !tv pub:telkku

proc pub:telkku { nick uhost hand chan text } { 

    if {[string trim $text] ne ""} {

    	if {[string trim $text] eq "tv1"} { 
    		set tvurl "http://telkussa.fi/RSS/Channel/1" 
    	}
  			  		
	} else {
		
		putserv "PRIVMSG $chan :\002!tv\002 kanava (tämänhetkiset kanavat: tv1)"
    
    }

    set kanavasivu [::http::data [::http::geturl $tvurl]]
    set doc [dom parse $kanavasivu]
    set root [$doc documentElement]
    set titleList [$root selectNodes /rss/channel/item/title/text()]
    set ohjelmanimi [lindex $titleList 0]
    set descList [$root selectNodes /rss/channel/item/description/text()]
    set kuvaus [lindex $descList 0]

	putserv "PRIVMSG $chan :\002$text\002: \002[$ohjelmanimi nodeValue]\002 - Kuvaus: [$kuvaus nodeValue]"
	# putlog "PRIVMSG $chan :\002$text\002: $kello \002$ohjelma\002 $kuvaus"

}

# Kukkuluuruu.
putlog "Rolle's telkku.tcl (version $versijonummero) LOADED!"