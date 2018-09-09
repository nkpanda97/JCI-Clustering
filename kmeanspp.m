function [init_c]=kmeanspp(X,k)

[m n]=size(X);
init_c = zeros(k,n);
init_c(1,:)=X(randi(m),:);
D = inf(m,k);
for i=1:1:k-1
    a=kron(init_c(i,:),ones(m,1));
    D(:,i)=cumsum(min(sum((X-a).^2,2),[],2));
    init_c(i+1,:)=(X(find(rand < (D(:,i)/D(end,i)),1),:));
end
