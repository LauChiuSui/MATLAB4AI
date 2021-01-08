function BFS_MAZE(maze)
clear;
% start point is labeled as "2"
% end point is labeled as "3"
maze=[1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 
1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 2 1 
1 0 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 0 1 1 1 1 1 1 1 1 0 1 
1 0 1 1 0 0 0 1 0 0 0 1 0 0 0 0 0 0 1 1 1 1 1 1 1 0 0 0 1 1 0 0 0 0 0 1 
1 0 1 1 0 1 0 1 0 1 0 1 0 1 1 1 1 0 1 1 1 1 1 1 1 1 1 0 1 1 0 1 1 1 1 1 
1 0 1 1 0 1 0 1 0 1 0 1 0 0 0 0 0 0 0 0 0 0 0 0 0 1 1 0 1 1 0 0 0 0 0 1 
1 0 1 1 0 1 0 1 0 1 0 1 0 1 0 1 1 1 1 0 0 1 1 1 0 0 0 0 1 1 1 1 1 1 0 1 
1 0 1 0 0 1 0 1 0 1 0 0 0 1 0 0 0 0 1 1 0 1 1 1 1 1 1 1 1 0 0 0 0 0 0 1 
1 0 1 1 0 1 0 1 0 1 1 1 1 1 1 1 1 0 1 1 0 0 0 0 0 0 0 0 1 1 0 1 1 1 1 1 
1 0 1 1 0 1 0 0 0 1 1 0 0 0 0 0 0 0 1 1 1 1 1 1 1 1 1 0 1 1 0 0 0 0 0 1 
1 0 0 0 0 1 1 1 1 1 1 0 1 1 1 1 1 1 1 0 0 0 0 0 0 1 1 0 1 1 1 1 1 1 0 1 
1 1 1 1 1 1 0 0 0 0 0 0 1 0 0 0 0 0 0 0 1 1 1 1 0 1 1 0 1 0 0 0 0 0 0 1 
1 0 0 0 0 0 0 1 1 1 1 1 1 0 1 1 1 1 1 0 1 0 0 0 0 1 1 0 1 1 0 1 1 1 1 1 
1 0 1 1 1 1 1 1 0 0 0 0 0 0 1 0 0 0 0 0 0 0 1 1 1 1 1 0 1 1 0 0 0 0 0 1 
1 0 0 0 0 0 0 0 0 1 1 1 1 1 1 0 1 1 1 1 1 1 1 1 1 1 1 0 1 1 0 0 1 1 0 1 
1 1 1 1 1 1 1 1 1 1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 1 1 1 1 1 0 1 
1 3 0 0 0 0 0 0 0 0 0 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 0 0 0 0 0 0 0 0 1 
1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1];
% a copy of maze
maze2 = maze;
% define 4 search directions
directions = [-1,1,0,0;0,0,-1,1];
% store the solutionution
remark = zeros(100,3);
% find the start point
[I,J] = find(maze == 2);
remark(1,:) = [I,J,-1];
count = 2;
search(1);
solution = remark(count-1,:);

while(solution(end,3) > 0)
    solution = [solution;remark(solution(end,3),:)];
end
maze2(sub2ind(size(maze), solution(2:end-1,1), solution(2:end-1,2))) = 5;
%disp(maze2);
disp(solution(:,1:2)'); % print the route

    function search(front)
        x = remark(front,1);
        y = remark(front,2);        
        for i = 1 : 4
            if cango(x + directions(1,i),y + directions(2,i))
                remark(count,1) = x + directions(1,i);
                remark(count,2) = y + directions(2,i);
                remark(count,3) = front;
                count = count + 1;
                if maze(x + directions(1,i),y + directions(2,i)) ~= 3
                    maze(x + directions(1,i),y + directions(2,i)) = 5;
                else
                    return;
                end
                
            end
        end
        search(front + 1);
    end
% decide whether the point can be passed by
    function z = cango(x,y)
        % decide the border
        z = true;
        try
            if ismember(maze(x,y),[1,2,5])
                z = false;
            end
        catch
            z = false;
        end
    end
end