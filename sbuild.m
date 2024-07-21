fid = fopen('sTemplate.slurm','rt') ;
X = fread(fid) ;
fclose(fid) ;
X = char(X.') ;
% replace string S1 with string S2
X = strrep(X, 'TaskName', 'mytask');
name1 = ' 1.mx3';
name2 = ' 2.mx3';
X = strrep(X, './mumax3', ['./mumax3' name1 name2]);
fid2 = fopen('new.slurm','wt') ;
fwrite(fid2,X) ;
fclose (fid2) ;