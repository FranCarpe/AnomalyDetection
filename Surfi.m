function [x_s l] = Surfi(x,b,i)
l=0;  
if i  > idivide(size(x,1),b)
  x_s = NaN;
  l =b;
elseif i == idivide(length(x),b)
  l = rem(length(x),b);
  x_s = zeros(l,size(x,2));
  x_s = x(i*b+1:end,:);
elseif i == 0
  l = b;
  x_s = zeros(b,size(x,2));
  x_s = x(1:b,:);
else 
  l = b;
  x_s = zeros(b,size(x,2));
  x_s = x(i*b + 1:b*(i+1),:);
endif

end