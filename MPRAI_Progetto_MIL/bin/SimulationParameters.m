% Simulation parameters

Ts = 1e-3;                      % [s] Simulation step time
Ts_hw = 5*Ts;                   % [s] Hardware sample time
Tfin = 60;                      % [s] Simulation final time

% User options
WrenchType = 6;                 % 1. No Wrench
                                % 2. Constant wrench (force only)
                                % 3. Low frequency wrench
                                % 4. High frequency wrench
                                % 5. Mixed #1
                                % 6. Type #1 of low frequency signal + high frequency signal
                                % 6.1 Type #2 of low frequency signal + high frequency signal
                                % 6.2 Type #3 of low frequency signal + high frequency signal

ReferenceTypeNumber = 4;        % 0. Null trajectory
                                % 1. Constant speed in direction of xE
                                % 2. Constant speed in direction of yE
                                % 3. Constant speed in direction of -zE
                                % 4. Ascending spiral
                                % 5. Ascending 8-shape around u
                                % 6. Square around e3 (to do)
                                % 7. zig-zag toward xE (non smooth)
                                % 8. zig-zag toward zE (non smooth)
                                % 9. Descending spiral
                                % 10. Descending 8-shape

NoiseStdAmplification = 2;      % 0. No sensor noise
                                % 1. Sensors noise with acc_std = 8e-3*9.81
                                % In general, acc_std = NoiseStdAmplification*8e-3*9.81

Attack = 0;                     % 0. No attack
                                % 1. Attack

NDOB_force = 1;                 % 0. No NDO for force estimation
                                % 1. Yes NDO for force estimation

NDOB_torque = 1;                % 0. No NDO for torque estimation
                                % 1. Yes NDO for torque estimation

InternalModelType = 1;          % 1. Constant forces and torques
                                % 2. Ramp in each force and torque component
                                % 3. Ramp + cos(omega*t) in each force and torque component

% Plant initial conditions
p0 = zeros(3,1);                % [m] Initial spatial position
pdot0 = zeros(3,1);             % [m/s] Initial spatial linear velocity
omega0 = zeros(3,1);            % [rad/s] Initial body angular velocity
R0 = eye(3);                    % Initial rotation matrix attitude

% Reference trajectory parameters
% TrajectoryDirection = [0 0 1]';
period = 10;
radius = 5;
speed = 1;
