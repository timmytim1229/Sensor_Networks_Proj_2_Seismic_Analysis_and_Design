%% 1) Final Equation of Motion - 2 Degrees of Freedom
%       ---         ---   ---  ---     ---         ---   ---  ---
%       |             |   |      |     |             |   |      |     
%       |  m1      0  |   |  u1  |     | k1+k2   -k2 |   |  u1  |     
%       |             |   |      |  +  |             |   |      |  =  [0]
%       |             |   |      |     |             |   |      |     [0]
%       |  0       m2 |   |  u2  |     |  -k2     k2 |   |  u2  |
%       |             |   |      |     |             |   |      |
%       ---         ---   ---  ---     ---         ---   ---  ---
%         Mass Matrix       Accel      Stiffness Matrix
%
%
% 2) Solve for Modeshape Vectors to get Eigen Values:
% 2.1) 
% Know:
%       {[k] - wn^2[m]}*S = 0 ;   S = Modeshape Vector
%
% 2.2) Solve for Lambda (Eigen Values) by the following
% det[[k]-wn^2[m]] = 0 ; [k] = stiffness matrix
%                        [m] = mass matrix
%                        wn^2 = lambda = L
%                             = Eigen Values 
%                               (each degree of freedom = 1 eigen value)
%
% Gives: L1, L2 (and w1, w2 from wn^2 = L)
% 
% NOTE: Order L by lowest to highest. Lowest will collapse the building due
%       to lowest frequency.
%
%
% 3) Solve for S (solve for each modeshape)
%
%       ---                        ---   ---   ---
%       |                            |   |       |     
%       |  (k1+k2)-L1*m1       -k1   |   |  S11  |     
%       |                            |   |       |  =  [0]
%       |                            |   |       |     [0]
%       |       -k2         k2-L1*m2 |   |  S21  | 
%       |                            |   |       |
%       ---                        ---   ---   ---    
%                                        Modeshape Matrix for Lambda 1
% Gives:                                       
%       S11 = Mass 1 Mode 1
%       S21 = Mass 2 Mode 1
%
%       ---                        ---   ---   ---
%       |                            |   |       |     
%       |  (k1+k2)-L2*m1       -k1   |   |  S12  |     
%       |                            |   |       |  =  [0]
%       |                            |   |       |     [0]
%       |       -k2         k2-L2*m2 |   |  S22  |
%       |                            |   |       |
%       ---                        ---   ---   ---    
%                                        Modeshape Matrix for Lambda 2
% Gives:
%       S12 = Mass 1 Mode 2
%       S22 = Mass 2 Mode 2
%
%%
% Part 1 and 2
%
% Stiffness values
k1 = 22;    % level 1 stiffness
k2 = 15;    % level 2 stiffness
K = [k1+k2 -k2; -k2 k2];

% Mass values
m1 = 2.268 + .24;    % level 1 mass (5lb + .24kg of the floor)
m2 = 2.268 + .24;    % level 2 mass
M = [m1 0; 0 m2];

eigenVals = getEigenVals(K, M)  % USER DEFINED
%eigenVals(1) = 681.5132

% Part 3 
% One modeshape vector (modes) for each lambda (eigen values)
% Each degree of freedom = one eigen value 
% Therefore, one modeshape vector for each degree of freedom 681.5132
modeShape1 = getModeshape(K, M, eigenVals(1))   % USER DEFINED
%modeShape2 = getModeshape(K, M, eigenVals(2))   % USER DEFINED

%% Calculation
execTime = 20;
[maxim maximIndex] = findMaximaPlot(x,y,[13.7,15.2]);

maximSize = size(maxim);
xSize = size(x);
numCyclesAway = 2;
terminate = 0;
for i=1:maximSize(2)
    dampedPeriod = (maximIndex(i+1) - maximIndex(i))*execTime/xSize(2);
    ui = maxim(i);
    for k=1:numCyclesAway
        for j=i+1:maximSize(2)
            if maxim(j-1) <= maxim(j) && maxim(j+1) <= maxim(j)
                terminate = 1;
                break;
            end
        end
        if terminate
            break;
        end
    end
    uij = maxim(j);
    break;
end
display(dampedPeriod);
display([ui, uij]);
%zeta = damping ratio
zeta = 1/(2*pi*(numCyclesAway-1))*log(ui/uij);
display(zeta)
