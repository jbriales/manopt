function x = iterinv(linfun,b,opts)
% Try to solve the vector x so that
%   linfun(x) = b
% This operator is intended for inversion of linear operators given
% in function handle form. It must resort to iterative algorithms
% and there is no optimality guarantess.
% Plenty of casuistics may occur depending on symmetric, PSD, etc.
% Also, solvability of the linear problem must be assured from outside,
% otherwise the solver will be probable unstable (e.g. for degenerate
% operators such that linfun(x0)=0 for x!=0).
% 
% INPUT:
%   linfun - a function handle corresponding to a linear operator,
%            that is, linfun(lincomb({x_i})) = lincomb({linfun(x_i)})
%   b      - the independent term
%   opts   - struct of options providing useful information about linfun

% This file is part of Manopt: www.manopt.org.
% Original author: Jesus Briales, Feb. 08, 2017.
% Contributors: 
% Change log:

% Setup input
p = inputParser;

% addRequired(p,'width',@isnumeric);
%    addOptional(p,'height',defaultHeight,@isnumeric);
%    addParameter(p,'units',defaultUnits);
%    addParameter(p,'shape',defaultShape,...
%                  @(x) any(validatestring(x,expectedShapes)));
% 
%    parse(p,width,varargin{:});
%    a = p.Results.width .* p.Results.height;

assert(opts.isreal,'Complex operators are not considered here')

if opts.issym
  % Symmetric non-definite case: symmlq
  % Note: The Hessian must be symmetric but needs not to be positive definite
  %       Because of this we use symmlq instead of pcg
  % NOTE: If we are sure Hessian is PSD (e.g. local minimum)
  %       then we could use pcg?
  TOL = 1e-3;
%   MAXIT = 50;
%   MAXIT = 100;
  MAXIT = 200;
  [x,FLAG,RELRES,ITER,RESVEC,RESVECCG] = symmlq(linfun,b,TOL,MAXIT);
%   [x,FLAG,RELRES,ITER,RESVEC,RESVECCG] = symmlq(linfun,b);
  
end

if FLAG ~= 0
  warning('Error when solving Hessian problem')
%   keyboard
end

% Non-symmetric case: gmres

% Check goodness of the result
norm_res = norm( linfun(x) - b );
% keyboard

end
