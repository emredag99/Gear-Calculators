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
rO1=0.5*Ns*m+m; %addendum circle of gear 1
rb1=0.5*Ns*m*cos(phi); %base circle of gear 1
rO2=0.5*Np*m+m; %addendum circle of gear 2
rb2=0.5*Np*m*cos(phi); %base circle of gear 2
C=(Ns+Np)/2*m; %center distance of the gear 1 and 2

rhoC=(sqrt(rO1^2-rb1^2)+sqrt(rO2^2-rb2^2)-C*sin(phi))/pb; %contact ratio

FpsTeeth=Fps/rhoC; % force on a single teeth


