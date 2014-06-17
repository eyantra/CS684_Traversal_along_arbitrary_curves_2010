function [ ] = newpaths(im)
% %U/**@mainpage package TraverseCurve
%  @author Group 21: Rakesh D 10305069 
%  
%  AVR Studio Version 4.17, Build 666
% 
%  Date: 3rd November 2010
%  
%  The aim of the project is to make the Firebird V traverse along arbitrary
%  Curved paths. This file is newpaths.m
%  It takes a binary image im as input and generates the required data for the 
%  project by printing out to the 'image.h' file.
%   
% 
% *********************************************************************************/
% 
% /********************************************************************************
% 
%    Copyright (c) 2010, ERTS Lab IIT Bombay erts@cse.iitb.ac.in               -*- c -*-
%    All rights reserved.
% 
%    Redistribution and use in source and binary forms, with or without
%    modification, are permitted provided that the following conditions are met:
% 
%    * Redistributions of source code must retain the above copyright
%      notice, this list of conditions and the following disclaimer.
% 
%    * Redistributions in binary form must reproduce the above copyright
%      notice, this list of conditions and the following disclaimer in
%      the documentation and/or other materials provided with the
%      distribution.
% 
%    * Neither the name of the copyright holders nor the names of
%      contributors may be used to endorse or promote products derived
%      from this software without specific prior written permission.
% 
%    * Source code can be used for academic purpose. 
% 	 For commercial use permission form the author needs to be taken.
% 
%   THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
%   AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
%   IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
%   ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE
%   LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
%   CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
%   SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
%   INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
%   CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
%   ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
%   POSSIBILITY OF SUCH DAMAGE. 
% 
%   Software released under Creative Commence cc by-nc-sa licence.
%   For legal information refer to: 
%   http://creativecommons.org/licenses/by-nc-sa/3.0/legalcode
% NTITLED4 Summary of this function goes here
%   Detailed explanation goes here
pts = [];
nim = ~im;
nim = bwmorph(nim,'thin',Inf);
comps = bwconncomp(nim);
nlists = comps.NumObjects;
temp = cell(nlists,1);
for i = 1:nlists
    t = coord(comps.PixelIdxList{i},comps.ImageSize);
    [r, s] = size(t);
    cl = ones(comps.ImageSize);
    for j = 1:r
        cl(t(j,1),t(j,2)) = 0;
    end
    t = extractpath(cl);
    temp{i} = newpts(t);
end
for i = 1:nlists
    pts = [pts;temp{i}];
end

disp = caldist(pts);
ang = calangle(pts);
dir = sign(ang);
dir = dir + ones(size(dir));
state = zeros(size(disp));
ind = 0;
for i = 1:(nlists - 1)
    [r, s] = size(temp{i});
    ind = ind + r;
    state(ind) = 1;
end
[m, n] = size(pts);
n = 4;
f = fopen('C:\Users\Rakesh\Desktop\new\Traverse Curve\image.h','w');
fprintf(f,'int m = %d;\n',m-1);
fprintf(f,'unsigned int arr[%d][%d] = {\n',m-1,n);
for i = (1:m-2)
    if (state(i) ~= 1)
        fprintf(f,'{%d, %d, %d, %d},\n',state(i), dir(i),abs(round(ang(i))),3*round(disp(i)));
    else
        fprintf(f,'{%d, %d, %d, %d},\n',state(i), dir(i),abs(round(ang(i))),0);
        dis = round(3*disp(i)/8);
        for i = 1:8
            fprintf(f,'{1, 1, 0, %d},\n',dis);
        end
    end
end
fprintf(f,'{%d, %d, %d, %d}\n',state(i), dir(i),abs(round(ang(m-1))),3*round(disp(m-1)));
fprintf(f,'};');
fclose(f);
end
