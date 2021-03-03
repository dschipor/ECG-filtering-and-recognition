function Problema2

 load('rec_1m','-mat');
 [m,n] = size(val);
 
 raw = val(1, 1:n);
 clean = val(2, 1:n);
 
    Fs = 500;
    T = 1/Fs;
    L = n
    t = (0:L-1) * T;
 
 
    f = Fs * (0:(L/2))/L;
    Y = fft(clean,L);
    P2 = abs(Y/L);
    P1 = P2(1:L/2+1);
    P1(2:end-1) = 2*P1(2:end-1);
    
    [A_CLEAN, W_CLEAN] = make_arrays(P1,f);
    
    Y = fft(raw, L);
    P2 = abs(Y/L);
    P1 = P2(1:L/2+1);
    P1(2:end-1) = 2*P1(2:end-1);
    
    [A_RAW, W_RAW] = make_arrays(P1,f);
      
    tolerance_A = sqrt(sum((A_CLEAN - A_RAW) .^ 2))
    tolerance_W = sqrt(sum((W_CLEAN - W_RAW) .^ 2))
    
     raw_signal = detrend(raw); %remove zero offset
     order    = 0;
     
     for o = 1:9
        
                [b,a] = butter(2,[0.68,40]/(Fs/2), 'bandpass');
                filtered = filter(b,a,raw_signal);
        
                Y = fft(filtered, L);
                P2 = abs(Y/L);
                P1 = P2(1:L/2+1);
                P1(2:end-1) = 2*P1(2:end-1);
    
                [A_FILTERED, W_FILTERED] = make_arrays(P1,f);
        
                 %o;
      
                DISTANCE_A = sqrt(sum((A_CLEAN - A_FILTERED) .^ 2));
                DISTANCE_W = sqrt(sum((W_CLEAN - W_FILTERED) .^ 2));
        
                 if DISTANCE_A <= tolerance_A && DISTANCE_W <= tolerance_W
                    tolerance_A = DISTANCE_A
                    tolerance_W = DISTANCE_W
                    order = o;
                 end
           
       
     end
     
         order
        
end