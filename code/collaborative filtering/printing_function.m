function printing_function(fid, alpha, beta, Pr_pos, Pr_bnd, Pr_neg, accuracy, generality)


fprintf(fid, '%2.3f & \t\t\t', alpha); 
fprintf(fid, '%2.3f & \t\t\t', beta); 
fprintf(fid, '%2.1f & \t\t\t', Pr_pos*100); 
fprintf(fid, '%2.1f & \t\t\t', Pr_bnd*100); 
fprintf(fid, '%2.1f & \t\t\t', Pr_neg*100); 
fprintf(fid, '%1.3f & \t\t\t\t', accuracy); 
fprintf(fid, '%1.3f \t\t\t\t', generality); 
fprintf(fid, '\n ');

end 
