taskName = 'xi=0_run02';
slist = [0,-0.002,0.002,-0.005,0.005,-0.02,0.02,-0.05,0.05,-0.1,0.1,-0.2,-0.4,-0.6,-0.8,-1.0];
mkdir(taskName);
copyfile('template.mx3',taskName);
cd(taskName);
for J = slist
    newName = [taskName '_J=' num2str(J) 'e6.mx3'];
    copyfile('template.mx3',newName);
    fileID = fopen(newName,"a");
    fprintf(fileID,['B_ext = vector(0, 0, -0.005)\n' ...
        ['j   = vector(' num2str(J) 'e10, 0, 0)\n'] ...
        'pol = 0.35\n' ...
        'run(5e-9)']);
    fclose(fileID);
end

cd ..

fid = fopen('sTemplate.slurm','rt') ;
X = fread(fid) ;
fclose(fid) ;
X = char(X.') ;
% replace string S1 with string S2
X = strrep(X, 'TaskName', taskName);
fid2 = fopen([taskName '.slurm'],"a") ;
fwrite(fid2,X) ;

mxNames = strings(1,size(slist,2));
for i = 1:size(slist,2)
    mxNames(i)=[taskName '/' taskName '_J=' num2str(slist(i)) 'e6.mx3'];
end

for i = 1:size(mxNames,2)/4
    name1 = mxNames(4*i-3);
    name2 = mxNames(4*i-2);
    name3 = mxNames(4*i-1);
    name4 = mxNames(4*i);
    fprintf(fid2,['./mumax3 ' char(name1) ' ' char(name2) ' ' char(name3) ' ' char(name4) ' \n']);
end

fclose (fid2) ;
