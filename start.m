
clear all
close all
clc
load('/Users/Apple/Desktop/FinalDay/CODE_V_1.0.0/DATA.txt')
 [My_data, no_of_floors,...
    no_of_nodes_per_floor,fig_handle] =arrange_Data_in_3d_array(DATA);

pause
%% =================== Part 2: K-Means Clustering ======================

% Settings for running K-Means

K = 5;
max_iters = 4;

%% Initialization using kmeans++
initial_centroids=zeros(K,2,no_of_floors);
for i=1:no_of_floors
    initial_centroids(:,:,i)=kmeanspp(My_data(:,:,i),K);
end

% Run K-Means algorithm. The 'true' at the end tells our function to plot
% the progress of K-Means
% centroids=zeros(K,2,no_of_floors);
% idx=zeros(no_of_nodes_per_floor,1,no_of_floors);
figure
for i=1:no_of_floors
    subplot(3,2,i)
    [centroids(:,:,i), idx(:,:,i)] = runkMeans(My_data(:,:,i),...
        initial_centroids(:,:,i), max_iters, true);
  

end
%% =================== Part 3:ENERGY COMPARASION ======================
Weight_Matrix=zeros(K,1,no_of_floors);
alpha=0.1;
WEIGHT_MATRIX=(100-alpha*DATA(:,4)+DATA(:,5)+0.5*DATA(:,6)-(1/10)*DATA(:,7) ...
    +0.5*DATA(:,8)+DATA(:,9));
s= no_of_nodes_per_floor;
weights=reshape(WEIGHT_MATRIX(1:s),no_of_nodes_per_floor,1);
 
for i=2:no_of_floors
    weights(:,:,i)=reshape(WEIGHT_MATRIX(((i-1)*s+1):(((i-1)*s+1)+s-1)),s,1);
end


My_data=[My_data  weights idx];
leadernodes=zeros(K,4,no_of_floors);% (X Y weights Index)..pages
for i=1:no_of_floors
    for j=1:K
        V=0;
        L=My_data(:,4,i)==j;
        V=L.*weights(:,:,i);
        [~,I]=max(V,[],1);
        leadernodes(j,:,i)=[My_data(I,1:3,i) I];
    end
end
% leadernodes 
        
% sorting the found leader nodes according to max weight
sorted_leader_nodes=zeros(K,4,no_of_floors);% (X Y weights Index)..pages
        
for l=1:no_of_floors
    
    sorted_leader_nodes(:,:,l)=sortrows(leadernodes(:,:,l),3);
end
% sorted_leaders has the nodes in ascending weight for each floor.

Final_chosen_leaders=zeros(no_of_floors,2);% rows-> floor, Columns -> X,Y
for i=1:no_of_floors
    Final_chosen_leaders(i,:)=sorted_leader_nodes(end,1:2,i);
end

figure(fig_handle);
z=1:no_of_floors;
plot3(Final_chosen_leaders(:,1),Final_chosen_leaders(:,2),z'*1000,'r*','Markersize',25,'LineWidth',3);







