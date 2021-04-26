%{ for i in range(length(dns)) ~}
    ${i + 1} : ${dns[i]} ${ip_adr[i]} ${pwd[i]} 
%{ endfor ~}

