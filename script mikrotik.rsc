:put "["; #abre json

:global lista [/routing bgp peer find];
:global contador 0;
:foreach i in=$lista do={;
    :global name [/routing bgp peer get value-name=name number=$i];
    :global prefix [/routing bgp peer get value-name=prefix number=$i];
    :global state [/routing bgp peer get value-name=state number=$i];
    :global remoteAS [/routing bgp peer get value-name=remote-as number=$i];
    :global disabled [/routing bgp peer get value-name=disabled number=$i];
    :global uptime [/routing bgp peer get value-name=uptime number=$i];
    :global remoteAddress [/routing bgp peer get value-name=remote-address number=$i];
    :set contador ($contador + 1);
    :if ( $contador < [:len $lista]) do={\
        :put "{\"NAME\":\"$name\",\"REMOTEAS\":\"$remoteAS\",\"DISABLED\":\"$disabled\",\"PREFIX\":\"$prefix\",\"STATE\":\"$state\",\"UPTIME\":\"$uptime\",\"REMOTEADDRESS\":\"$remoteAddress\"},";
    } else={\
        :put "{\"NAME\":\"$name\",\"REMOTEAS\":\"$remoteAS\",\"DISABLED\":\"$disabled\",\"PREFIX\":\"$prefix\",\"STATE\":\"$state\",\"UPTIME\":\"$uptime\",\"REMOTEADDRESS\":\"$remoteAddress\"}";
    };
};

:put "]"; #fecha json