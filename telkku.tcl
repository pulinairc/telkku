# telkku.tcl - TV shows for Eggdrop IRC bot
# by Roni "rolle" Laukkarinen
# rolle @ irc.quakenet.org, rolle_ @ IRCnet

# Updated when:
set versijonummero "0.3.20150618"
#------------------------------------------------------------------------------------
# Elä herran tähen mäne koskemaan tai taivas putoaa niskaas!
# Minun reviiri alkaa tästä.

package require Tcl 8.5
package require http 2.1
package require tdom

bind pub - !tv pub:telkku

set tvurl "http://telkussa.fi/RSS/Channel/1" 

proc pub:telkku { nick uhost hand chan text } { 

    if {[string trim $text] ne ""} {

        if {[string trim $text] eq "tv1"} { 
            set tvurl "http://telkussa.fi/RSS/Channel/1" 
        }

        if {[string trim $text] eq "tv2"} { 
            set tvurl "http://telkussa.fi/RSS/Channel/2" 
        }

        if {[string trim $text] eq "mtv3"} { 
            set tvurl "http://telkussa.fi/RSS/Channel/3" 
        }

        if {[string trim $text] eq "nelonen"} { 
            set tvurl "http://telkussa.fi/RSS/Channel/4" 
        }

        if {[string trim $text] eq "subtv"} { 
            set tvurl "http://telkussa.fi/RSS/Channel/5" 
        }

        if {[string trim $text] eq "yleteema"} { 
            set tvurl "http://telkussa.fi/RSS/Channel/14" 
        }

        if {[string trim $text] eq "jim"} { 
            set tvurl "http://telkussa.fi/RSS/Channel/56" 
        }

        if {[string trim $text] eq "liv"} { 
            set tvurl "http://telkussa.fi/RSS/Channel/63" 
        }

        if {[string trim $text] eq "mtv"} { 
            set tvurl "http://telkussa.fi/RSS/Channel/63" 
        }

        if {[string trim $text] eq "hero"} { 
            set tvurl "http://telkussa.fi/RSS/Channel/103" 
        }

    } else {
        
        global tvurl
        putserv "PRIVMSG $chan :\002!tv\002 kanava (oletus: tv1, tämänhetkiset kanavat: tv1, tv2, mtv3, nelonen, subtv, yleteema, jim, mtv, hero)"
    
    }

    set kanavasivu [::http::data [::http::geturl $tvurl]]
    set doc [dom parse $kanavasivu]
    set root [$doc documentElement]
    set titleList [$root selectNodes /rss/channel/item/title/text()]
    set ohjelmanimi [lindex $titleList 0]
    set descList [$root selectNodes /rss/channel/item/description/text()]
    set kuvaus [lindex $descList 0]

    if {[string trim $text] ne ""} {

        putserv "PRIVMSG $chan :\002$text\002: \002[$ohjelmanimi nodeValue]\002 - Kuvaus: [encoding convertfrom utf-8 [$kuvaus nodeValue]]"

    } else {

        putserv "PRIVMSG $chan :\002tv1\002: \002[$ohjelmanimi nodeValue]\002 - Kuvaus: [encoding convertfrom utf-8 [$kuvaus nodeValue]]"
    }
}

# Kukkuluuruu.
putlog "Rolle's telkku.tcl (version $versijonummero) LOADED!"