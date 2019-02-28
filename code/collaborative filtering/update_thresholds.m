function [double_alpha, single_alpha, double_beta, single_beta] = update_thresholds(alpha,beta, single_alpha_dec, double_alpha_dec, single_beta_dec, double_beta_dec, C, generality_diff)  

if generality_diff == 0
    
    
    double_alpha = alpha - double_alpha_dec;
    double_beta = beta - double_beta_dec;
    single_alpha = alpha - single_alpha_dec;
    single_beta = beta - single_beta_dec;
else 
    
    double_alpha = alpha  - (C*alpha*generality_diff);
    single_alpha = alpha - ((C/2)*alpha*generality_diff);

    double_beta = beta + (C*beta*generality_diff);
    single_beta = beta + ((C/2)*beta*generality_diff);
    
end

printing = [double_alpha single_alpha double_beta single_beta];

end 


