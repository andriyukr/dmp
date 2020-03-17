clc;
close all;
clear all;

%% Load data

indx_Time =  1;
indx_RawH1 = 2:3;
indx_RawH2 = 4:5;
indx_PosH1 = 6:7;
indx_PosH2 = 8:9;
indx_VelH1 = 10:11;
indx_VelH2 = 12:13;
indx_AccH1 = 14:15;
indx_AccH2 = 16:17;
indx_PosO1 = 18:19;
indx_PosO2 = 20:21;
indx_VelO1 = 22:23;
indx_VelO2 = 24:25;
indx_AccO1 = 26:27;
indx_AccO2 = 28:29;

indx_K1 = 37;   %% Siffness
indx_K2 = 38;
indx_B1 = 39;   %% Damping
indx_B2 = 40;
indx_A0 = 41;   %% admittance Object

pathname = [pwd '\..\MATLAB\data\Chris_Davide\session_1\HMan1_Intermit\'];
file_list = dir([pathname '*.mat']);

for i = 10:10%length(file_list)
    filename = file_list(i).name
    load([pathname filename]);
    data = data';
    
    x = [data(:, indx_PosH1(1))];
    wL = [data(:, indx_VelH1(1))];
    aL = [data(:, indx_AccH1(1))];
    y = [data(:, indx_PosH1(2))];
    wR = [data(:, indx_VelH1(2))];
    aR = [data(:, indx_AccH1(2))];
    
    t = [data(:, indx_Time)];
end

dt = mean(diff(t));

% numerical derivation of velocity and acceleration
vx_numerical = [0; diff(x)]/dt;
ax_numerical = [0; diff(vx_numerical)]/dt;
vy_numerical = [0; diff(y)]/dt;
ay_numerical = [0; diff(vy_numerical)]/dt;

%
J = [vx_numerical'; vy_numerical'] * pinv([wL'; wR'])

rotm2eul([J [0; 0]; [0 0 1]])/pi*180

% J = [0 -1; 1 0]

rm = 2 * [vx_numerical' vy_numerical'] * pinv([J(1,1)*wL' + J(1,2)*wR' J(2,1)*wL' + J(2,2)*wR'])

vx_measured = J(1,:)*[wL'; wR'];
vy_measured = J(2,:)*[wL'; wR'];

figure(2);
hold on;
grid on;
plot(t, vx_numerical, 'r', 'linewidth', 2);
plot(t, vy_numerical, 'g', 'linewidth', 2);
% plot(t, wL, 'm--', 'linewidth', 2);
% plot(t, -wR, 'c--', 'linewidth', 2);
plot(t, vx_measured, 'y:', 'linewidth', 2);
plot(t, vy_measured, 'b:', 'linewidth', 2);
xlim([0 max(t)]);
set(gca, 'fontsize', 11);
set(gca, 'TickLabelInterpreter', 'latex');
legend('$\dot{x}$', '$\dot{y}$', '$\tilde{v}_x$', '$\tilde{v}_y$', 'interpreter', 'latex', 'fontsize', 11);
xlabel('$t$ [s]', 'interpreter', 'latex', 'fontsize', 11);
ylabel(['$v$ [m/s]'], 'interpreter', 'latex', 'fontsize', 11);