function index = GuessWho(nbrUser,data)
    size = length(data);
    res = zeros(1,nbrUser);
    moy = zeros(1,nbrUser);
    step = size/nbrUser;
    index = 0;
    j = 1;
    for i = 1:size
        if data(i) < 0.5
            res(1,j) = res(1,j) + 1;
            moy(1,j) = moy(1,j) + data(i);
        end
        if mod(i,step) == 0
            j = j + 1;
        end
    end
    ind = find(res == max(res));
    if length(ind) > 1
        index = find(moy(ind) == min(moy(ind)));
    end
    index = index(1);
end