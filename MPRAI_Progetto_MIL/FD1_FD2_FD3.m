%% ================================================================
%% FAULT DETECTION SETUP - usa variabili già nel workspace
%% Assumi presenti: F1, F2, J, m, Ts, omega0, p0
%% ================================================================

g = 9.81; 

%% ================================================================
%% MODULO FD-1: Osservatore Luenberger per guasto giroscopio
%% ================================================================
% Stati:    x_a = [phi; theta; psi; wx; wy; wz]  (6x1)
% Ingresso: u_a = tau = F2 * [f1..f6]            (3x1)
% Uscita:   y_a = [phi; theta; psi] da Rpnoisy   (3x1) ← NON omeganoisy!

A_a = [zeros(3), eye(3); zeros(3), zeros(3)];  % 6x6
B_a = [zeros(3); inv(J)];                       % 6x3
C_a = [eye(3),  zeros(3)];                      % 3x6

% --- Verifica osservabilità ---
assert(rank(obsv(A_a, C_a)) == 6, 'ERRORE: sistema non osservabile!');
disp('FD-1: sistema OSSERVABILE ✓');
%% Calcolo dei poli tramite LQG
% R_weight = 0.01; 
% R = R_weight * eye(size(C_a, 1));
% 
% Q_weight = 10; 
% Q = Q_weight * eye(size(A_a, 1));
% 
% G = eye(size(A_a, 1));
% 
% [L_a, P_cov, Poles_LQG] = lqe(A_a, G, C_a, Q, R);
% 
% % 5. Stampa dei risultati nella Command Window
% fprintf('\n--- RISULTATI OTTIMIZZAZIONE LQG (FD-1) ---\n');
% disp('I poli ottimali scelti automaticamente sono:');
% disp(Poles_LQG);
% disp('La matrice di guadagno ottimale L_a è:');
% disp(L_a);
%%
% POLI SCELTA INIZIALE 
% --- Posizionamento poli osservatore ---
% Poli del sistema: tutti in 0 (doppio integratore per ogni asse)
% Poli osservatore: significativamente più veloci
% Il paper usa [-6,-2] per gli observer interni;
% per FD scegliamo poli più veloci del controllore ma non troppo
% (trade-off: veloci = reattivi ai guasti, ma amplificano il rumore)
poles_FD1 = [-4, -5, -6, -8, -10, -12];

