% Controller parameters

% Compensator internal exogenous model. Choose one
if InternalModelType == 1
    % 1) Predicted signals: constant in each force and torque component
    A_zeta_f = zeros(3);
    C_zeta_f = eye(3);
    A_zeta_tau = zeros(3);
    C_zeta_tau = eye(3);
elseif InternalModelType == 2
    % 1) Predicted signals: ramp in each force and torque component
    A_zeta_f = blkdiag([0 1; 0 0],[0 1; 0 0],[0 1; 0 0]);
    C_zeta_f = blkdiag([1 0],[1 0],[1 0]);
    A_zeta_tau = blkdiag([0 1; 0 0],[0 1; 0 0],[0 1; 0 0]);
    C_zeta_tau = blkdiag([1 0],[1 0],[1 0]);
elseif InternalModelType == 3
    omegax = 2;
    omegay = 3;
    omegaz = 4;
    omegap = 5;
    omegaq = 6;
    omegar = 7;
    A_zeta_f = blkdiag(1,[0 -omegax; omegax 0],1,[0 -omegay; omegay 0],1,[0 -omegaz; omegaz 0]);
    C_zeta_f = blkdiag([1 1 0],[1 1 0],[1 1 0]);
    A_zeta_tau = blkdiag(1,[0 -omegap; omegap 0],1,[0 -omegaq; omegaq 0],1,[0 -omegar; omegar 0]);
    C_zeta_tau = blkdiag([1 1 0],[1 1 0],[1 1 0]);
end

% NDOs - Eigenvalues to place 
eigs_NDO_force = linspace(-2,-6,size(A_zeta_f,1));
eigs_NDO_torque = linspace(-2,-6,size(A_zeta_tau,1));

% Eventually mass and inertia displacements (multiplicative)
mass_factor = 1;
inertia_factor = 1;