
function [alpha, beta, new_generality, equilibruim_index_row, equilibruim_index_col]  = game(accuracy_game, generality_game, alpha_values, beta_values)
d = 0;
    
for i=1:3
    [a,b] = max(accuracy_game(:,i));
    if generality_game(b,i) == max(generality_game(b,:))
        d = d+1;           
        equilibruim_index(d,1) = b; 
        equilibruim_index(d,2) = i;
        
        utility_player_1(d) = accuracy_game(b,i);
        utility_player_2(d) = generality_game(b,i);
    end 
end 



if d > 1
    
    d =  mod(ceil(rand()*100),d)+1;
end

    equilibruim_index_row = equilibruim_index(d,1);
    equilibruim_index_col = equilibruim_index(d,2);

alpha = alpha_values(equilibruim_index_row, equilibruim_index_col);
beta = beta_values(equilibruim_index_row, equilibruim_index_col);
new_generality = generality_game(equilibruim_index_row, equilibruim_index_col);

end