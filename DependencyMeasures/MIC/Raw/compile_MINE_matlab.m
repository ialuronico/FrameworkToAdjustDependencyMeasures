clc;

disp('Compilation via MEX of MINE source code written in C for MIC');
disp('Compiling..');
mex mine_mex.c ./libmine/mine.c
disp('Done.');
