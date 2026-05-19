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

% --- Posizionamento poli osservatore ---
% Poli del sistema: tutti in 0 (doppio integratore per ogni asse)
% Poli osservatore: significativamente più veloci
% Il paper usa [-6,-2] per gli observer interni;
% per FD scegliamo poli più veloci del controllore ma non troppo
% (trade-off: veloci = reattivi ai guasti, ma amplificano il rumore)
poles_FD1 = [-4, -5, -6, -8, -10, -12];

L_a = place(A_a', C_a', poles_FD1)';  % 6x3

%% ========================================================================
%% AGGIORNAMENTO MATRICI PER COMPENSAZIONE GIROSCOPICA NON LINEARE (FD-1)
%% ========================================================================
% % Il vecchio ingresso era: u_old = [tau(3x1); Rpnoisy(3x1)]       -> (6x1)
% % Il NUOVO ingresso sarà:  u_new = [tau(3x1); Rpnoisy(3x1); corr(3x1)] -> (9x1)
% 
% % 1. Recupera le matrici nominali dell'osservatore (già calcolate in precedenza)
% % A_a (6x6), B_a (6x3), L_a (6x3)
% A_obs_cl = A_a - L_a * C_a; % Matrice a ciclo chiuso dell'osservatore (6x6)
% 
% % 2. Definisci la matrice di accoppiamento per i 3 nuovi ingressi di correzione.
% % La correzione agisce direttamente sulla derivata di omega (righe 4-6), 
% % quindi la parte superiore è di zeri e quella inferiore è una matrice identità.
% B_corr = [zeros(3,3); eye(3)]; % Dimensione: (6x3)
% 
% % 3. Assembla la nuova matrice B per lo State-Space (Orizzontale: 6 righe x 9 colonne)
% % - Colonne 1-3: Coppie dei motori (B_a)
% % - Colonne 4-6: Feedback degli angoli dai sensori (L_a)
% % - Colonne 7-9: Termine di correzione non lineare (B_corr)
% B_SS_FD1_new = [B_a, L_a, B_corr]; 
% 
% % 4. Aggiorna la matrice D per accogliere i 9 ingressi (6 righe x 9 colonne di zeri)
% D_SS_FD1_new = zeros(6, 9);
% 
% % 5. Le matrici A e C rimangono strutturalmente identiche a prima
% A_SS_FD1_new = A_obs_cl; % (6x6)
% C_SS_FD1_new = eye(6);   % (6x6) -> Sputa fuori l'intero stato stimato
% 
% % 6. Salva o aggiorna il file .mat che Simulink caricherà all'avvio
% save('FD_params.mat', 'B_SS_FD1_new', 'D_SS_FD1_new', 'A_SS_FD1_new', 'C_SS_FD1_new', '-append');
% 
% disp('=== Matrici FD-1 estese (6x9) generate e salvate con successo! ===');

%%

% --- Verifica stabilità ---
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

g_vec       = [0; 0; g];    % 3x1 vettore gravità NED
B_parity    = F1 / m;       % 3x6: guadagno motori nel residuo

% Verifica con F1 del workspace (riga 3 = [-1,-1,-1,-1,-1,-1])
disp('Verifica F1 riga 3 (atteso: tutti -1):');
disp(F1(3,:));
disp('B_parity riga 3 (atteso: tutti -1/m = -0.6452):');
disp(B_parity(3,:));

% Per residuo torque (opzionale, richiede derivata filtrata di omeganoisy):
%   r_tau = omegadot_filtered - inv(J)*F2*u
%   Implementato in Simulink con blocco Derivative + filtro

B_torque_parity = inv(J) * F2;  % 3x6
tau_filt_TC     = 0.05;          % costante di tempo filtro derivativo [s]

fprintf('\nB_parity (F1/m):\n'); disp(B_parity);
fprintf('B_torque_parity (inv(J)*F2):\n'); disp(B_torque_parity);

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