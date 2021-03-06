%Delta Band data
ARATChange = [12.5 0.5 8 6 2 6 1 7 5.5];
subjects = [1 3 7 9 11 12 13 17 22];

Scorr = nan(numel(lobeList),numel(stageList));
Pcorr = nan(numel(lobeList),numel(stageList));

for lobeInd = 1:numel(lobeList)
    for stageInd = 1:numel(stageList)
        
        val1 = [];
        for pt = 1:9
            run_holder = [];
            run_holder = [run_holder meanDeltaArray{pt,lobeInd,stageInd,6:10}];
            val1 = [val1 nanmean(run_holder)];
            
        end
                    
        [Srho,Spval] = corr(val1', ARATChange', 'Type', 'Spearman');
        [Prho,Ppval] = corr(val1', ARATChange', 'Type', 'Pearson');        
       
        Scorr(lobeInd,stageInd) = Srho;
        Pcorr(lobeInd,stageInd) = Prho;
        
        figure
        x = val1;
        y = ARATChange;
        temp = polyfit(x,y,1);
        f = polyval(temp,x);
        plot(x,y,'o',x,f,'-')
                
        title(sprintf('%s Cortex, %s Stage, Delta band, Spearman coeff = %.3f', lobeList{lobeInd}, stageList{stageInd},Scorr(lobeInd, stageInd)))
        xlabel('Mean change in lag')
        ylabel('Change in ARAT')
        legend('data','linear fit')
%         text(0.1, 0.8, ['Spearman Rank Correlation Coefficient = ' num2str(SpDelta(lobeInd, stageInd))],'Units','normalized');
  
    end
end
