clear; close all
%% Generate data

PI=pi;

colorsgt={[ .5 0.447058823529412 0.741176470588235 ],...
        [0.850980392156863   0.825490196078431   0.098039215686275],...
        [0.929411764705882   0.694117647058824   0.625490196078431],...
        [0.929411764705882   0.394117647058824   0.325490196078431],...
         };

colors={[ .5 0.247058823529412 0.741176470588235 ], ...
        [0.850980392156863   0.425490196078431   0.098039215686275], ...
        [0.829411764705882   0.394117647058824   0.625490196078431], ...
        [0.329411764705882   0.694117647058824   0.625490196078431], ...
        };

par(:,:,1)=[-5 2;
            -8 0];
par(:,:,2)=[-5 2;
            0 7];
par(:,:,3)=[2 4;
            -8 0];
par(:,:,4)=[2 4;
            0 7];

x1 = linspace(min(par(1,:)),max(par(1,:))-0.1,20);
x2 = linspace(min(par(2,:)),max(par(2,:))-0.1,20);
[X1 ,X2 ] = meshgrid(x1,x2);

x=[X1(:)';X2(:)'];

m(:,:,1)=[1;
          0];
m(:,:,2)=[5;
          3];
m(:,:,3)=[15;
          4];
m(:,:,4)=[2;
          2];

n(:,:,1)=[0];
n(:,:,2)=[0];
n(:,:,3)=[-40];
n(:,:,4)=[0];

theta=vertcat(m, n);

y = pwa(par,theta,x);

figure(1)
subplot(2,1,1)
cla
plot_pwa(par,x,y,colorsgt)
view(7,17)
title('Ground truth');
xlabel('x1')
ylabel('x2')

modes=size(theta,3);

%% Initialize estimated parameters

emMaxIter=200;
maxErr=1e-4;

%% EM Algo

[C,d,responsabilities,pi,Sigma] = emgm_estimate(x,y,modes,emMaxIter,maxErr,m,n,colors);

reshape(m,size(m,1),size(m,3))
reshape(C,size(C,1),size(C,3))
