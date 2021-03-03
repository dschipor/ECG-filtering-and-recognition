function Problema1

    t = -10:0.01:10;
    k = 100;
    
    %daca i se da lui h forma unei functii original,
    %atunci se poate studia modificarea amplitudinii
    %si a defazajului in urma convolutiei prin fft
    
    %altfel, valorile semnalului in urma convolutiei
    %vor fi foarte mari, din cauza exponentialei pentru
    %t < 0
    for i = 1:length(t)
        if t(i) < 0
            h(i) = 0; %h functie original
        else
            h(i) = exp( (-1) * k * t(i));
        end
    end
    u = cos(100 * t + pi / 3); %semnal intrare
    H = conv(h,u,'same');
    Fs = 100; %frecventa de sample pentru fft
    L = 2000; %numarul de sample-uri
    f = Fs *(1:(L/2))/L; %vector de frecvente, va fi axa in grafice 

    %fft(u) merge cel mai bine L putere a lui 2
    %pentru ca L nu este putere a lui 2, se alege forma
    Y = fft(u,L); 
    P2 = abs(Y/L);
    P1 = P2(1:L/2+1);
    P1(2:end-1) = 2 * P1(2:end-1); %axa pentru amplitudine
    
    
    threshold = max(abs(Y))/10000; %toleranta numere mici
    Y1 = Y;
    %se scot din Y numerele foarte mici; ele perturba arctangenta
    Y1(abs(Y) < threshold) = 0; 
    
    %calculul fazei in grade
    %unghiul aferent lui Y(i) este argumentul sau
    
    p = angle(Y1) * 180 / pi;  
    
    figure(1)
    subplot(2,2,1);
    plot(t,u);
    xlabel('t');
    ylabel('u(t)');
    title('Semnal intrare');
    
    subplot(2,2,2);
    plot(f, P1(1:length(f)));
    xlabel('f');
    ylabel('P(f)');
    title('FFT semnal intrare')
    
    subplot(2,2,3)
    plot(f,p(1:length(f)));
    xlabel('f');
    ylabel('def(f)');
    title('Defazaj semnal intrare');


    %se procedeaza la fel pentru semnalul de iesire
    %in urma convolutiei
    Y2 = fft(H,L);
    P2 = abs(Y2/L);
    P1 = P2(1:L/2+1);
    P1(2:end-1) = 2*P1(2:end-1); 
    threshold = max(abs(Y2))/10000;
    Y3 = Y2;
    Y3(abs(Y2) < threshold) = 0;
    p1 = angle(Y3) * 180 / pi;
  

    figure(2)

    subplot(2,2,1);
    plot(t,H(1:length(t)));
    xlabel('t');
    ylabel('y(t)');
    title('Semnal iesire');
    
    subplot(2,2,2);
    plot(f, P1(1:length(f)));
    xlabel('f');
    ylabel('P(f)');
    title('FFT semnal iesire');

    subplot(2,2,3);
    plot(f,p1(1:length(f)));
    xlabel('f');
    ylabel('def(f)');
    title('Defazaj semnal iesire');
    
    %OBSERVATII IN GRAFICE
    %semnalul de intrare u = 1 * cos( 100 * t + pi/3)
    
    
    %pe semnalul original amplitudinea este aproape de 1
    %(P1(2:end-1) = 2 * P1(2:end-1); dubleaza eroarea de dupa fft)
    %frecventa este in jurul lui 16, iar 16 * 2 *pi ~ 100;
    %defazajul este de 60, respectiv -130, pentru f = 16;
    %(e posibil sa fie probleme de cadran)
    %se observa ca semnalul de intrare a fost descompus corect
    
    %in urma convolutiei, pentru k = {20,60,100}
    
    %amplitudinea creste, ramane in jurul lui 1
    %(creste in 20 si in 60, dar scade putin in 100)
    %defazajul se modifica, insa stiu sa explic cum si de ce

end