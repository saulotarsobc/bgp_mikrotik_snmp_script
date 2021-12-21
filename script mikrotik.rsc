:global lista [/routing bgp peer find];
:global total [:len $lista];
:global contador 0;
:put "{";
:foreach i in=$lista do={;
    :set contador ($contador + 1);
    :local name [/routing bgp peer get value-name=name number=$i];
    :local prefix [/routing bgp peer get value-name=prefix number=$i];
    :local state [/routing bgp peer get value-name=state number=$i];
    :local remoteas [/routing bgp peer get value-name=remote-as number=$i];
    :local disabled [/routing bgp peer get value-name=disabled number=$i];
    :if ( disabled != true) do={\
        :if ( $contador < $total) do={\
            :put "\"$name\":{\"REMOTEAS\":\"$remoteas\",\"DISABLED\":\"$disabled\",\"PREFIX\":\"$prefix\",\"STATE\":\"$state\"},";
        } else={;\
            :put "\"$name\":{\"REMOTEAS\":\"$remoteas\",\"DISABLED\":\"$disabled\",\"PREFIX\":\"$prefix\",\"STATE\":\"$state\"}";
        };
    };
};
:put "}";