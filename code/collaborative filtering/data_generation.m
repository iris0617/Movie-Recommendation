clear all
ratings = dlmread('/home/dextrose/azam200n/P 13/movielen/additional_data/rating_400_800.dat');

users = 400;
movies = 3952;

collab_data = zeros(users,movies);

for i=1:length(ratings)
    if ratings(i,3) >=4
        collab_data(ratings(i,1),ratings(i,2)) = 1;
    else 
        collab_data(ratings(i,1),ratings(i,2)) = -1;
    end 
end 

rating_count_for_movies = zeros(1,movies);

for i=1:movies

    rating_count_for_movies(i) = movies - sum(ismember(collab_data(:,i),0)) ;
end

[values index] = sort(rating_count_for_movies,'descend');

selected_movies = 10;                                
%   top five movies that recieved either positive or negative ratings by the
%   users

generated_collab_data = zeros(users,selected_movies);

for i=1:selected_movies
    generated_collab_data(:,i) = collab_data(:,index(i));  
end

dlmwrite('/home/dextrose/azam200n/P 13/movielen/additional_data/rating_top_ten_movies_400_3.dat',generated_collab_data);
