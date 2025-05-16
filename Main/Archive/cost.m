function J=cost(b)

[~,~,~,~,Reg,~,~,Act,U_0]=sys_paramers();
%% original measurements

%% toy model: replaced by WG control system
%%
%(1)save z for control;
%(2)load measurement feedback from WindGenerator;
%(3)set up cost evaluation J based on measurment;

[X,Y,In]=Ref();
z=control_law(b);
[act_x,act_y]=size(Act); 
a1=linspace(Reg(1,1),Reg(1,2),act_x);
a2=linspace(Reg(2,1),Reg(2,2),act_y);
[ax,ay]=meshgrid(a1,a2);
Mea_act=griddata(ax,ay,z,X,Y,'linear');
New_z=In+Mea_act;

%J=mean((New_z-U_0).^2,"all");% This can be used for 2018b and newer version
J = mean(mean((New_z-U_0).^2));
%%

