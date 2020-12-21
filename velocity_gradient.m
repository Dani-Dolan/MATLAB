clear all
close all

x=0:5:20;
y=0:10:40;
z=0:20:80;

[X,Y,Z]=meshgrid(x,y,z);
for i=1:length(x)
    for j=1:length(y)          
        for k=1:length(z)  
            v1(i,j,k) = x(i)^2 + y(j)^2 + z(k)^2;
            v2(i,j,k) = 2*( x(i)*y(j)*z(k) );
            v3(i,j,k) = x(i) + y(j) + 2*z(k);
            if v1(i,j,k)>v2(i,j,k)
                disp(['Vx is greater than Vy; ','Vx=',num2str(v1(i,j,k)),' Vy=',num2str(v2(i,j,k))])
            elseif v1(i,j,k)<v2(i,j,k)
                disp(['Vx is less than Vy; ','Vx=',num2str(v1(i,j,k)),' Vy=',num2str(v2(i,j,k))])
            end
        end
    end
end

fig1 = figure(1)
quiver3(X,Y,Z,v1,v2,v3);

title('Vector Field')
xlabel('x-component')
ylabel('y-component')
zlabel('z-component')
set(gca,'FontSize',12)
set(gca,'ZDir','reverse')
div = divergence(X,Y,Z,v1,v2,v3);
[curlx,curly,curlz,cav] = curl(X,Y,Z,v1,v2,v3);


%%
inDir='C:\Users\danikadolan757\Desktop\';
inFile='simple_velmod.txt';
input=[inDir,inFile];
outDir=[inDir,datestr(now,'yyyymmdd_HHMMSS'),'\'];
mkdir(outDir)
cd(outDir)
fid=fopen(input);
A=fscanf(fid,'%f %f\n',[2 Inf])';
fclose(fid);
velgrad=gradient(A(:,2),100);
fig2 = figure(2)
plot(velgrad,A(:,1));
axis ij
title('Changes of Velocity Gradient with Depth')
xlabel('Velocity Gradient')
ylabel('Depth (m)')
set(gca,'FontSize',12)
set(gca,'ZDir','reverse')
grid on 
saveas(fig2,'Changes of Velocity Gradient with Depth.jpg')
saveas(fig1,'Vector Field.jpg')

save('variables.mat','div','velgrad')
cd('..\')
