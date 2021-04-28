clear; 
clc; 
%% gegevens
E_modulus_MDF = 4.19 * 1000000000;      % [Pa]
hoogte = 43/100;                        % [m]
hoogte_I_profiel = (18+6+6) / 1000;     % [m]
breedte = 18/1000;                      % [m]
dikte_tussenstuk = 6/1000;              % [m]
dikte_bovenvlak = 6/1000;               % [m]
kracht_pyloon = 500;                    % [N] -> 400 N/m verdeelde belasting + 200 N puntlast

%% Traagheidsmomenten
I_sterke_as = (breedte * (hoogte_I_profiel)^3 - (breedte - dikte_tussenstuk)*(hoogte_I_profiel - 2*dikte_bovenvlak)^3) / 12;    % [m^4]
I_zwakke_as = (dikte_bovenvlak * (breedte)^3) / 6 + ((hoogte_I_profiel - 2 * dikte_bovenvlak) * dikte_tussenstuk^3) / 12;       % [m^4]

%% Kniklasten
kritische_kniklast_zwakke_as = (2 * (pi)^2 * E_modulus_MDF * I_zwakke_as) / (hoogte)^2;       % [N]
kritische_kniklast_sterke_as = (1/4 * (pi)^2 * E_modulus_MDF * I_sterke_as) / (hoogte)^2;     % [N]

%% Printen van de uitkomst
disp(['Traagheidsmoment van de sterke as = ', num2str(I_sterke_as), ' m^4'])
disp(['Kritische kniklast van de sterke as = ', num2str(kritische_kniklast_sterke_as / 1000), ' kN'])
disp(['Traagheidsmoment van de zwakke as = ', num2str(I_zwakke_as), ' m^4'])
disp(['Kritische kniklast van de zwakke as = ', num2str(kritische_kniklast_zwakke_as / 1000), ' kN'])
