function [M,SIG,PI] = coefficient(para)

mu1 = para(1);
mu2 = para(2);
SIG = para(3);
p11 = para(4);
p22 = para(5);

M   = [mu1;mu2];
PI  = [p11   1-p22;
       1-p11   p22];
   
   
   
