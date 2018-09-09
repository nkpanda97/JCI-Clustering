function [My_data, no_of_floors, no_of_nodes_per_floor,fig_handle] =arrange_Data_in_3d_array(DATA)

X=DATA(:,1);
Y=DATA(:,2);
Z=DATA(:,3);
no_of_floors=size(unique(Z),1);
n=1;
no_of_nodes_per_floor=size(DATA,1)/no_of_floors;
s= no_of_nodes_per_floor;
cordinates=[X Y];
V=cordinates(:);
My_data=reshape(V(1:2*s),34,2);
for i=2:no_of_floors
    My_data(:,:,i)=reshape(V((i*s+1):((i*s+1)+2*s-1)),s,2);
end

syms x y z
fig_handle=figure;
for i=unique(DATA(:,3))
    z=i;
    fmesh(z,'MeshDensity',20,'FaceColor','none')
    hold on
    axis tight;
end
T=ones(no_of_nodes_per_floor,1)+999;
hold on
plot3(My_data(:,1,1),My_data(:,2,1),T,'r.','MarkerSize',25)
hold on
plot3(My_data(:,1,2),My_data(:,2,2),T+1000,'k.','MarkerSize',25)
hold on
plot3(My_data(:,1,3),My_data(:,2,3),T+2000,'b.','MarkerSize',25)
hold on
plot3(My_data(:,1,4),My_data(:,2,4),T+3000,'k.','MarkerSize',25)
hold on
plot3(My_data(:,1,5),My_data(:,2,5),T+4000,'m.','MarkerSize',25)
hold on
plot3(My_data(:,1,6),My_data(:,2,6),T+5000,'g.','MarkerSize',25)
end

