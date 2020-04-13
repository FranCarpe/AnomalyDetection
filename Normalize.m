function [X_norm] = Normalize(X,mu, sigma)
%FEATURENORMALIZE Normalizes the features in X 
%   FEATURENORMALIZE(X) returns a normalized version of X where
%   the mean value of each feature is 0 and the standard deviation
%   is 1. This is often a good preprocessing step to do when
%   working with learning algorithms.

% You need to set these values correctly


for j = 1:size(mu,2)
  if sigma(1,j) == 0
    sigma(1,j) = 1;
  endif
endfor
X_norm = (X-mu)./sigma;



end
