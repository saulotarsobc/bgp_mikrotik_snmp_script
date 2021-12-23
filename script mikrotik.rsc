:put "["; #abre json
:global lista [/routing bgp peer find];
:global contador 0;
:foreach i in=$lista do={
    :global name [/routing bgp peer get value-name=name number=$i];
    :global prefix [/routing bgp peer get value-name=prefix number=$i];
        :if (prefix < 1) do={:set prefix 0;}
    :global state [/routing bgp peer get value-name=state number=$i];
        :if (state = "idle") do={:set state 1;}; :if (state = "connect") do={:set state 2;}
        :if (state = "active") do={:set state 3;}; :if (state = "opensent") do={:set state 4;}
        :if (state = "openconfirm") do={:set state 5;}; :if (state = "established") do={:set state 6;}
    :global remoteAS [/routing bgp peer get value-name=remote-as number=$i];
    :global disabled [/routing bgp peer get value-name=disabled number=$i];
    :global uptime [/routing bgp peer get value-name=uptime number=$i];
        :if (uptime < 1) do={:set uptime 0;}
    :global remoteAddress [/routing bgp peer get value-name=remote-address number=$i];
    :global localAddress [/routing bgp peer get value-name=local-address number=$i];
    :global updatesSent  [/routing bgp peer get value-name=updates-sent number=$i];
        :if ((typeof $updatesSent) = "nil" ) do={:set $updatesSent "0";}
    :global updatesReceived [/routing bgp peer get value-name=updates-received number=$i];
        :if ((typeof $updatesReceived) = "nil" ) do={:set $updatesReceived "0";}
################
    :set contador ($contador + 1);
    :if ( $contador < [:len $lista]) do={
        :put "{\"NAME\":\"$name\",\"REMOTEAS\":\"$remoteAS\",\"DISABLED\":\"$disabled\",\"PREFIX\":\"$prefix\",\"STATE\":\"$state\",\"UPTIME\":\"$uptime\",\"REMOTEADDRESS\":\"$remoteAddress\",\"LOCALADDRESS\":\"$localAddress\",\"UPDATESSENT\":\"$updatesSent\",\"UPDATESRECEIVED\":\"$updatesReceived\"},";
    } else={
        :put "{\"NAME\":\"$name\",\"REMOTEAS\":\"$remoteAS\",\"DISABLED\":\"$disabled\",\"PREFIX\":\"$prefix\",\"STATE\":\"$state\",\"UPTIME\":\"$uptime\",\"REMOTEADDRESS\":\"$remoteAddress\",\"LOCALADDRESS\":\"$localAddress\",\"UPDATESSENT\":\"$updatesSent\",\"UPDATESRECEIVED\":\"$updatesReceived\"}";
    };
################
};
:put "]"; #fecha json
