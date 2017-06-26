function Test_productManifold

% Define a linear space
tic
M1 = stiefelstackedfactory(5000,3,5);
M = productmanifold(M1);
toc
keyboard

% random symmetric square matrix
Q = multisym(randn(m));

% Create the problem structure.
problem.M = manifold;

% Define the problem cost function, Euclidean gradient and Hessian.
problem.cost = @cost;
function f = cost(X)
  f = 0.5*trace(X'*Q*X);
end

problem.egrad = @egrad;
function G = egrad(X)
  G = Q*X;
end

problem.ehess = @ehess;
function H = ehess(X, Xdot)
  H = Q*Xdot;
end

% Check gradient and Hessian correctness
% This is a quadratic function in a linear manifold,
% so the quadratic approximation used in `checkhessian` should be exact
% Other similar cases are those where the unknowns belong to a tangent
% space (also a linear manifold).
checkgradient( problem ); pause
checkhessian(  problem ); pause

end