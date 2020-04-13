function [y_p, pval] = OnlineTrainingfPval(X, y, lambda, theta, iteration,
   b, upd, X_mean, y_mean, X_sd, y_sd, y_val)
  y_p = zeros(size(y));
  pval = zeros(size(y,1),1);
  steps = idivide(size(y,1),b) -1;
  thetaupd = theta;
  thetab = thetaupd;
  X_upd_mean= X_mean;
  y_upd_mean= y_mean;
  Xb0_mean = X_mean;
  yb0_mean = y_mean;
  Xb0=Surfi(X,b,0);
  Xb0_norm = Normalize(Xb0,X_mean,X_sd);
  for i = 0:steps
    [Xb l] = Surfi(X,b,i);
    yb = Surfi(y,b,i);
    [Xb_norm, Xb_mean, X1_sd] = featureNormalize(Xb);
    [yb_norm, yb_mean, yb_sd] = featureNormalize(yb);
    thetab = fminuncYY(Xb_norm, yb_norm, thetaupd, lambda, iteration);
    thetaupd = (1-upd)*thetaupd + upd*thetab;
    X_upd_mean = (1-upd)*X_upd_mean + upd*Xb_mean;
    y_upd_mean = (1-upd)*y_upd_mean + upd*yb_mean;
    yb_np = Xb_norm * thetaupd;
    yb_p = InvNormalize(yb_np, yb_mean, yb_sd);
    y_p(b*i + 1:b*i+l,:)  = yb_p;
    pval(b*i + 1:b*i+l,:)= GetPval(yb, yb_p, y_mean, y_sd);
  endfor
endfunction
