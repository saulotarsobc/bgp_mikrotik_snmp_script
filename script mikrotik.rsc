:global lista [/routing bgp peer find];
:global total [:len $lista];
:global contador 0;
:put "["; #abre json
:foreach i in=$lista do={;
    :set contador ($contador + 1);
    :local name [/routing bgp peer get value-name=name number=$i];
    :local prefix [/routing bgp peer get value-name=prefix number=$i];
    :local state [/routing bgp peer get value-name=state number=$i];
    :local remoteAS [/routing bgp peer get value-name=remote-as number=$i];
    :local disabled [/routing bgp peer get value-name=disabled number=$i];
    :local uptime [/routing bgp peer get value-name=uptime number=$i];
    :local remoteAddress [/routing bgp peer get value-name=remote-address number=$i];
    # "descomentar" a linha seguinte se NÃO quiser monitorar os peer's desabilidados
    #:if ( disabled = false) do={\
        :if ( $contador < $total) do={\
            :put "{\"NAME\":\"$name\",\"REMOTEAS\":\"$remoteAS\",\"DISABLED\":\"$disabled\",\"PREFIX\":\"$prefix\",\"STATE\":\"$state\",\"UPTIME\":\"$uptime\",\"REMOTEADDRESS\":\"$remoteAddress\"},";
        } else={\
            :put "{\"NAME\":\"$name\",\"REMOTEAS\":\"$remoteAS\",\"DISABLED\":\"$disabled\",\"PREFIX\":\"$prefix\",\"STATE\":\"$state\",\"UPTIME\":\"$uptime\",\"REMOTEADDRESS\":\"$remoteAddress\"}";
        };
    # "descomentar" a linha seguinte se NÃO quiser monitorar os peer's desabilidados
    #};
};
:put "]"; #fecha json