%=====================================================================%
%              Planet Gear Reduction Ratio Calculator                 %
%---------------------------------------------------------------------%
%  Coded by:  EMRE DAĞ                                  14/03/2022    %
%=====================================================================%
% Let R, P and S be the number of teeth on ring, planet and sun gear,
% respectively. Also, let Tr, Tc and Ts be the angular speed of ring gear,
% planet carrier and sun gear, respectively. Then, the relation between
% these gears can be expressed as follows.
%   (R+S)*Tc = R*Tr + Ts*S
% For a fixed ratio gearbox, it is practical to fix one of the gear.
% Therefore, there are 3 configuration of input and output that results in
% gear reduction. These 3 cases are compared in this script by keeping the
% # of teeth on ring gear constant. It is because the ring gear determines the
% outer diameter of the gearbox.

clear all
clc

ringT=input("Number of teeth on the ring gear:  "); % number of teeth on ring gear
minSunT=24; %minimum number of gear teeth on sun gear due to physical applicability
upperLimitofSunT=ringT-minSunT;
sunT=(minSunT:2:upperLimitofSunT)'; % number of teeth on the sun gear
planetT= (ringT-sunT)/2; % number of teeth on a single planet gear

%% CASE-1:Ring is fixed. Sun is input. Planet carrier is output.

R_1= 1./(sunT./(ringT+sunT));  %R_1 represents the gear reduction ratio for case 1
i=10;
sun(1)=sunT(i);

planet(1)=planetT(i);

%% CASE-2:Planet carrier is fixed. Sun is input and ring is output

R_2=1./(-sunT./ringT);   %R_2 represents the gear reduction ratio for case 2

%% CASE-3: Sun gear is fixed. Ring gear is input. Planet carrier is output.

R_3=(ringT+sunT)./(ringT);  %R_3 represents the gear reduction ratio for case 3


j=20;
%% results

x=sunT;
plot(x,R_1, 'LineWidth',2)
title(" Gear Reduction versus sun gear teeth for ringGearTeeth=120 ");
xlabel('Sun gear teeth');
ylabel('Gear Reduction Ratio');
grid on
hold on

plot(x,-R_2,'LineWidth',2); 
% note that R_2 is multiplied by -1. 
%Since it causes a direction change, it is better to consider positive value
%for comparison purposes.

plot(x,R_3,'LineWidth',2);
legend('Case-1','Case-2(negative)','Case-3 ');
hold off

A=[R_1,-R_2,R_3];

maxGearReduction=max(A, [], 'all');
X = ['maximum achievable gear reduction is ', num2str(maxGearReduction)];
disp(X);

%% CASE-1:Ring is fixed. Sun is input. Planet carrier is output.
%% CASE-2:Planet carrier is fixed. Sun is input and ring is output.
%% CASE-3: Sun gear is fixed. Ring gear is input. Planet carrier is output.
%%
%For the reduction needed, we can adopt the following approach.
% Determine the torque needed at the output. Then, define the number of
% stages. Taking the efficiency into consideration, determine the input
% torque. Finally, list all the torque and velocity values starting from
% input to the output

outputTorque=input("Torque needed at the output in Nm:  "); %torque needed at the output

stageNumber=input("Enter the number of planetary gear stages:  "); % number of planetary gear stages
efficiency=0.9; % efficiency for a stage of compound planetary gearset
Torque(stageNumber)=outputTorque;
for i=1:stageNumber-1
Torque(stageNumber-i)= Torque(stageNumber-i+1)./maxGearReduction/efficiency;
i
end
Torque
TotalReduction=maxGearReduction^stageNumber

