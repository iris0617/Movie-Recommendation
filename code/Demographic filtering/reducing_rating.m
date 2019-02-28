users = dlmread('/home/dextrose/azam200n/P 13/movielen/users.dat');
users = users(401:800,2:4);

data = dlmread('/home/dextrose/azam200n/P 13/movielen/additional_data/rating_top_ten_movies_400_3.dat');

data = [users, data(:,1)];




