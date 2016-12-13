% This function draws the mode shape of each mass/floor
%
% Input:
%   uVectorBand = Mode Shape Vector
%   bandNum = Number of Bands
%
% Output:
%   Mode shape plot

function drawMS(uVectorBand,bandNum)

    fig = figure;
    fig.Name = ['Mode Shape ', num2str(bandNum)];
    
    uVectorBand = -uVectorBand/uVectorBand(1);
    verticalAxis = [3,2,1,0];
    uVectorBand(4,:) = 0;
    
    plot(uVectorBand,verticalAxis,uVectorBand,verticalAxis,'xr');
    line([0,0],[0,3],'color','k');
    title('Mode Shape');
    xlabel('Mode Shape Vector Values');
    ylabel('Mass');
    legend('Mode Shape','Mode Shape Values','Structure');
    
    for i=1:3
        text(uVectorBand(i),verticalAxis(i),['(',num2str(uVectorBand(i)),', ',num2str(verticalAxis(i)),')'],'FontSize',16);
    end
    axis([-1,1,0,3]);