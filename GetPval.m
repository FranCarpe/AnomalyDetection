function [pval]= GetPval(y, yp, y_mean, y_sd)
y_norm = Normalize(y, y_mean, y_sd);
yp_norm = Normalize(yp, y_mean, y_sd);
for i =1:size(y,1)
  pval(i,:) = multivariateGaussian(y_norm(i,:), yp_norm(i,:), 1);
endfor
endfunction