L_a = place(A_a', C_a', poles_FD1)';  % 6x3
%% POLI FAST
% Poli molto veloci = segui la misura, ignora il modello
% poles_FD1_fast = [-50, -60, -70, -100, -120, -140];
% L_a = place(A_a', C_a', poles_FD1_fast)';
%% --- Verifica stabilità ---
A_obs_cl = A_a - L_a * C_a;
ev = eig(A_obs_cl);
fprintf('Autovalori osservatore FD-1:\n'); disp(ev');
assert(all(real(ev) < 0), 'ERRORE: osservatore instabile!');

% --- Matrici per blocco State-Space Simulink ---
% Ingresso al blocco State-Space: [tau(3x1); Rpnoisy(3x1)] → vettore 6x1
%   - colonne 1-3 di B_SS: effetto dei torques (= B_a)
%   - colonne 4-6 di B_SS: effetto del feedback angoli (= L_a)
A_SS_FD1 = A_obs_cl;          % 6x6
B_SS_FD1 = [B_a, L_a];        % 6x6
C_SS_FD1 = eye(6);             % 6x6 → output = stato completo stimato
D_SS_FD1 = zeros(6, 6);        % 6x6
x0_FD1   = [zeros(3,1); omega0]; % CI: angoli=0, omega da workspace

fprintf('\nMatrice L_a (guadagno osservatore):\n'); disp(L_a);

%% ================================================================
%% MODULO FD-2: Equazioni di parità per guasto attuatore
%% ================================================================
% Dalla dinamica lineare (R ≈ I, NED):
%   m*v̇p = m*g*e3 + F1*u  →  v̇p = g*e3 + F1*u/m
%
% Residuo forza (3x1) — confronta accelerazione MISURATA vs PREDETTA:
%   r_act = vdotnoisy - (g_vec + F1*u/m)
%
% Con F1 = [0 0 0 0 0 0; 0 0 0 0 0 0; -1 -1 -1 -1 -1 -1]:
%   r_act_z = vdotnoisy(3) - (g - sum(fi)/m)
%
% Guasto motore → sum(fi) cambia → r_act_z ≠ 0

% g_vec       = [0; 0; g];    % 3x1 vettore gravità NED
% B_parity    = F1 / m;       % 3x6: guadagno motori nel residuo
% 
% % Verifica con F1 del workspace (riga 3 = [-1,-1,-1,-1,-1,-1])
% disp('Verifica F1 riga 3 (atteso: tutti -1):');
% disp(F1(3,:));
% disp('B_parity riga 3 (atteso: tutti -1/m = -0.6452):');
% disp(B_parity(3,:));
% 
% % Per residuo torque (opzionale, richiede derivata filtrata di omeganoisy):
% %   r_tau = omegadot_filtered - inv(J)*F2*u
% %   Implementato in Simulink con blocco Derivative + filtro
% 
% B_torque_parity = inv(J) * F2;  % 3x6
% tau_filt_TC     = 0.05;          % costante di tempo filtro derivativo [s]
% 
% fprintf('\nB_parity (F1/m):\n'); disp(B_parity);
% fprintf('B_torque_parity (inv(J)*F2):\n'); disp(B_torque_parity);
%% ================================================================
%% MODULO FD-2: Unknown Input Observer (UIO) per Guasto Attuatori
%% Implementazione per blocco State-Space (u = 6 motori, y = Z_pos, Z_vel)
%% ================================================================
% disp('--- Inizializzazione UIO FD-2 (MIMO Version) ---');
% 
% % Estraiamo la riga della matrice F1 relativa all'asse Z
% % NOTA: Se nel tuo workspace la spinta verticale è mappata sulla riga 1 
% % anziché sulla 3, cambia F1(3,:) in F1(1,:)
% F1_Z = F1(3, :); % Vettore 1x6
% 
% % 1. Definizione del modello nello Spazio di Stato (Asse Z)
% % x = [z; v_z]
% A_2 = [0, 1; 
%        0, 0];                     
% 
% % Matrice di ingresso B_2 (dimensione 2x6)
% B_2 = [zeros(1, 6); 
%        F1_Z / m];                 
% 
% E_2 = [0; 
%        1/m];                      % Effetto del disturbo (Vento su asse Z)
% 
% % Il guasto è sul motore 1 (f1), quindi prendiamo il 1° elemento di F1_Z
% F_2 = [0; 
%        F1_Z(1) / m];              
% 
% C_2 = [1, 0; 
%        0, 1];                     % Misure: posizione e velocità Z
% 
% % 2. Calcolo Matrici UIO (Deaccoppiamento)
% H_2 = E_2 * pinv(C_2 * E_2); 
% 
% % Verifica matematica del deaccoppiamento
% I_mat = eye(size(A_2));
% if max(abs((I_mat - H_2 * C_2) * E_2)) > 1e-10
%     error('FD-2: Condizione di deaccoppiamento fallita!');
% end
% 
% % Calcolo G_2 (che ora sarà automaticamente 2x6) e A_soluzione
% G_2 = (I_mat - H_2 * C_2) * B_2;
% A_soluzione = (I_mat - H_2 * C_2) * A_2;
% 
% % 3. Posizionamento dei Poli 
% poli_desiderati = [-10, -15]; 
% L1_2 = place(A_soluzione', C_2', poli_desiderati)';
% 
% N_2 = A_soluzione - L1_2 * C_2;
% L_2 = L1_2 + N_2 * H_2;
% 
% % ================================================================
% % 4. ADATTAMENTO PER BLOCCO STATE-SPACE SIMULINK
% % Ingresso totale Simulink = [f1..f6; z_meas; vz_meas] -> Vettore 8x1
% % Uscita totale Simulink = x_hat -> Vettore 2x1
% % ================================================================
% 
% A_ss_2 = N_2;                            % 2x2
% B_ss_2 = [G_2, L_2];                     % G(2x6) affiancato a L(2x2) -> 2x8
% C_ss_2 = eye(size(N_2));                 % 2x2
% D_ss_2 = [zeros(size(G_2)), H_2];        % Zeri(2x6) affiancati a H(2x2) -> 2x8
% 
% disp('Matrici State-Space UIO FD-2 calcolate con successo (Dimensione B: 2x8) ✓');
%% ================================================================
%% MODULO FD-2: Fault Detection Attuatori (Firma Multi-Asse DOBC)
%% ================================================================
% disp('--- Inizializzazione FD-2: Analisi Firma Multi-Asse ---');
% 
% % Estraiamo i coefficienti di Rollio e Beccheggio per il Motore 1
% % Dalla matrice di allocazione dei momenti F2 (3 righe x 6 motori)
% % Riga 1: Rollio, Riga 2: Beccheggio, Colonna 1: Motore 1
% K_roll  = F2(1, 1);   % = 0
% K_pitch = F2(2, 1);   % = 0.2750
% K_yaw   = F2(3, 1);   % = 0.7108
% 
% sig_motor1 = F2(:, 1)';   % [0; 0.2750; 0.7108]
% 
% % (Opzionale) Calcolo l'ampiezza attesa del residuo per impostare la soglia.
% % Se il guasto inietta una perdita di -0.51 N (Delta f):
% % Il residuo teorico sarà = (K_roll^2 + K_pitch^2) * abs(Delta_f)
% Delta_f_atteso = 0.51; 
% ampiezza_gradino_teorica = (K_roll^2 + K_pitch^2) * Delta_f_atteso;
% 
% disp(['Coefficiente K_roll: ', num2str(K_roll)]);
% disp(['Coefficiente K_pitch: ', num2str(K_pitch)]);
% disp(['Ampiezza teorica del gradino al momento del guasto: ', num2str(ampiezza_gradino_teorica)]);
% disp('FD-2 pronto per Simulink ✓');
%% FD-2: Residui strutturati a 6 canali (un canale per motore)
sig_all_T = F2';   % [6×3] — riga i = firma motore i = F2(:,i)'

% Verifica dimensioni
fprintf('sig_all_T: %dx%d\n', size(sig_all_T));
% Deve stampare: 6x3

% Ogni riga proiettata su Me_B_hat (3×1) dà r_i scalare
% sig_all_T * Me_B_hat = [6×3] × [3×1] = [6×1] ✓

% Filtro LPF per detrending — State-Space a blocchi 6×6
tau_base = 40;
A_lp6 = -(1/tau_base) * eye(6);   % 6×6
B_lp6 =  (1/tau_base) * eye(6);   % 6×6
C_lp6 =  eye(6);                   % 6×6
D_lp6 =  zeros(6);                 % 6×6

fprintf('Matrici LPF 6-canali configurate ✓\n');

%% Calibrazione soglie — DOPO run fault-free (t > 15s)
% (eseguire dopo simulazione)
% idx = t > 15;
% r_det6_base = r_det6.Data(idx, :);   % N×6
% mu6    = mean(r_det6_base, 1);        % 1×6
% sigma6 = std(r_det6_base, 0, 1);      % 1×6
% Th_FD2_6ch = mu6 - 3*sigma6;          % 1×6 — soglie negative per ogni motore
%% ================================================================
%% Salva parametri per Simulink
%% ================================================================
% save('FD_params.mat', ...
%     'A_SS_FD1','B_SS_FD1','C_SS_FD1','D_SS_FD1','x0_FD1', ...
%     'L_a','A_a','B_a','C_a', ...
%     'B_parity','B_torque_parity','g_vec','tau_filt_TC','g');
% 
% disp('=== FD_params.mat salvato ✓ ===');

%% ================================================================
%% MODULO FD-3: Dead Reckoning per guasto sensore Posizione (GPS)
%% Sensore bersaglio: pnoisy
%% ================================================================

% Poiché nascondere pnoisy rende il sistema non osservabile (rango 3),
% NON usiamo un Osservatore di Luenberger standard (niente calcolo dei poli).
% Usiamo invece un "Filtro Complementare" (o integratore puro con lievissimo richiamo).

% L'equazione sarà:  p_dot_hat = pdotnoisy + K_comp * (pnoisy - p_hat)

% K_comp è un guadagno minuscolo. 
% - Se fosse grande (es. 10), l'integratore inseguirebbe subito il GPS guasto.
% - Se fosse 0 (Integrazione pura), l'errore numerico si accumulerebbe all'infinito.
% - Mettendolo lentissimo (es. 0.05), blocca la deriva numerica a lungo termine 
%   (fault-free), ma se il GPS fa uno scatto per un guasto, il filtro lo ignora 
%   per molti secondi, permettendo al residuo di "esplodere" e rilevare l'anomalia.

K_comp = 0.05 * eye(3); % Matrice di guadagno complementare 3x3

% Matrici per il blocco State-Space (solo 3 stati: px, py, pz)
% Lo stato è la posizione stimata (3x1)
A_SS_FD3 = -K_comp;              % 3x3 (Dinamica dell'errore lenta)
B_SS_FD3 = [eye(3), K_comp];     % 3x6 (Ingressi: pdotnoisy 3x1 e pnoisy 3x1)
C_SS_FD3 = eye(3);               % 3x3 (Uscita: la posizione stimata)
D_SS_FD3 = zeros(3, 6);          % 3x6

disp('Matrici FD-3 (Dead Reckoning per GPS) generate con successo!');

%% Debounce logic

T_debounce = 1.0;