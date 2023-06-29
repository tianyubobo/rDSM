function f = fun(s,TP,N)
  %This function builds the equations to be solved
  %Input:
  %x: vector, the unknown variable
  %PD: matrix, the same as PointsDatabase
  %SimplexState: matrix, the same as SimplexHistory
  %r: The side length of the new point pN+1 to other point
  %%
    %The new pN+1 is an intersection of two circles. The first
    %circle: r = News2, center point is p1,PD(SimplexState(1)), the
    %second circle: r = News3, center point is p2, PD(SimplexState(2))
    %f(1) = (x(1)-PD(SimplexState(1),1)).^2+(x(2)- PD(SimplexState(1),2)).^2 - r(1).^2;
    %f(2) = (x(1)-PD(SimplexState(2),1)).^2+(x(2)- PD(SimplexState(2),2)).^2 - r(2).^2;
    
     %Lagrangian multuplier for n dimension
      SL = pdist(TP); %SL: side length
      %Calculate the perimeter(circumference) and volume(surface) of the triangle
      p_t = sum(SL); %p_t: perimeter of the triangle, number
      syms lamda%s the coordinate of the new point.
      for i=1:N %N is the dimension 
            s(i)=sym (['s',num2str(i)]);
      end
      A = TP(1:N,:)-s;
      P_T = sum(sqrt(sum(A.^2,2))) + sum(SL(:,(N-1)))- p_t;
      %s2 = p_t - sum(SL(:,(N-1))) - s3;
      V_T = (1/factorial(N))*(det([[TP(1:N,:)',transpose(s)];ones(1,N+1)]));
      %V_T = sqrt(0.5*p_t * (0.5*p_t-sum(SL(:,(N-1)))) * (0.5*p_t-(p_t - sum(SL(:,(N-1))) - s3)) * (0.5*p_t-s3));
      L = V_T + lamda * P_T;
      f = [];
      for j=1:N
            f = [f,diff(L,s(j))];
      end
      f = [f,diff(L, lamda)];
  end