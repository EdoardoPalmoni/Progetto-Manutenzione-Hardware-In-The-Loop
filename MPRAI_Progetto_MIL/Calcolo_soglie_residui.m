%% ========================================================================
%% CALCOLO ANALITICO DELLE SOGLIE 3-SIGMA PER TUTTI I RESIDUI (BASELINE)
%% ========================================================================
% Esegui questo script SUBITO DOPO aver completato la simulazione "Fault-Free"
% Le soglie calcolate verranno salvate nel workspace e saranno lette 
% automaticamente dai rispettivi blocchi "Compare to Constant" in Simulink.

%% 1. ESTRAZIONE DATI DAL WORKSPACE (Formato Timeseries)
data_gyro = r_gyro_norm.Data;
data_gps  = r_gps_norm.Data;
% data_act  = r_act_norm.Data;

%% 2. CALCOLO STATISTICO - MODULO FD-1 (Giroscopio)
mu_gyro = mean(data_gyro);
sigma_gyro = std(data_gyro);
Th_3sigma_gyro = mu_gyro + 3 * sigma_gyro;

%% 3. CALCOLO STATISTICO - MODULO FD-2 (Attuatori Asse Z)
% mu_act = mean(data_act);
% sigma_act = std(data_act);
% Th_3sigma_act = mu_act + 3 * sigma_act;
%% 3. CALCOLO STATISTICO - MODULO FD-2 (Filtro Lead)
% % Attenzione: r_eq_norm è l'uscita del blocco Sqrt che creeremo al Passo 2
% data_eq = r_act_norm.Data;
% time_eq = r_act_norm.Time;
% 
% % Escludiamo i primi 10 secondi (transitorio di assestamento iniziale del drone)
% idx_steady = time_eq > 10;
% data_baseline = data_eq(idx_steady);
% 
% mu_act = mean(data_baseline);
% sigma_act = std(data_baseline);
% 
% % Usiamo 5-sigma per evitare falsi allarmi dovuti al rumore derivativo
% Th_5sigma_act = mu_act + 5 * sigma_act; 
%% CALCOLO SOGLIA BASELINE SU Fe_z (FD-2)
% % Assicurati di aver appena eseguito la simulazione Fault-Free
% 
% % Estrai i dati dal workspace
% t_fe = Fe_z_data.Time;
% data_fe = Fe_z_data.Data;
% 
% % Escludi i primi 10 secondi (assestamento del decollo)
% idx_steady = t_fe > 10;
% data_baseline = data_fe(idx_steady);
% 
% % Calcola media e deviazione standard
% mu_fe = mean(data_baseline);
% sigma_fe = std(data_baseline);
% 
% % Il guasto al motore causa una PERDITA di spinta, quindi il DOBC
% % vedrà una forza fittizia verso l'alto (positiva o negativa a seconda 
% % della convenzione del tuo frame). Guardiamo la tolleranza massima:
% Th_upper = mu_fe + 4 * sigma_fe;
% Th_lower = mu_fe - 4 * sigma_fe;
% 
% fprintf('--- FD-2 BASELINE ---\n');
% fprintf('Media: %.4f N\n', mu_fe);
% fprintf('Banda di Tolleranza: [%.4f,  %.4f] N\n', Th_lower, Th_upper);
%% Calibrazione soglia FD-2 — DOPO run fault-free
% % Il segnale r_det è già detrended (uscita del blocco Sum dopo LPF)
% 
% t        = r_act_z.Time;
% r_det    = r_act_z.Data;   % scalare, già detrended
% 
% % Escludi: transitorio DOBC iniziale (t<15s) + eventuale cambio traiettoria
% idx = t > 15;
% r_baseline = r_det(idx);
% 
% mu_det    = mean(r_baseline);
% sigma_det = std(r_baseline);
% 
% % Soglia per shift NEGATIVI (il guasto abbassa r_det)
% N_sigma       = 3;
% Th_FD2_neg    = mu_det - N_sigma * sigma_det;
% 
% fprintf('=== CALIBRAZIONE FD-2 ===\n');
% fprintf('mu    = %.5f\n', mu_det);
% fprintf('sigma = %.5f\n', sigma_det);
% fprintf('Th_FD2_neg (soglia allarme) = %.5f\n', Th_FD2_neg);
% 
% % Verifica: il guasto scende a circa -0.30 → soglia deve stare tra 0 e -0.30
% fprintf('\nPicco guasto atteso: ~ -0.30 → soglia %.5f è %s\n', ...
%     Th_FD2_neg, string(Th_FD2_neg > -0.30));

%% CALCOLO SOGLIE 6 CANALI — fix dimensioni
t_det = r_det6.Time;          % [300001 × 1]
data6 = r_det6.Data;          % [6 × 1 × 300001] — dimensione sbagliata

% Riorganizza la matrice: porta il tempo sulla prima dimensione
% [6 × 1 × N] → squeeze → [6 × N] → trasposizione → [N × 6]
data6_matrix = squeeze(data6)';   % ora [300001 × 6] ✓

fprintf('Dopo riorganizzazione: %d righe × %d colonne\n', ...
    size(data6_matrix, 1), size(data6_matrix, 2));

% Ora idx funziona correttamente
idx = t_det > 15;
data_steady = data6_matrix(idx, :);   % [N_steady × 6] ✓

fprintf('Campioni nella zona stazionaria: %d\n', size(data_steady, 1));

% Calcolo statistico per canale
mu6    = mean(data_steady, 1);    % [1×6]
sig6   = std(data_steady, 0, 1);  % [1×6]
Th_vec = mu6 - 3*sig6;            % [1×6]

% Stampa risultati
fprintf('\n=== SOGLIE 6 CANALI ===\n');
for i = 1:6
    fprintf('Motore %d: mu=%7.4f  sigma=%6.4f  Th=%7.4f\n', ...
        i, mu6(i), sig6(i), Th_vec(i));
end

% Salva soglie separate per i blocchi Compare in Simulink
Th_m1 = Th_vec(1);
Th_m2 = Th_vec(2);
Th_m3 = Th_vec(3);
Th_m4 = Th_vec(4);
Th_m5 = Th_vec(5);
Th_m6 = Th_vec(6);

fprintf('Soglie salvate nel workspace ✓\n');
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

% fprintf('--- MODULO FD-2: Attuatori (Spinta Asse Z) ---\n');
% fprintf('  Media (mu):                  %.4f m/s²\n', mu_act);
% fprintf('  Deviazione Standard (sigma):  %.4f m/s²\n', sigma_act);
% fprintf('  SOGLIA VARIABILE -> [Th_3sigma_act]:  %.4f m/s²\n\n', Th_3sigma_act);

% fprintf('\n--- SOGLIA FILTRO LEAD (FD-2) --- \n');
% fprintf('  Soglia calcolata (5-sigma): %.4f\n', Th_5sigma_act);
% fprintf('  Picco massimo durante volo sano: %.4f\n\n', max(data_baseline));

fprintf('--- MODULO FD-3: GPS (Dinamica Traslazionale) ---\n');
fprintf('  Media (mu):                  %.4f m\n', mu_gps);
fprintf('  Deviazione Standard (sigma):  %.4f m\n', sigma_gps);
fprintf('  SOGLIA VARIABILE -> [Th_3sigma_gps]:  %.4f m\n', Th_3sigma_gps);
fprintf('==================================================\n');

