:put "["; #abre json

:global lista [/routing bgp peer find];
:global contador 0;
:foreach i in=$lista do={;
    :local name [/routing bgp peer get value-name=name number=$i];
    :local prefix [/routing bgp peer get value-name=prefix number=$i];
    if (prefix < 1) do={
        :set prefix 0;
    }
    :local state [/routing bgp peer get value-name=state number=$i];
    :local remoteAS [/routing bgp peer get value-name=remote-as number=$i];
    :local disabled [/routing bgp peer get value-name=disabled number=$i];
    :local uptime [/routing bgp peer get value-name=uptime number=$i];
    :local remoteAddress [/routing bgp peer get value-name=remote-address number=$i];
    :local localAddress [/routing bgp peer get value-name=local-address number=$i];
    :set contador ($contador + 1);
    :if ( $contador < [:len $lista]) do={\
        :put "{\"NAME\":\"$name\",\"REMOTEAS\":\"$remoteAS\",\"DISABLED\":\"$disabled\",\"PREFIX\":\"$prefix\",\"STATE\":\"$state\",\"UPTIME\":\"$uptime\",\"REMOTEADDRESS\":\"$remoteAddress\",\"LOCALADDRESS\":\"$localAddress\"},";
    } else={\
        :put "{\"NAME\":\"$name\",\"REMOTEAS\":\"$remoteAS\",\"DISABLED\":\"$disabled\",\"PREFIX\":\"$prefix\",\"STATE\":\"$state\",\"UPTIME\":\"$uptime\",\"REMOTEADDRESS\":\"$remoteAddress\",\"LOCALADDRESS\":\"$localAddress\"}";
    };
};

:put "]"; #fecha json
