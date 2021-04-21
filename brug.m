function [krachten] = brug(n)
lengte = 2.2;
hoogte = 0.5;
halveafstand = lengte/2;
afstand = (halveafstand-0.1)/n;
hoogteverschil = hoogte/n;

links = [];
rechts = [];
hoogtes = [];
huidigeafstand = 0.1;
huidigehoogte = 0;
extrakrachtafstand = (lengte-0.2)/3 +0.1;
minimum1 = 5000;
index1 = 0;
minimum2 = 5000;
index2 = 0;

for i=1:n
    huidigeafstand = huidigeafstand + afstand;
    huidigehoogte = huidigehoogte + hoogteverschil;
    links = [links huidigeafstand];
    rechts = [rechts lengte-huidigeafstand];
    hoogtes = [hoogtes huidigehoogte];
    
    if(abs(huidigeafstand-extrakrachtafstand) < minimum1)
        minimum2 = minimum1;
        minimum1 = abs(huidigeafstand-extrakrachtafstand);
        index2 = index1;
        index1 = i;
    end
end
hoek = atan(hoogte/(lengte/2)) * 180 / pi;

va = 400 * afstand;
N = va / sin(hoek);
Nh = cos(hoek) * N;

krachten = [];
for i=1:2*n
    krachtvector = [N;Nh]
    krachten = [krachten krachtvector]; 
end

if (abs(extrakrachtafstand-(links(index1))) < 0.05)
    va = 400 * afstand + 200;
    N = va / sin(hoek);
    Nh = cos(hoek) * N;
    krachtvector = [N;Nh];
    disp(krachten)
    disp(krachtvector)
    krachten(:,index1) = krachtvector;
    disp(krachtvector)
end
disp(links)
end