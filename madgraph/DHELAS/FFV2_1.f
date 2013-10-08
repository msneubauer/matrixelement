C     This File is Automatically generated by ALOHA 
C     The process calculated in this file is: 
C     Gamma(3,2,-1)*ProjM(-1,1)
C     
      SUBROUTINE FFV2_1(F2, V3, COUP, M1, W1, F1)
      IMPLICIT NONE
      DOUBLE COMPLEX F1(*)
      DOUBLE COMPLEX F2(*)
      DOUBLE COMPLEX V3(*)
      DOUBLE COMPLEX COUP
      DOUBLE COMPLEX DENOM
      DOUBLE PRECISION M1, W1
      DOUBLE PRECISION P1(0:3)

      F1(5)= F2(5)+V3(5)
      F1(6)= F2(6)+V3(6)
      P1(0) =  DBLE(F1(5))
      P1(1) =  DBLE(F1(6))
      P1(2) =  DIMAG(F1(6))
      P1(3) =  DIMAG(F1(5))

      DENOM =1D0/(( (M1*( -M1+(0, 1)*W1))+( (P1(0)**2)-(P1(1)**2)
     $ -(P1(2)**2)-(P1(3)**2))))
      F1(1)= COUP*DENOM*(M1*( (F2(3)*( (0, 1)*V3(1)+(0, 1)*V3(4)))
     $ +(F2(4)*( (0, 1)*V3(2)-V3(3)))))
      F1(2)= COUP*DENOM*(M1*( (F2(3)*( (0, 1)*V3(2)+V3(3)))+(F2(4)
     $ *( (0, 1)*V3(1)+(0, -1)*V3(4)))))
      F1(3)= COUP*DENOM*( (F2(3)*( (P1(0)*( (0, 1)*V3(1)+(0, 1)
     $ *V3(4)))+( (P1(1)*( (0, -1)*V3(2)-V3(3)))+( (P1(2)*( V3(2)
     $ +(0, -1)*V3(3)))+(P1(3)*( (0, -1)*V3(1)+(0, -1)*V3(4)))))))
     $ +(F2(4)*( (P1(0)*( (0, 1)*V3(2)-V3(3)))+( (P1(1)*( (0, 
     $ -1)*V3(1)+(0, 1)*V3(4)))+( (P1(2)*( V3(1)-V3(4)))+(P1(3)*( (0, 
     $ -1)*V3(2)+V3(3))))))))
      F1(4)= COUP*DENOM*( (F2(3)*( (P1(0)*( (0, 1)*V3(2)+V3(3)))
     $ +( (P1(1)*( (0, -1)*V3(1)+(0, -1)*V3(4)))+( (P1(2)*( -V3(1)
     $ -V3(4)))+(P1(3)*( (0, 1)*V3(2)+V3(3)))))))+(F2(4)*( (P1(0)
     $ *( (0, 1)*V3(1)+(0, -1)*V3(4)))+( (P1(1)*( (0, -1)*V3(2)
     $ +V3(3)))+( (P1(2)*( -V3(2)+(0, -1)*V3(3)))+(P1(3)*( (0, 1)
     $ *V3(1)+(0, -1)*V3(4))))))))
      END


