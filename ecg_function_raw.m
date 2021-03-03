function [person_id] = ecg_function_raw(input_signal,israw)

    if israw == 0
        [person_id] = ecg_function(input_signal);
    else
        [input_filtered] = noise_filter(input_signal);
        [person_id] = ecg_function(input_filtered);
    end

end