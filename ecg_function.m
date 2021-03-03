function [person_id] = ecg_function(input_signal)

    Fs = 500;
    T = 1/Fs;
    L = 5000;
    t = (0:L-1) * T;
 
 
    f = Fs * (0:(L/2))/L;
    
    Y = fft(input_signal,L);
    P2 = abs(Y/L);
    P1 = P2(1:L/2+1);
    P1(2:end-1) = 2*P1(2:end-1);

    [A_INPUT, W_INPUT] = make_arrays(P1, f);
    person_id = 0;
    tolerance_A = 10000000;
    tolerance_W = 10000000;
    c = 'Person_';
    
    for idx = 1:90
        s = int2str(idx);
        if(idx < 10)
            s1 = int2str(0);
            idx_str = strcat(c,s1);
            idx_str = strcat(idx_str,s);
        else
           idx_str = strcat(c,s);
        end
        
        load(fullfile('ECG-DB', idx_str, 'rec_1m.mat'));
        [m,n] = size(val);
        
        clean = val(2, 1:n);
        
        Y = fft(clean,L);
        P2 = abs(Y/L);
        P1 = P2(1:L/2+1);
        P1(2:end-1) = 2*P1(2:end-1);
        [A_IDX, W_IDX] = make_arrays(P1, f);
        
        DISTANCE_A = sqrt(sum((A_INPUT - A_IDX) .^ 2));
        DISTANCE_W = sqrt(sum((W_INPUT - W_IDX) .^ 2));
        
        %person_id e dat de persoana cea mai apropiata cu A si W
        if DISTANCE_A < tolerance_A && DISTANCE_W <= tolerance_W
            tolerance_A = DISTANCE_A;
            tolerance_W = DISTANCE_W;
            person_id = idx;
        end
    
    end


end