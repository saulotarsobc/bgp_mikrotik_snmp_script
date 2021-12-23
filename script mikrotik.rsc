:put "["; #abre json
:global lista [/routing bgp peer find];
:global contador 0;
:foreach i in=$lista do={
    :global name [/routing bgp peer get value-name=name number=$i];
    :global prefix [/routing bgp peer get value-name=prefix number=$i];
        :if (prefix < 1) do={:set prefix 0;}
    :global state [/routing bgp peer get value-name=state number=$i];
        :if (state = "idle") do={:set state 1;}
        :if (state = "connect") do={:set state 2;}
        :if (state = "active") do={:set state 3;}
        :if (state = "opensent") do={:set state 4;}
        :if (state = "openconfirm") do={:set state 5;}
        :if (state = "established") do={:set state 6;}
    :global remoteAS [/routing bgp peer get value-name=remote-as number=$i];
    :global disabled [/routing bgp peer get value-name=disabled number=$i];
    :global uptime [/routing bgp peer get value-name=uptime number=$i];
    :global remoteAddress [/routing bgp peer get value-name=remote-address number=$i];
    :global localAddress [/routing bgp peer get value-name=local-address number=$i];
    :set contador ($contador + 1);
    :if ( $contador < [:len $lista]) do={
        :put "{\"NAME\":\"$name\",\"REMOTEAS\":\"$remoteAS\",\"DISABLED\":\"$disabled\",\"PREFIX\":\"$prefix\",\"STATE\":\"$state\",\"UPTIME\":\"$uptime\",\"REMOTEADDRESS\":\"$remoteAddress\",\"LOCALADDRESS\":\"$localAddress\"},";
    } else={
        :put "{\"NAME\":\"$name\",\"REMOTEAS\":\"$remoteAS\",\"DISABLED\":\"$disabled\",\"PREFIX\":\"$prefix\",\"STATE\":\"$state\",\"UPTIME\":\"$uptime\",\"REMOTEADDRESS\":\"$remoteAddress\",\"LOCALADDRESS\":\"$localAddress\"}";
    };
};
:put "]"; #fecha json
