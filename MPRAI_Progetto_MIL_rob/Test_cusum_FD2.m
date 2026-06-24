%% --- 1. ESTRAZIONE DATI DAI TIMESERIES ---
% Assicuriamoci che i vettori temporali siano allineati
time = Fe_E_hat_fault.Time; 
N = length(time);

% Pre-allochiamo i vettori per l'asse Z del drone (Body Frame)
Fz_body_ff = zeros(N, 1); % fault-free
Fz_body_f  = zeros(N, 1); % con guasto

disp('1. Dati estratti con successo. Inizio trasformazione NED -> Body...');

%% --- 2. TRASFORMAZIONE NED -> BODY E ESTRAZIONE ASSE Z ---
for k = 1:N
    % Estraiamo i dati in modo sicuro al passo k
    % getdatasamples estrae il dato e squeeze rimuove le dimensioni extra
    R_k_ff = squeeze(getdatasamples(Rnoisy, k));       % Matrice 3x3
    Fe_k_ff = squeeze(getdatasamples(Fe_E_hat, k));    % Vettore
    Fe_k_ff = Fe_k_ff(:); % Assicura che sia un vettore colonna 3x1
    
    R_k_f = squeeze(getdatasamples(Rnoisy_fault, k));  % Matrice 3x3
    Fe_k_f = squeeze(getdatasamples(Fe_E_hat_fault, k)); % Vettore
    Fe_k_f = Fe_k_f(:); % Assicura che sia un vettore colonna 3x1
    
    % Proiezione: F_body = R^T * F_earth
    % La trasposta di R (R') ruota le forze dalla Terra al corpo del drone
    F_body_k_ff = R_k_ff' * Fe_k_ff;
    F_body_k_f  = R_k_f'  * Fe_k_f;
    
    % A noi interessa solo l'asse Z (la spinta dei motori), che è la 3a componente
    Fz_body_ff(k) = F_body_k_ff(3);
    Fz_body_f(k)  = F_body_k_f(3);
end

disp('2. Trasformazione completata.');

%% --- 3. IMPOSTAZIONE PARAMETRI CUSUM ---
% Calcoliamo la media del segnale nominale per eliminare bias statici.
% Usiamo la porzione di tempo tra 5s e 15s (prima del guasto)
idx_baseline = (time > 5 & time < 15);
mu0 = mean(Fz_body_f(idx_baseline));

% Parametri chiave del CUSUM (presi dal tuo report)
Delta = 0.51;        % L'ampiezza dello shift causato dal guasto (0.51 N)
delta = Delta / 2;   % Allowance: tolleranza al rumore e al vento (0.255)
h = 1.0;             % Soglia di allarme (THRESHOLD - la modificheremo in base ai grafici)

disp('3. Parametri CUSUM inizializzati. Calcolo accumulatore in corso...');

%% --- 4. ALGORITMO CUSUM ---
% Inizializziamo gli accumulatori
g_pos_ff = zeros(N, 1);
g_pos_f  = zeros(N, 1);
alarm_f  = zeros(N, 1);

for k = 2:N
    % Calcolo per il caso SANO (Fault-Free)
    residuo_ff = Fz_body_ff(k) - mu0;
    % L'accumulatore non può scendere sotto zero
    g_pos_ff(k) = max(0, g_pos_ff(k-1) + residuo_ff - delta);
    
    % Calcolo per il caso GUASTO
    residuo_f = Fz_body_f(k) - mu0;
    g_pos_f(k) = max(0, g_pos_f(k-1) + residuo_f - delta);
    
    % Logica dell'allarme
    if g_pos_f(k) > h
        alarm_f(k) = 1;
    end
end

disp('4. CUSUM terminato. Generazione grafici...');

%% --- 5. PLOT E VISUALIZZAZIONE ---
figure('Name', 'Analisi FD-2: Segnali e CUSUM', 'Position', [100, 100, 1000, 800]);

% --- GRAFICO 1: Il segnale sul Body Frame (Guarda il Fault Masking!) ---
subplot(3,1,1);
plot(time, Fz_body_ff, 'g', 'LineWidth', 1.2); hold on;
plot(time, Fz_body_f, 'r', 'LineWidth', 1.2);
xline(20, 'k--', 'Inizio Guasto (t=20s)', 'LineWidth', 1.5);
title('1. Disturbo stimato su Asse Z del Drone (Body Frame)');
ylabel('Forza [N]');
legend('Senza Guasto', 'Con Guasto', 'Location', 'Best');
grid on; xlim([10 40]);

% --- GRAFICO 2: L'accumulatore CUSUM ---
subplot(3,1,2);
plot(time, g_pos_ff, 'g', 'LineWidth', 1.2); hold on;
plot(time, g_pos_f, 'r', 'LineWidth', 1.5);
yline(h, 'b--', 'SOGLIA (h)', 'LineWidth', 1.5);
xline(20, 'k--', 'LineWidth', 1.5);
title('2. Accumulatore CUSUM (Ignora il vento, accumula il guasto)');
ylabel('g(k)');
legend('Accumulatore (Senza Guasto)', 'Accumulatore (Con Guasto)', 'Soglia', 'Location', 'Best');
grid on; xlim([10 40]);

% --- GRAFICO 3: Segnale di Allarme ---
subplot(3,1,3);
plot(time, alarm_f, 'r', 'LineWidth', 2); hold on;
xline(20, 'k--', 'LineWidth', 1.5);
title('3. Segnale di Allarme Rilevato');
ylabel('Alarm [0/1]');
xlabel('Tempo [s]');
ylim([-0.2 1.2]);
grid on; xlim([10 40]);

disp('Finito! Controlla i grafici.');
