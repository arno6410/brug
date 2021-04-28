function [N] = krachten_tuien_asym()
l_wegdek = 2.2;
l = 2;
n = 5; %aantal tuien
hoek = atan(0.23/0.767);
tuiposities = [0.333 0.667 0.96 1.333 1.667];
tuihoogtes = [0.13 0.23 0.343 0.23 0.13];
va = [];
N = [];

afstand12 = tuiposities(1) + (tuiposities(2)-tuiposities(1))/2; %positie tussen tui 1 en 2
afstand23 = tuiposities(2) + (tuiposities(3)-tuiposities(2))/2;
afstand34 = tuiposities(3) + (tuiposities(4)-tuiposities(3))/2;
afstand45 = tuiposities(4) + (tuiposities(5)-tuiposities(4))/2;
va = [va afstand12*400];
va = [va (afstand23-afstand12)*400 + 200];
va = [va (afstand34-afstand23)*400];
va = [va (afstand45-afstand34)*400];
va = [va (l - afstand45)*400];

for i=1:n
    N = [N (va(i) / sin(hoek))];
end

matrix = [tuiposities;N];

xlswrite('finalekrachten.xlsx',matrix)
end