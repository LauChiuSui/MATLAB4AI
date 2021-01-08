clear;clear all;clc;
global GAMMA; % Reward matrix
global Q; % Q-value matrix
global R; % learning parameter
GAMMA=0.8;% learning rate
Q=zeros(6,6); % all zero
R=[[-1,-1,-1,-1,0,-1],
[-1,-1,-1,0,-1,100],
[-1,-1,-1,0,-1,-1],
[-1,0,0,-1,0,-1],
[0,-1,-1,0,-1,100],
[-1,0,-1,-1,0,100]];

count=0;
while count<2000 % 2000 iterations
	for i = 1:6
		QLearning(i);
		count=count+1;
		max1=max(Q);
    end
end
disp('Q is :')     
disp(Q./max(max(Q))*100);
route=getroute(3,6); % get route from 3 to 6
disp('The result is:');
disp(route);

function [s]=getMaxQ(state) % get the maximum Q at some state
    global Q;
	s=max(Q(state,:));
end

function QLearning(state) 
	curAction=-1;
    global GAMMA;
    global Q;
    action=unidrnd(6);% generate action 1-6 at random
    global R;
	if R(state,action)==-1
			Q(state,action)=0;
    else
		curAction=action;
        % iteration
        Q(state,action)=R(state,action)+GAMMA*getMaxQ(curAction);
    end
end

function [index]=getIndex(start,num)
	index=1;
    global Q;
	for i = 1:6
		if Q(start,i)==num
			index=i;
			break;
        end
    end
end

function [route]=getroute(start,endd)% generate the route
	route=[];
	route=[route,start];
	num=getMaxQ(start);
	next=getIndex(start,num);
	while next ~= endd
		route=[route,next];
		num=getMaxQ(next);
		next=getIndex(next,num);
    end
	route=[route,endd];
end