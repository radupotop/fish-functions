function ipinfo --description "Provide info about an IP" -a ipaddr
    curl -s "https://ipinfo.io/$ipaddr" | jq
end
