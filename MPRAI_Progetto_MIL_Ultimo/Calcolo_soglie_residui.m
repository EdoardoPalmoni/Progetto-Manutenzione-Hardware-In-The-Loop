%% ========================================================================
%% CALCOLO ANALITICO SOGLIE 3-SIGMA (FIRMA DEL GUASTO CON DOBC E LAPLACE)
%% ========================================================================
disp('--- Avvio calcolo soglie statistiche (Blanking time: 1 sec) ---');

% Definisci da quale campione iniziare (1000 = 1 secondo)
start_idx = 1000; 

%% 1. MODULO FD-2: ATTUATORI (Forza Z da Laplace + Coppie da DOBC)

% --- ESTRAZIONE ROBUSTA FORZA Z (DA EQUAZIONE DI PARITÀ LAPLACE) ---
if exist('out', 'var') && isprop(out, 'r_forza_z_Laplace')
    ts_act = out.r_forza_z_Laplace;
elseif exist('r_forza_z_Laplace', 'var')
    ts_act = r_forza_z_Laplace;
else
    error('ERRORE: r_forza_z_Laplace non trovato. Assicurati di aver collegato un blocco "To Workspace" all''uscita della Transfer Fcn e di averlo chiamato "r_forza_z_Laplace".');
end

% Gestione automatica del formato
N_samples = length(ts_act.Time);
if size(ts_act.Data, 1) == N_samples
    data_act_all = ts_act.Data; 
else
    data_act_all = reshape(ts_act.Data, [], N_samples)'; 
end

% Se il segnale è un vettore 3x1 prendi la componente Z (3), altrimenti (se è 1x1) prendi l'unica componente
if size(data_act_all, 2) >= 3
    data_fe_z = data_act_all(start_idx:end, 3);
else
    data_fe_z = data_act_all(start_idx:end, 1);
end

% --- ESTRAZIONE ROBUSTA COPPIE (DA DOBC) ---
if exist('out', 'var') && isprop(out, 'Me_B_hat')
    ts_me = out.Me_B_hat;
elseif exist('Me_B_hat', 'var')
    ts_me = Me_B_hat;
else
    error('ERRORE: Me_B_hat non trovata. Assicurati di aver salvato Me_B_hat nel workspace.');
end
N_samples = length(ts_me.Time);
if size(ts_me.Data, 1) == N_samples
    data_me_all = ts_me.Data; 
else
    data_me_all = reshape(ts_me.Data, [], N_samples)'; 
end
data_me = data_me_all(start_idx:end, :);

% Calcoli Statistici Attuatori
data_me_max = max(abs(data_me), [], 2);

mu_force = mean(data_fe_z);
sigma_force = std(data_fe_z);
Th_3sigma_force = abs(mu_force) + 3 * sigma_force;

mu_torque = mean(data_me_max);
sigma_torque = std(data_me_max);
Th_3sigma_torque = abs(mu_torque) + 3 * sigma_torque;


%% 2. MODULO FD-1: GIROSCOPIO
if exist('out', 'var') && isprop(out, 'r_gyro_norm')
    ts_gyro = out.r_gyro_norm;
elseif exist('r_gyro_norm', 'var')
    ts_gyro = r_gyro_norm;
else
    error('ERRORE: r_gyro_norm non trovato.');
end
N_samples = length(ts_gyro.Time);
if size(ts_gyro.Data, 1) == N_samples
    data_gyro_all = ts_gyro.Data; 
else
    data_gyro_all = reshape(ts_gyro.Data, [], N_samples)'; 
end
data_gyro = data_gyro_all(start_idx:end);

mu_gyro = mean(data_gyro);
sigma_gyro = std(data_gyro);
Th_3sigma_gyro = mu_gyro + 3 * sigma_gyro;


%% 3. MODULO FD-3: GPS
if exist('out', 'var') && isprop(out, 'r_gps_norm')
    ts_gps = out.r_gps_norm;
elseif exist('r_gps_norm', 'var')
    ts_gps = r_gps_norm;
else
    error('ERRORE: r_gps_norm non trovato.');
end
N_samples = length(ts_gps.Time);
if size(ts_gps.Data, 1) == N_samples
    data_gps_all = ts_gps.Data; 
else
    data_gps_all = reshape(ts_gps.Data, [], N_samples)'; 
end
data_gps = data_gps_all(start_idx:end);

mu_gps = mean(data_gps);
sigma_gps = std(data_gps);
Th_3sigma_gps = mu_gps + 3 * sigma_gps;

%% ========================================================================
%% STAMPA DEI RISULTATI
%% ========================================================================
fprintf('\n==================================================\n');
fprintf(' SOGLIE DIAGNOSTICHE CALCOLATE (REGOLA 3-SIGMA) \n');
fprintf('==================================================\n\n');
fprintf('--- MODULO FD-2: ATTUATORI (Forza + Coppie) ---\n');
fprintf('  Soglia FORZA Z (Laplace) [Th_3sigma_force]:   %.4f N\n', Th_3sigma_force);
fprintf('  Soglia COPPIE (DOBC)     [Th_3sigma_torque]:  %.4f N*m\n\n', Th_3sigma_torque);
fprintf('--- MODULO FD-1: GIROSCOPIO ---\n');
fprintf('  Soglia GIRO [Th_3sigma_gyro]:       %.4f rad/s\n\n', Th_3sigma_gyro);
fprintf('--- MODULO FD-3: GPS ---\n');
fprintf('  Soglia GPS  [Th_3sigma_gps]:        %.4f m\n', Th_3sigma_gps);
fprintf('==================================================\n');