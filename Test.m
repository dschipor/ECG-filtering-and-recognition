function Test

     c = 'Person_';
     A = [1:90];
     B = zeros(1,90);
     for idx = 1:90
        s = int2str(idx);
        if(idx < 10)
            s1 = int2str(0);
            idx_str = strcat(c,s1);
            idx_str = strcat(idx_str,s);
        else
           idx_str = strcat(c,s);
        end
        load(fullfile('ECG-DB', idx_str, 'rec_1m.mat'));%rec_2m.mat
        
        [m n] = size(val);
        input_signal = val(1,1:n);%val(2,1:n);
        
        [person_id] = ecg_function_raw(input_signal,1);%input,signal,0
        B(idx) = person_id;

     end
    
    %compara daca s-au pus bine indecsii,
    %care ar trebui sa fie in ordine crescatoare,
    %dupa cum s-au citit fisierele
    accuracy = 0;
    for idx = 1:90
        if A(idx) == B(idx)
            accuracy = accuracy + 1;
        end
    end
    
    accuracy

end