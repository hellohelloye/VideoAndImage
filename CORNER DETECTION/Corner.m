clear;close all;clc;

I1 = imread('Building(1).jpg');
I1 = rgb2gray(I1);

N = 3;
low = 100;

k = 1;  %deviation

n = 5*k;

I1 = double(I1);
n1 = floor((n+1)/2);
[Iwidth,Ilength] = size(I1);

for i = 1:n                                               
       a(i) = exp((-(i-n1)^2)/(2*k^2))/(k*sqrt(2*pi));
end

a = a/a(1);                                              
a = floor(a);
b = a/sum(a);

C(1:Iwidth,1:Ilength) = 1;

 for i = 1:Iwidth                                        
   C1 = conv2(I1(i,:),b,'same');
   C(i,:) = C1;
 end

b1 = b';
 
  for i = 1:Ilength
   C2 = conv2(C(:,i),b1,'same');
   C(:,i) = C2;
  end
  
Is = C;
Is = uint8(Is);

Jx(1:Iwidth,1:Ilength) = 1;
Jy(1:Iwidth,1:Ilength) = 1;

a = [1 0 -1];

for i = 1:Iwidth
    C1 = conv2(single(Is(i,:)),single(a),'same');
    Jx(i,:) = C1;
end

a = [-1;0;1];

for i = 1:Ilength
    C2 = conv2(single(Is(:,i)),single(a),'same');
    Jy(:,i) = C2;
end

l = Iwidth*Ilength;
Lx(1:l) = 0;
Ly(1:l) = 0;
Lm(1:l) = 0;
l1 = 1;

for i = N+1:Iwidth-N
    for j = N+1:Ilength-N
        
        a = 0;
        b = 0;
        c = 0;
        
        for i1 = i-N:i+N
            for j1 = j-N:j+N
                a = a+Jx(i1,j1)*Jx(i1,j1);
                b = b+Jx(i1,j1)*Jy(i1,j1);
                c = c+Jy(i1,j1)*Jy(i1,j1);
            end
        end
      
        D = [a b;b c];
        e = eig(D);
        m = min(e);
        
        if m>low
            Lx(l1) = i;
            Ly(l1) = j;
            Lm(l1) = m;
            l1 = l1+1;
        else
            l1 = l1;
        end
        end
end

Lx(Lx==0) = [];
Ly(Ly==0) = [];
Lm(Lm==0) = [];

[Lm,ind] = sort(Lm,'descend');

n = length(Lm);
Mx(1:n) = 0;
My(1:n) = 0;

for i = 1:n
    Mx(i) = Lx(ind(i));
    My(i) = Ly(ind(i));
end

Lx = Mx;
Ly = My;
i1 = 1;

for i = i1:n-1
    for j = i+1:n
        if Lx(j)>=Lx(i)-2*N-2&&Lx(j)<=Lx(i)+2*N+2&&Ly(j)>=Ly(i)-2*N-2&&Ly(j)<=Ly(i)+2*N+2
            Lx(j) = 0;
            Ly(j) = 0;
        else
            Lx(j) = Lx(j);
            Ly(j) = Ly(j);
        end
    end  
end

Lx(Lx==0) = [];
Ly(Ly==0) = [];

n = length(Lx);

for i = 1:n
    a = Lx(i)-N;
    b = Ly(i)-N;
    
    for j = 0:2*N
        Is(a,b+j) = 255;
        Is(a+2*N,b+j) =255;
    end
    
    for j = 1:2*N-1
        Is(a+j,b) = 255;
        Is(a+j,b+2*N) = 255;
    end
end

Is = uint8(Is);
figure;
imshow(Is);