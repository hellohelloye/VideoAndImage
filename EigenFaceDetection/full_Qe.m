%..........................................................
%Yukui Ye HW4  full_e.m is for question a-e; test question e)
%........................................................
clear;close all;clc;

%.........................................................................
%get the whole traning set ImageMatrix as well as its average
fileName = dir('C:\Users\yye_000\Documents\MATLAB\yalefaces_centered_small\*.jpg');
numberImgs = length(fileName);
imgs = cell(numberImgs,1);
imgMatrix (1:154*116,1:numberImgs)=0;
for i= 1: numberImgs
    imgs{i} = imread( fileName(i).name );
    imgMatrix(:,i) = reshape(imgs{i},154*116,1);
end
average = mean(imgMatrix,2);
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
V = V(:,1:numberImgs);
mVector = A*V;
toc;
eVector = zeros(17864,numberImgs);
for i = 1:numberImgs
    a = 0;
    for j = 1:17864
        a = a + mVector(j,i)^2;
    end
    base = sqrt (a);
    eVector(:,i) = mVector(:,i)/base;
end
%.........................................................................
%get TestSet Image matrix
fileName2 = dir('C:\Users\yye_000\Documents\MATLAB\yalefacesTestSet\*.jpg');
numberImgs2 = length(fileName2);
imgs = cell(numberImgs2,1);
testMatrix (1:154*116,1:numberImgs2)=0;
for i= 1: numberImgs2
    imgs{i} = imread( fileName2(i).name );
    testMatrix(:,i) = reshape(imgs{i},154*116,1);
end
%.......................................................................
%get testSetImageMatrix's WeightMatrix
numImg3 = size(testMatrix,2);
m = testMatrix - repmat(average,1,numImg3);
%weightMatrix = eVector' * m; //another way to caculate weightMatrix
weightMatrix(1:numberImgs2,1:numberImgs) = 0;
for i = 1:numberImgs2
    for j = 1:numberImgs
    weightMatrix(i,j) = (eVector(:,j))'*m(:,i);
    end
end
%........For Testing..............................................
%get averageImageMatrix's WeightMatrix...........................
%wAver = eVector'*A;
%wei = weightMatrix';
wAver(1:numberImgs,1:numberImgs) = 0;
for i = 1:numberImgs
   for j = 1:numberImgs
       wAver(i,j) = (eVector(:,j))'*A(:,i);
    end
end
%test the 20 testSet Images
test1(1:numberImgs) = 0;
test2(1:numberImgs,1:numberImgs) = 0;
for k = 1:numberImgs2   
    for i = 1:numberImgs
        test2(:,i) = weightMatrix(k,:)-wAver(i,:);
        rst = 0;
        for j = 1:numberImgs
            rst = rst+test2(k,j)*test2(k,j);
        end
        test1(i) = rst;
    end
    m= min(test1);
    idx = find(test1==m);
    subplot(1,2,1);
    tImg = reshape(testMatrix(:,k),154,116);
    imshow( uint8(tImg));
    % find relative image in training set
    relative = reshape(imgMatrix(:,idx),154,116);
    subplot(1,2,2);
    imshow(uint8(relative));
    figure;
end