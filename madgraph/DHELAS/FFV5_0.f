C     This File is Automatically generated by ALOHA 
C     The process calculated in this file is: 
C     Gamma(3,2,-1)*ProjM(-1,1) + 4*Gamma(3,2,-1)*ProjP(-1,1)
C     
      SUBROUTINE FFV5_0(F1,F2,V3,COUP,VERTEX)
      IMPLICIT NONE
      DOUBLE COMPLEX F1(*)
      DOUBLE COMPLEX F2(*)
      DOUBLE COMPLEX V3(*)
      DOUBLE COMPLEX COUP
      DOUBLE COMPLEX VERTEX


      VERTEX = COUP*( (F2(1)*( (F1(3)*( (0, -4)*V3(1)+(0, 4)*V3(4)))
     $ +(F1(4)*( (0, 4)*V3(2)+4*V3(3)))))+( (F2(2)*( (F1(3)*( (0, 4)
     $ *V3(2)-4*V3(3)))+(F1(4)*( (0, -4)*V3(1)+(0, -4)*V3(4)))))
     $ +( (F2(3)*( (F1(1)*( (0, -1)*V3(1)+(0, -1)*V3(4)))+(F1(2)
     $ *( (0, -1)*V3(2)-V3(3)))))+(F2(4)*( (F1(1)*( (0, -1)*V3(2)
     $ +V3(3)))+(F1(2)*( (0, -1)*V3(1)+(0, 1)*V3(4))))))))
      END


