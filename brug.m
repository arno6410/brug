function [krachten] = brug(n) %n is aantal tuien per pylon

%% Constanten invoeren
lengte = 2.2;
hoogte = 0.5;
halveafstand = lengte/2;
afstand = (halveafstand-0.1)/n; %de afstand tussen 2 tuien op het wegdek
hoogteverschil = hoogte/n; %hoogteverschil tussen 2 tuien op de pylon
extrakrachtafstand = (lengte-0.2)/3 + 0.1; %hier grijpt de puntlast aan
hoek = atan(hoogte/(lengte/2)) * 180 / pi; %dezelfde hoek voor elke tui

afstanden = [];
hoogtes = [];
krachten = [];
huidigeafstand = 0.1;
huidigehoogte = 0;
minimum1 = 5000;
index1 = 0;

va = 400 * afstand;
N = va / sin(hoek);
Nh = cos(hoek) * N;

%% Afstanden en krachten berekenen voor elke tui
for i=1:2*n
    if(i ~= n+1)
       huidigeafstand = huidigeafstand + afstand; 
    end
    afstanden = [afstanden huidigeafstand];
    
    if(mod(i,2) == 0)
        huidigehoogte = huidigehoogte + hoogteverschil;
        hoogtes = [hoogtes huidigehoogte];
    end
    
    if(abs(huidigeafstand-extrakrachtafstand) < minimum1)
        minimum2 = minimum1;
        minimum1 = abs(huidigeafstand-extrakrachtafstand);
        index2 = index1;
        index1 = i;
    end
    krachtvector = [afstanden(i);N;Nh];
    krachten = [krachten krachtvector]; 
end

%% Rekening houden met de puntlast op 66 cm
%Deze valt juist op een tui als we een veelvoud van 3 gebruiken
if (abs(extrakrachtafstand-(afstanden(index1))) < 0.05)
    va = 400 * afstand + 200;
    N = va / sin(hoek);
    Nh = cos(hoek) * N;
    krachtvector = [afstanden(index1);N;Nh];
    disp(krachten)
    disp(krachtvector)
    krachten(:,index1) = krachtvector;
    disp(krachtvector)
end

%% Naar excel schrijven
titel = int2str(n) + "tuien.xlsx";
convertStringsToChars(titel)
disp(titel)
xlswrite(titel,krachten)
end