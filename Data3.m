function [X, y, yval, sigma, t1] = Data3(divXR,divyR,an,t)
pkg load statistics

%
%%% Creamos entradas
%
t1 = idivide(t,2); 
Voltagec = 230; %V
I2c = 5; %A
P1uc= 1500; %kW
Yieldc=0.85; 

Voltage = Voltagec * ones(t,1);
I2 = I2c * ones(t,1) + I2c/4/t*(1:t)';
P1u = P1uc * ones(t,1);
Yield = Yieldc* ones(t,1);
Yield(t1+1:t,1) = Yield(t1+1:t,1) - 0.2/t1*(1:(t-t1))';


%Reagrupamos en X
X = [Voltage I2 P1u];
XR = 0;
% Añadimos ruido a X
sigmaX = zeros(1,size(X,2));
XR=zeros(size(X));
sigmaX(1,1) =  Voltagec/4./divXR;
sigmaX(1,2) = (max(X(:,2))-min(X(:,2)))./divXR;
sigmaX(1,3) = P1uc/4./divXR;
XR(:,1:size(X,2))= sigmaX(1,1:size(X,2)).*normrnd(0,1,[t,size(X,2)]);
X = X + XR;
Voltage = X(:,1);
I2 = X(:,2);
P1u = X(:,3);
%Añadimos parámetros adicionales
PuV = P1u./Voltage; %6,52..
VI2 = Voltage.*I2; 
X = [X PuV VI2];
%plot(1:10:t,X(1:10:t,4),'@')

%
%%%Creamos salidas
%

I1 = PuV./Yield/3/0.85;
P2 = 0.8 .* VI2;
P1a = P1u./Yield;
Ppe = P1a - P1u; %W
Pt = P1a + P2;
%Reagrupamos en y
%y = [I1 P1a P2 Ppe Pt];
y = [I1 P1a P2];
yr = 0;
% Añadimos ruido a y
sigmay = zeros(1,size(X,2));
XR=zeros(size(X));
for i = 1:size(y,2)
  sigmay(1,i) =  ((max(y(:,i))-min(y(:,i)))./2 + max(y(:,1))./8)./divyR;
endfor

yR(:,1:size(y,2))= sigmay(1,1:size(y,2)).*normrnd(0,1,[t,size(y,2)]);

y = y + yR;



sigma = sigmay;
%% Añadimos anomalías 
yval = zeros(t,1);
yA = zeros(size(y));
for i = 1:200:t
  for j = 1:size(y,2)
    yR(i,j) = yR(i,j).*an;
  endfor
yval(i,1)=1; 
endfor

y =y + yR + yA;
sigma = sigmay;
endfunction

