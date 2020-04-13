function [theta, J_history] = fminuncYY(X, y, theta, lambda, num_iters)

J_history = zeros(num_iters, 1);
initital_theta = zeros(size(X,2),1);
options = optimset('GradObj', 'on', 'MaxIter', num_iters);

for i = 1:size(y,2)
    J_historyb = zeros(num_iters, 1);
    initial_theta(:,1) = theta(:,i);
    [theta(:,i), J_historyb, exit_flag] = ...
	fminunc(@(t)(linearRegCostFunction(t, X, y(:,i), lambda)), initial_theta, options);
    J_history = J_history + J_historyb;
endfor
end
