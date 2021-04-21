function [krachten] = brug_FINAAL() %n is aantal tuien links, m is aantal rechts
%op de extra last komen 2 tuien toe, een van links en een van rechts

%% Constanten invoeren
lengte = 2.2;
hoogte1 = 0.25;
hoogte2 = 0.45;
n = 2;
m = 4;
halveafstand = lengte/2;
afstand = (halveafstand-0.1)/3; %de afstand tussen 2 tuien op het wegdek
extrakrachtafstand = (lengte-0.2)/3 + 0.1; %hier grijpt de puntlast aan
hoek = atan(0.25/extrakrachtafstand); %dezelfde hoek voor elke tui
aantalsteunpunten = n + m - 1;

afstanden = [];
krachten = [];
huidigeafstand = 0.1;
huidigehoogte = 0.03;
hoogtes1 = [0.15 0.25];
hoogtes2 = [0.15 0.25 0.35 0.45];

va = 400 * 2/12;
N = va / sin(hoek);
Nh = cos(hoek) * N;

%% Afstanden en krachten berekenen voor elke tui
for i=1:aantalsteunpunten+1
    if(i == 1 || i == n + m)
        huidigeafstand = huidigeafstand + afstand;
        afstanden = [afstanden huidigeafstand];
        krachtvector = [afstanden(i);3*N;3*Nh];
        krachten = [krachten krachtvector];
    elseif(i == 2)
        huidigeafstand = huidigeafstand + afstand;
        afstanden = [afstanden huidigeafstand];
        krachtvector = [afstanden(i);N+100;Nh+cos(hoek)*100];
        krachten = [krachten krachtvector];
    elseif(i == 3)
        afstanden = [afstanden huidigeafstand];
        krachtvector = [afstanden(i);N+100;Nh+cos(hoek)*100];
        krachten = [krachten krachtvector];
    else
        huidigeafstand = huidigeafstand + afstand;
        afstanden = [afstanden huidigeafstand];
        krachtvector = [afstanden(i);2*N;2*Nh];
        krachten = [krachten krachtvector]; 
    end
   
end
disp(krachten)

%{
%% Rekening houden met de puntlast op 66 cm
%Deze valt juist op een tui als we een veelvoud van 3 gebruiken
if (abs(extrakrachtafstand-(afstanden(index1))) < 0.05)
    va = 400 * afstand + 200;
    N = va / sin(hoek);
    Nh = cos(hoek) * N;
    krachtvector = [afstanden(index1);N;Nh];
    krachten(:,index1) = krachtvector;
end
%}

%% Naar excel schrijven
xlswrite('asymmetrisch.xlsx',krachten)
end
