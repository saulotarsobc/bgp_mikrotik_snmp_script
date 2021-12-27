# Contador de pppoes por pppoe server
:global lista [/interface pppoe-server server find disabled~"false"];
:foreach i in=$lista do={
    :global server [/interface pppoe-server server get value-name=service-name number=$i];
    :global quantidade [/interface pppoe-server print count-only where service="$server"];
    # envio
    /tool fetch mode=https  http-method=put  keep-result=no \
        url=("https://URLAKI.firebaseio.com/".$server.".json") \
        http-data="{\"pppoe\":\"$quantidade\"}";
}