function J = test_function_WG(b)

[ax,ay,U_0,X,Y,Z,z] = WG_Parameter(4,-1.625,1.625,-1.625,1.625,8,10,b);
Mea_act=griddata(ax,ay,z,X,Y,'linear');
New_z=Z+Mea_act;

%J=mean((New_z-U_0).^2,"all");% This can be used for 2018b and newer version
J = mean(mean((New_z-U_0).^2));

