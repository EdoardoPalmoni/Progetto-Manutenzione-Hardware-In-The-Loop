function [m,J,rg_B,F1,F2] = PlantParameters(PlantType)
% [m,J,F1,F2] = LoadParameters(PlantType)
% Loading plant parameters
    
    if PlantType == "HEXA"
        nu = 6;                                 % Number of actuators
        m = 3.95;                               % [Kg] Mass
        g = 9.80665;                            % [m/s^2] Gravitational acceleration
        armLength = 0.45;                       % [m] Arm length
        J = diag([0.363 0.363 0.651/10]);       % [N*m*s^2] Inertial tensor (body frame)
        cL = 1.3500e-7;                         % Lift coefficient (paper ICUAS 2024 sistemato, JINT)
        cD = 9.596e-8;                          % Drag coefficient (paper ICUAS 2020) rad^2/s^2 
        rg_B = [0; 0; 0];                       % [m] Center of mass displacement
        kt = 0.032;                             % [N*s/m] Linear friction coefficient of the multirotor frame (SysTol 19)
        kr = 5.567*10^{-4};                     % [N*m*s] Angular friction coefficient of the multirotor frame (SysTol 19)
        rotorPositions = zeros(3,nu); 
        rotorPointingDir = zeros(3,nu);
        for i = 1:nu
            angle = (i-1)*2*pi/nu;                                                          
            rotorPositions(:,i) = [cos(angle)*armLength , sin(angle)*armLength , 0]';
            rotorPointingDir(:,i) = [0; 0; -1];
        end
        rotorDir = (-1).^(1:nu); 
        [F1,F2] = MultirotorAllocation(rotorPositions,rotorPointingDir,rotorDir,cL,cD);
    elseif PlantType == "HEXANiemiec"
        nu = 6;                                 % N. of control inputs
        m = 1.55;                               % [Kg] Mass
        g = 9.80665;                            % [m/s^2] Gravitational acceleration
        armLength = 0.275;                      % [m] Arm length
        J = diag([0.0266, 0.0266, 0.0498]);     % [N*m*s^2] Inertial tensor (body frame)
        cL = 1.3500e-7;                         % Lift coefficient (paper ICUAS 2024 sistemato, JINT)
        cD = 9.596e-8;                          % Drag coefficient (paper ICUAS 2020) rad^2/s^2 
        rg_B = [0; 0; 0];                       % [m] Center of mass displacement
        kt = 0.032;                             % [N*s/m] Linear friction coefficient of the multirotor frame (SysTol 19)
        kr = 5.567*10^(-4);                     % [N*m*s] Angular friction coefficient of the multirotor frame (SysTol 19)
        rotorPositions = zeros(3,nu); 
        rotorPointingDir = zeros(3,nu);
        for i = 1:nu
            angle = (i-1)*2*pi/nu;                                                          
            rotorPositions(:,i) = [cos(angle)*armLength , sin(angle)*armLength , 0]';
            rotorPointingDir(:,i) = [0; 0; -1];
        end
        rotorDir = (-1).^(1:nu); 
        [F1,F2] = MultirotorAllocation(rotorPositions,rotorPointingDir,rotorDir,cL,cD);
    elseif PlantType == "OCTA"
        nu = 8;                                 % N. of control inputs
        m = 1.55;                               % [Kg] Mass
        g = 9.80665;                            % [m/s^2] Gravitational acceleration
        armLength = 0.275;                      % [m] Arm length
        J = diag([0.0266, 0.0266, 0.0498]);     % [N*m*s^2] Inertial tensor (body frame)
        cL = 1.3500e-7;                         % Lift coefficient (paper ICUAS 2024 sistemato, JINT)
        cD = 9.596e-8;                          % Drag coefficient (paper ICUAS 2020) rad^2/s^2 
        rg_B = [0; 0; 0];                       % [m] Center of mass displacement
        kt = 0.032;                             % [N*s/m] Linear friction coefficient of the multirotor frame (SysTol 19)
        kr = 5.567*10^(-4);                     % [N*m*s] Angular friction coefficient of the multirotor frame (SysTol 19)
        rotorPositions = zeros(3,nu); 
        rotorPointingDir = zeros(3,nu);
        for i = 1:nu
            angle = (i-1)*2*pi/nu;                                                          
            rotorPositions(:,i) = [cos(angle)*armLength , sin(angle)*armLength , 0]';
            rotorPointingDir(:,i) = [0; 0; -1];
        end
        rotorDir = (-1).^(1:nu); 
        [F1,F2] = MultirotorAllocation(rotorPositions,rotorPointingDir,rotorDir,cL,cD);
    elseif PlantType == "QUAD"
        nu = 4;                                 % N. of control inputs
        m = 0.8;                                % [kg] Mass
        g = 9.80665;                            % [m/s^2] Gravitational acceleration
        armLength = 0.33;                       % [m] Arm length
        J = diag([0.005, 0.005, 0.005]);        % [N*m*s^2] Inertial tensor (body frame)
        cL = 1.3500e-7;                         % Lift coefficient (paper ICUAS 2024 sistemato, JINT)
        cD = 9.596e-8;                          % Drag coefficient (paper ICUAS 2020) rad^2/s^2 
        rg_B = [0; 0; 0];                       % [m] Center of mass displacement
        rotorPositions = zeros(3,nu); 
        rotorPointingDir = zeros(3,nu);
        for i = 1:nu
            angle = (i-1)*2*pi/nu;                                                          
            rotorPositions(:,i) = [cos(angle)*armLength , sin(angle)*armLength , 0]';
            rotorPointingDir(:,i) = [0; 0; -1];
        end
        rotorDir = (-1).^(1:nu); 
        [F1,F2] = MultirotorAllocation(rotorPositions,rotorPointingDir,rotorDir,cL,cD);
    else
        error("PlantType not accepted.")
    end

end
 
%% Routines
function [F1,F2] = MultirotorAllocation(rotorPositions,rotorPointingDir,rotorDir,cL,cD)
    % Control effectiveness matrix calculation for multirotors (in terms of lift forces)
    nu = size(rotorPositions,2);
    F1 = zeros(3,nu);
    F2 = zeros(3,nu);
    for i = 1:nu
        F1(:,i) = rotorPointingDir(:,i);
        F2(:,i) = cross(rotorPositions(:,i),rotorPointingDir(:,i)) + rotorDir(:,i)*(cD/cL)*rotorPointingDir(:,i);
    end
end

function S = skew(x)
    S = [0 -x(3) x(2); x(3) 0 -x(1); -x(2) x(1) 0];
end
