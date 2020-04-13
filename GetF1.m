function [F1] = GetF1(yval, pval, epsilon)

F1 = 0;

    
cvPredictions = (pval < epsilon);
fp = sum((cvPredictions == 1) & (yval == 0));
tp = sum((cvPredictions == 1) & (yval == 1));
fn = sum((cvPredictions == 0) & (yval == 1));

prec = tp / (tp + fp);
rec = tp / (tp + fn);

F1 = (2 * prec * rec) / (prec + rec);
end


