function [input_filtered] = noise_filter(input_signal)
        Fs = 500;
        new_input = detrend(input_signal); %am gasit ca ajuta la netezirea functiei
        order = 5; %parametru de "ordine" gasit prin cautari succesive
        fcuthigh = 0.67; %frecventa pentru highpass
        fcutlow = 40; %frecventa pentru lowpass
        
        %b si a sunt coeficientii functiei de transfer
        [b,a] = butter(order,[fcuthigh fcutlow]/(Fs/2), 'bandpass');
        %filtrul ar trebui, practic, sa faca o convolutie cu functia de
        %transfer
        input_filtered = filter(b,a,new_input);
end