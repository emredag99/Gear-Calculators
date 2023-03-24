%=====================================================================%
%                     Planet Gear Strength Calculator                 %
%---------------------------------------------------------------------%
%  Coded by:  EMRE DAĞ                                  17/03/2022    %
%=====================================================================%
clear all
close all
clc

%https://engineering.stackexchange.com/questions/16136/calculating-load-on-planetary-gear-from-driving-torque
%above is reference

%gear properties
Ns=35; % tooth number of sun gear
Np=35; % tooth number of planet gear
Nr=2*Np+Ns; %tooth number on ring gear
planetNumber=3; %number of planet gears
m=0.75; % module of the gear [mm]
phi=20*pi/180; %pressure angle [rad]

% the calculations are conducted for fixed ring gear and sun as input
reduction=1+Nr/Ns;
Ti=2000; %input torque to the sun gear [N.mm]

%geometric properties of sun gear
rBaseSun=0.5*Ns*m*cos(phi); %base circle radius of sun [mm]

Fps=Ti/(planetNumber*rBaseSun); %force exerted on a single planet gear by sun along the pressure line [N]

%to find the force on a single teeth, force should be divided by the
%contact ratio. below calculations are for sun-planet set

pb=pi*m*cos(phi); %base pitch [mm]
% 1 is for sun, 2 is for planet gear
rO1=0.5*Ns*m+m; %addendum circle of gear 1(sun) [mm]
rb1=0.5*Ns*m*cos(phi); %base circle of gear 1(sun) [mm]
rO2=0.5*Np*m+m; %addendum circle of gear 2(planet) [mm]
rb2=0.5*Np*m*cos(phi); %base circle of gear 2(planet) [mm]
C=(Ns+Np)*m/2; %center distance of the gear 1 and 2 [mm]

rhoC=(sqrt(rO1^2-rb1^2)+sqrt(rO2^2-rb2^2)-C*sin(phi))/pb; %contact ratio

FpsTeeth=Fps/rhoC; % force on a single teeth

%% contact stress using Hertzian aprroach
%embraced approach is combination of shigley and the resource at the top
R1=rb1*sin(phi); %radius of curvature of the sun gear [mm]
R2=rb2*sin(phi); %radius of curvature of the planet gear [mm]
R=(1/R1+1/R2)^-1; %effective radius of curvature

nu1=0.33; % Poisson's ratio for sun gear
nu2=0.33; % Poisson's ratio for planet gear
E1=2e5; %Young's modulus for sun gear [MPa]
E2=2e5; %Young's Modulus for planet gear [MPa]

Ec=((1-nu1)/E1 + (1-nu2)/E2)^-1; %Contact modulus [MPa]

w=5; %Face width [mm]

pmax= (FpsTeeth*Ec/(pi*w*R))^(0.5); %contact pressure

%% Irrelevant but Input for Autodesk Inventor

%Torque on Planet Gear due to interaction with sun
Tp_s=Ti/3; %[N.mm]

%Torque on Planet Gear due to interaction with ring
Fr=(reduction*Fps*rBaseSun/(0.5*m*(Np+Ns))-Fps*cos(phi))/cos(phi); %[N]
Tp_r=Fr*cos(phi)*(0.5*m*Np); %[N.mm]
 
%Torque on ring gear due to planet gear
Tr_p=Fr*cos(phi)*(0.5*m*Nr); %[N.mm]

contactName= {"on Planet due to Sun [N.mm]","on Planet due to Ring [N.mm]","on Ring [N.mm]"}';
torqueValues=[Tp_s,Tp_r,Tr_p]';
table(contactName,torqueValues);



