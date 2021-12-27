:put "["; #ABRE JSON
:global lista [/interface ethernet find running~"true"];
:global contador 0;
:foreach i in=$lista do={\
    # GET
    :global name [/interface ethernet get $i name];
    :global comment [/interface ethernet get $i comment];
    :global linkdowns  [/interface get $i link-downs];
    :global rxbyte  [/interface get $i rx-byte];
    :global txbyte  [/interface get $i tx-byte];

    # MONITOR
    :global monitor [/interface ethernet monitor $i once as-value];
        :global sfpTxPower ($monitor->"sfp-tx-power");
        :global sfpRxPower ($monitor->"sfp-rx-power");
        :global sfpTemperature ($monitor->"sfp-temperature");
        :global rate ($monitor->"rate");
        :global sfpVendorSerial ($monitor->"sfp-vendor-serial");
        :global sfpSupplyVoltage ($monitor->"sfp-supply-voltage");
        :global sfpTxBiasCurrent ($monitor->"sfp-tx-bias-current");

    # JSON
    :set contador ($contador + 1);
        :if ( $contador < [:len $lista]) do={
            :put "{\"name\":\"$name\",\"comment\":\"$comment\",\"linkdowns\":\"$linkdowns\",\"rxbyte\":\"$rxbyte\",\"txbyte\":\"$txbyte\",\"sfpTxPower\":\"$sfpTxPower\",\"sfpRxPower\":\"$sfpRxPower\",\"sfpTemperature\":\"$sfpTemperature\",\"rate\":\"$rate\",\"sfpVendorSerial\":\"$sfpVendorSerial\",\"sfpSupplyVoltage\":\"$sfpSupplyVoltage\",\"sfpTxBiasCurrent\":\"$sfpTxBiasCurrent\"},";
        } else={
            :put "{\"name\":\"$name\",\"comment\":\"$comment\",\"linkdowns\":\"$linkdowns\",\"rxbyte\":\"$rxbyte\",\"txbyte\":\"$txbyte\",\"sfpTxPower\":\"$sfpTxPower\",\"sfpRxPower\":\"$sfpRxPower\",\"sfpTemperature\":\"$sfpTemperature\",\"rate\":\"$rate\",\"sfpVendorSerial\":\"$sfpVendorSerial\",\"sfpSupplyVoltage\":\"$sfpSupplyVoltage\",\"sfpTxBiasCurrent\":\"$sfpTxBiasCurrent\"}";
        };
}
:put "]"; #FECHA JSON