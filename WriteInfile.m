function WriteInfile(name,nbr,who)
    if who == 0
        name = name+"_"+nbr+".wav";
        audioName = cellstr(name);
        file = fopen('list_train.txt','r');
        info_speech = textscan(file, '%s %f');
        fclose(file);
        file = fopen('list_train.txt','w');
        a = info_speech{1}; b = info_speech{2};
        a{end+1} = audioName{1}; b(end+1) = nbr;
        L = length(a);
        c = string(a);
        for i =  1:L
            fprintf(file,'%s %d\n',c(i),b(i));
        end
        fclose(file);
    else
        file = fopen('Users.txt','r');
        info_speech = textscan(file, '%s');
        fclose(file);
        file = fopen('Users.txt','w');
        a = info_speech{1};
        a{end+1} = name ; 
        L = length(a);
        c = string(a);
        for i =  1:L
            fprintf(file,'%s\n',c(i));
        end
        fclose(file);
    end
end