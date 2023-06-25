function f = fun(x,PD,SimplexState,r)
%This function builds the equations to be solved
%Input:
%x: vector, the unknown variable
%PD: matrix, the same as PointsDatabase
%SimplexState: matrix, the same as SimplexHistory
%r: The side length of the new point pN+1 to other point
%%
  k=2;%dimension
    for i=1:k
      x(i)=sym (['x',num2str(i)]);
    end 

  %The new pN+1 is an intersection of two circles. The first
  %circle: r = News2, center point is p1,PD(SimplexState(1)), the
  %second circle: r = News3, center point is p2, PD(SimplexState(2))
  f(1) = (x(1)-PD(SimplexState(1),1)).^2+(x(2)- PD(SimplexState(1),2)).^2 - r(1).^2;
  f(2) = (x(1)-PD(SimplexState(2),1)).^2+(x(2)- PD(SimplexState(2),2)).^2 - r(2).^2;
end