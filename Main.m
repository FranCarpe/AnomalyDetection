pkg load statistics
clear, clc, close all
%%%LOAD DATA%%% 
t = 20000; 
divyR = 50;
divXR = 50;
an = 7;
[X, y, yval, sigma, t1] = Data3(divXR,divyR,an,t);
%%% Get Initial Theta, Mean, Sd, yp0 

X0 = X(1:t1,:);
y0 = y(1:t1,:);
yval0 = yval(1:t1,:);

[X0_norm, X0_mean, X0_sd] = featureNormalize(X0);
[y0_norm, y0_mean, y0_sd] = featureNormalize(y0);

iterations = 400;
lambda = 1;
theta = ones(size(X,2),size(y,2));
theta = fminuncYY(X0_norm, y0_norm, theta, lambda, iterations);
yp0_norm = X0_norm*theta;
yp0 = InvNormalize(yp0_norm, y0_mean, y0_sd);
%%% PLOT 1
plot(1:20:t1,y(1:20:t1,1),'@')
hold on;
plot(1:20:t1,yp0(1:20:t1,1),'@')
legend ({"Ejemplos", "Predicho"}, "location", "east");
ylabel("Intensidad (A)")
xlabel("Tiempo(h)")
hold off;

%%% Get Pval, Epsilon & F1_initial
pval0= GetPval(y0, yp0, y0_mean, y0_sd);
[epsilon F1_initial] = selectThreshold(yval0, pval0)
outliers = find(pval0 < epsilon);
hold on
title("Anomalías")
plot(outliers, y0(outliers, 1), 'ro', 'LineWidth', 2, 'MarkerSize', 10);
hold off

%%% Online Training
lambda = 1;
iteration=400;
b=200;
upd = 1;
[yp, pval] = OnlineTrainingfPval(X, y, lambda, theta, iteration,
 b, upd, X0_mean, y0_mean, X0_sd, y0_sd);

%%% PLOT 2
plot(1:20:t,y(1:20:t,1),'@')
title("Intensidad del motor")
xlabel("Tiempo (h)")
ylabel("Intensidad (A)")
hold on;
plot(1:20:t,yp(1:20:t,1),'@')
legend ({"Ejemplos", "Predicho"}, "location", "east");
hold off;


%%% Get F1
[F1] = GetF1(yval, pval,epsilon)
outliers = find(pval < epsilon);
hold on
plot(outliers, y(outliers, 1), 'ro', 'LineWidth', 2, 'MarkerSize', 10);
hold off

fprintf('Program paused. Press enter to continue.\n');
pause;