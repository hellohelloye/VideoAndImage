function [ V ] = firstMethod( imgMatrix )
%compute difference with average for each vector
A = imgMatrix - repmat(average,1,numImg);

tic;
%covariance matrix
Cmatrix = A*A';
[V D] = eig(Cmatrix);

toc

end

