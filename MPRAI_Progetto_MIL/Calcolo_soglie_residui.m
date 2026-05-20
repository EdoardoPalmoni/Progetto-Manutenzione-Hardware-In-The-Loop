%% ========================================================================
%% CALCOLO ANALITICO DELLE SOGLIE 3-SIGMA PER TUTTI I RESIDUI (BASELINE)
%% ========================================================================
% Esegui questo script SUBITO DOPO aver completato la simulazione "Fault-Free"
% Le soglie calcolate verranno salvate nel workspace e saranno lette 
% automaticamente dai rispettivi blocchi "Compare to Constant" in Simulink.

%% 1. ESTRAZIONE DATI DAL WORKSPACE (Formato Timeseries)
data_gyro = r_gyro_norm.Data;
data_gps  = r_gps_norm.Data;
data_act  = r_act_norm.Data;

%% 2. CALCOLO STATISTICO - MODULO FD-1 (Giroscopio)
mu_gyro = mean(data_gyro);
sigma_gyro = std(data_gyro);
Th_3sigma_gyro = mu_gyro + 3 * sigma_gyro;

%% 3. CALCOLO STATISTICO - MODULO FD-2 (Attuatori Asse Z)
mu_act = mean(data_act);
sigma_act = std(data_act);
Th_3sigma_act = mu_act + 3 * sigma_act;

%% 4. CALCOLO STATISTICO - MODULO FD-3 (GPS / Posizione)
mu_gps = mean(data_gps);
sigma_gps = std(data_gps);
Th_3sigma_gps = mu_gps + 3 * sigma_gps;

%% ========================================================================
%% STAMPA DEI RISULTATI NELLA COMMAND WINDOW
%% ========================================================================
fprintf('\n==================================================\n');
fprintf('  ANALISI STATISTICA BASELINE (REGOLA DEL 3-SIGMA) \n');
fprintf('==================================================\n\n');

fprintf('--- MODULO FD-1: Giroscopio (Attitudine) ---\n');
fprintf('  Media (mu):                  %.4f rad/s\n', mu_gyro);
fprintf('  Deviazione Standard (sigma):  %.4f rad/s\n', sigma_gyro);
fprintf('  SOGLIA VARIABILE -> [Th_3sigma_gyro]: %.4f rad/s\n\n', Th_3sigma_gyro);

fprintf('--- MODULO FD-2: Attuatori (Spinta Asse Z) ---\n');
fprintf('  Media (mu):                  %.4f m/s²\n', mu_act);
fprintf('  Deviazione Standard (sigma):  %.4f m/s²\n', sigma_act);
fprintf('  SOGLIA VARIABILE -> [Th_3sigma_act]:  %.4f m/s²\n\n', Th_3sigma_act);

fprintf('--- MODULO FD-3: GPS (Dinamica Traslazionale) ---\n');
fprintf('  Media (mu):                  %.4f m\n', mu_gps);
fprintf('  Deviazione Standard (sigma):  %.4f m\n', sigma_gps);
fprintf('  SOGLIA VARIABILE -> [Th_3sigma_gps]:  %.4f m\n', Th_3sigma_gps);
fprintf('==================================================\n');