function [ eVector] = eigVector( imgMatrix,average )
%......................................................................
%calcuate eigenVector
numImg = size(imgMatrix,2);
%compute difference with average for each vector
A = imgMatrix - repmat(average,1,numImg);
tic;
%covariance matrix
Cmatrix = A'*A;
[V D] = eig(Cmatrix);
%sort 
D = abs(diag(D));
[evalue sort_idx] = sort(D,'descend');
V = V(:,sort_idx);
V = V(:,1:numImg);
mVector = A*V;
toc;
eVector = zeros(17864,numImg);
for i = 1:numImg
    a = 0;
    for j = 1:17864
        a = a + mVector(j,i)^2;
    end
    base = sqrt (a);
    eVector(:,i) = mVector(:,i)/base;
end
end

