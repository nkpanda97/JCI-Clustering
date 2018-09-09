% clc
% clear all
% X = reshape([1:24],8,3);
% idx=[1 1 3 3 4 4 2 2]';
% K=4;
% [m,n] = size(X);
% centroids = zeros(K, n);
% Xnew=sortrows([X idx],n+1);
% u=unique(idx);
% 
% 
% s=1;
% for i=u'
%     A=Xnew(:,n+1)==i;
%     A1=Xnew.*A;
%     N=sum(A);
%     centroids(s,:)=(1/N)*(sum(A1(:,1:n)));
%     s=s+1;
% end
clc

clear all

load('ex7data2.mat');
X=[X;[X(:,1).*rand(300,1) X(:,1).*rand(300,1)]];
initial_centroids = [3 3 ; 6 2 ; 8 5 ];
idx=findClosestCentroids(X,initial_centroids);

[centroids, idx] = runkMeans(X, initial_centroids, 10, true)