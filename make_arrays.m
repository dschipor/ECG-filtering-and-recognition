function [A w] = make_arrays(P,f)

 n = 4; %numarul de semnale relevante
 A = zeros(1,n);%vector amplitudini relevante
 w = zeros(1,n);%vector pulsatii aferente
 k = 0; max = 0;
 for idx = 1: n
    max = 0; k = 0;
    for i = 1:length(P)
        
        if P(i) > max
            max = P(i);
            k = i;
        end
    end
    A(idx) = max;
    if k == 0
        w(idx) = 0;
    
    else
        w(idx) = f(k);
        P(k) = 0;
    end
    
 end

end