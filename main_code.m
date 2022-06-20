%% Author : Ravi Ashok Pashchapur
%% Date: 08 /07 / 2019
%% license: MIT


%% Create a figure. 
figure
Am = axes('position',[.1 .1 .8 .8]);

%% Assigning 3D Co-ordinate system.
view(3)
rotate3d
hold on

%% Draw Vehicle co-ordinates. 
Lx = line([0 0.5],[0,0],[0,0],'color',[1,0,0],'linewidth',5);
Ly = line([0 0],[0,0.5],[0,0],'color',[0,1,0],'linewidth',5);
Lz = line([0 0],[0,0],[0,0.5],'color',[0,0,1],'linewidth',5);

%% Draw refrencea co-ordinates.
line([0 1.5],[0,0],[0,0],'color',[0,0,0],'linewidth',1);
line([0 0],[0,1.5],[0,0],'color',[0,0,0],'linewidth',1);
line([0 0],[0,0],[0,1.5],'color',[0,0,0],'linewidth',1);
%% Add text to vehicle and fixed co-ordinates.

text('position',[1.3 0 .1],'string','x_0','fontw','b');
text('position',[ 0 1.3 .1],'string','y_0','fontw','b');
text('position',[.05 0.05 1.3],'string','z_0','fontw','b');
    
tX = text('position',[.7 0 .1],'string','x','fontw','b');
tY = text('position',[ 0 .7 .1],'string','y','fontw','b');
tZ = text('position',[.05 0.05 .7],'string','z','fontw','b');
grid on

%% Add centre of gravity in co-ordinate system.

[xx,yy,zz]=sphere;
 pp = surf(xx.*.11,yy.*0.11,zz.*.11);
 colormap default
 
plot3(0,0,0,'.','markersize',20,'color','k')

%% what should be rotated.
R = [tX,tZ,tY,Lx,Ly,Lz,pp];

%% Orientation of aerial vehicle.
conv = 'zyx';


%% Values of all 3 angles phi==a, theta==b and psi==g.
a = (30/180)*pi;
b = (30/180)*pi;
g = (30/180)*pi;

%% Call euler function to evaluvate all three rotational matrix.
s = eulfor(a,b,g,conv);

%% Making the first rotation. 
for k = 1:20
			if strcmp(conv(1),'x')
				rotate(R,[1,0,0],rad2deg(a/20),[0,0,0])
			elseif strcmp(conv(1),'y')
				rotate(R,[0,1,0],rad2deg(a/20),[0,0,0])
			elseif strcmp(conv(1),'z')
				rotate(R,[0,0,1],rad2deg(a/20),[0,0,0])
			end
			pause(.1)
		end
		
%% Initialising new vectors for x,y and z (For Second rotation).
 pxx = eval(['get(L',conv(2),',','''xdata''',')']);
 pyy = eval(['get(L',conv(2),',','''ydata''',')']);
 pzz = eval(['get(L',conv(2),',','''zdata''',')']);
		
		
%% Rotate for second time
for k = 1:20
			
	rotate(R,[pxx(2)-pxx(1),pyy(2)-pyy(1),pzz(2)-pzz(1)],rad2deg(b/20),[0,0,0])
			
	pause(.1)
end
%% Initialising new vectors for x,y and z (For Third rotation).
pxx2 = eval(['get(L',conv(3),',','''xdata''',')']);
pyy2 = eval(['get(L',conv(3),',','''ydata''',')']);
pzz2 = eval(['get(L',conv(3),',','''zdata''',')']);
		
%% Rotate for third time.
for k = 1:20
			
	rotate(R,[pxx2(2)-pxx2(1),pyy2(2)-pyy2(1),pzz2(2)-pzz2(1)],rad2deg(g/20),[0,0,0])
			
	pause(.1)
end
