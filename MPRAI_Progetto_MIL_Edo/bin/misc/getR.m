function R = getR(varargin)
    % Calculate the rotation matrix related to roll-pitch-yaw angles
    % R = getR(eta), where eta = [phi; theta; psi]
    % R = getR(phi,theta,psi)
    % 
    % phi, theta, psi are, in order, roll, pitch and yaw angles.
    if nargin == 1
        eta = varargin{1};
        phi = eta(1);
        theta = eta(2);
        psi = eta(3);
    elseif nargin == 3
        phi = varargin{1};
        theta = varargin{2};
        psi = varargin{3};
    else
      error('Incorrect use of getR. Check arguments.')
    end
    Rx = [1 0 0; 0 cos(phi) -sin(phi); 0 sin(phi) cos(phi)];
    Ry = [cos(theta) 0 sin(theta); 0 1 0; -sin(theta) 0 cos(theta)];
    Rz = [cos(psi) -sin(psi) 0; sin(psi) cos(psi) 0; 0 0 1];
    R = Rz*Ry*Rx;
end