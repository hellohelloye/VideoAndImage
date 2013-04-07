function [aftSmoothImg] = gaussianSmoothing(deviation,originalImage)
[x_size,y_size]=size(originalImage);
w=5*deviation;
mp=(w+1)/2;
for i=1:w
    G0(i)=exp(-((i-mp)^2)/(2*(deviation^2)))/deviation*sqrt(2*pi);
end
G1=G0/G0(1);
G2=floor(G1);
G=G2/sum(G2);
matrix=zeros(x_size,y_size);
for i=1:x_size
    holdmatrix=conv2(originalImage(i,:),G,'same');
    matrix(i,:)=holdmatrix;
end 
for j=1:y_size
    midmatrix=conv2(matrix(:,j),transpose(G),'same');
    matrix(:,j)=midmatrix;
end
aftSmoothImg=matrix;
end

