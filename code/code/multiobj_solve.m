clear
clc
fitnessfcn = @multiobj;   % Function handle to the fitness function
nvars = 1;                      % Number of decision variables
lb = [0];                   % Lower bound
ub = [50];                     % Upper bound
A = []; b = [];                 % No linear inequality constraints
Aeq = []; beq = [];             % No linear equality constraints
options = gaoptimset('ParetoFraction',0.3,'PopulationSize',100,'Generations',200,'StallGenLimit',200,'TolFun',1e-100,'PlotFcns',@gaplotpareto);

[x,fval] = gamultiobj(fitnessfcn,nvars, A,b,Aeq,beq,lb,ub,options);