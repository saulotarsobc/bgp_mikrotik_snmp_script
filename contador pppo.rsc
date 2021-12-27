# Contador de pppoes por pppoe server
:global lista [/interface pppoe-server server find disabled~"false"];

:foreach i in=$lista do={
    global $i [/interface pppoe-server> print count-only where service=$i]
    :put [/interface pppoe-server server get value-name=service-name $i];
    # :delay 1s;
}



#########

