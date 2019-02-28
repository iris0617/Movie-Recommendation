ratings = dlmread('/home/dextrose/azam200n/P 13/movielen/ratings.dat');

d = 0;
i = 59000;
while  ratings(i,1) <= 800
        d = d+1
        rating(d,:) = ratings(i,:); 
        rating(d,1) = rating(d,1)-400;
        i = i+1;
end 

dlmwrite('/home/dextrose/azam200n/P 13/movielen/additional_data/rating_400_800.dat',rating);
