% He Jiang
clear all;
close all;
clc

Path = "D:\MRES\Label\Catch001\PCT2.mhd";

info = analyze75info(path);
X = analyze75read(info)