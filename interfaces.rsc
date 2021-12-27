:put "["; #ABRE JSON
:local lista [/interface ethernet find running~"true"];
:local contador 0;
:foreach i in=$lista do={\
    # GET
    :local name [/interface ethernet get $i name];
    :local comment [/interface ethernet get $i comment];
    :local linkDowns  [/interface get $i link-downs];

    # MONITOR
    :local monitor [/interface ethernet monitor $i once as-value];
        :local sfpTxPower ($monitor->"sfp-tx-power");
        :local sfpRxPower ($monitor->"sfp-rx-power");
        :local sfpTemperature ($monitor->"sfp-temperature");
        :local rate ($monitor->"rate");
        :local sfpVendorSerial ($monitor->"sfp-vendor-serial");
        :local sfpSupplyVoltage ($monitor->"sfp-supply-voltage");
        :local sfpTxBiasCurrent ($monitor->"sfp-tx-bias-current");

    # JSON
    :set contador ($contador + 1);
        :if ( $contador < [:len $lista]) do={
            :put "{\"name\":\"$name\",\"comment\":\"$comment\",\"linkDowns\":\"$linkDowns\",\"sfpTxPower\":\"$sfpTxPower\",\"sfpRxPower\":\"$sfpRxPower\",\"sfpTemperature\":\"$sfpTemperature\",\"rate\":\"$rate\",\"sfpVendorSerial\":\"$sfpVendorSerial\",\"sfpSupplyVoltage\":\"$sfpSupplyVoltage\",\"sfpTxBiasCurrent\":\"$sfpTxBiasCurrent\"},";
        } else={
            :put "{\"name\":\"$name\",\"comment\":\"$comment\",\"linkDowns\":\"$linkDowns\",\"sfpTxPower\":\"$sfpTxPower\",\"sfpRxPower\":\"$sfpRxPower\",\"sfpTemperature\":\"$sfpTemperature\",\"rate\":\"$rate\",\"sfpVendorSerial\":\"$sfpVendorSerial\",\"sfpSupplyVoltage\":\"$sfpSupplyVoltage\",\"sfpTxBiasCurrent\":\"$sfpTxBiasCurrent\"}";
        };
}
:put "]"; #FECHA JSON