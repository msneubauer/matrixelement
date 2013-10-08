      SUBROUTINE SDBARGWWJ(P,ANS,RESET)
C     
C     GENERATED BY MADGRAPH 5 V. 1.4.2, 2012-02-16
C     BY THE MADGRAPH DEVELOPMENT TEAM
C     PLEASE VISIT US AT HTTPS://LAUNCHPAD.NET/MADGRAPH5
C     
C     MADGRAPH FOR MADEVENT VERSION
C     
C     RETURNS AMPLITUDE SQUARED SUMMED/AVG OVER COLORS
C     AND HELICITIES
C     FOR THE POINT IN PHASE SPACE P(0:3,NEXTERNAL)
C     
C     PROCESS: D~ G > W+ W- > E+ E- VE VE~ D~ / A WEIGHTED=9
C     PROCESS: S~ G > W+ W- > E+ E- VE VE~ S~ / A WEIGHTED=9
C     
      IMPLICIT NONE
      INTEGER RESET
C     
C     CONSTANTS
C     
      INTEGER MAX_PARTICLES
      PARAMETER(MAX_PARTICLES=7)
      INTEGER    MAX_BRANCH
      PARAMETER (MAX_BRANCH=MAX_PARTICLES-1)
      INTEGER    NG     , MAXDIM     , MAXINVAR     , MAXCONFIGS
      PARAMETER (NG = 96, MAXDIM = 3*(MAX_PARTICLES-2)-1, MAXINVAR= 4*MAX_PARTICLES, MAXCONFIGS=10)
      DOUBLE PRECISION  XGMIN,     XGMAX
      PARAMETER        (XGMIN=-1D0, XGMAX=1D0)
      INTEGER    MAXEVENTS         !REQUIRES ABOUT 1K/EVENT
      PARAMETER (MAXEVENTS=200000)  !MAXIMUM # EVENTS TO WRITE TO DISK
      INTEGER    MAX_HOST   ,MAXPLACE    ,MAXPOINTS    ,MAXANS
      PARAMETER (MAX_HOST=9,MAXPLACE=9,MAXPOINTS=10,MAXANS=5)
      INTEGER    MAXPRB
      PARAMETER (MAXPRB = MAXCONFIGS*MAXPLACE*MAXPOINTS)
      INTEGER    MAXFPRB
      PARAMETER (MAXFPRB = MAXINVAR*MAXPLACE*MAXPOINTS)
      REAL*8 LIMHEL
      PARAMETER(LIMHEL=1E-6)
      INTEGER MAXTRIES
      PARAMETER(MAXTRIES=500)
      INTEGER LMAXCONFIGS
      PARAMETER(LMAXCONFIGS=8)
      INTEGER    NEXTERNAL
      PARAMETER (NEXTERNAL=7)
      INTEGER    NINCOMING
      PARAMETER (NINCOMING=2)
      INTEGER    MAXAMPS, MAXFLOW, MAXPROC, MAXSPROC
      PARAMETER (MAXAMPS=5, MAXFLOW=1)
      PARAMETER (MAXPROC=2, MAXSPROC=4)
      INTEGER                 NCOMB
      PARAMETER (             NCOMB=128)
      INTEGER    NGRAPHS
      PARAMETER (NGRAPHS=5)
      INTEGER    NDIAGS
      PARAMETER (NDIAGS=5)
      INTEGER    THEL
      PARAMETER (THEL=2*NCOMB)
C     
C     ARGUMENTS 
C     
      REAL*8 P(0:3,NEXTERNAL),ANS
C     
C     LOCAL VARIABLES 
C     
      INTEGER NHEL(NEXTERNAL,NCOMB),NTRY(2)
      INTEGER ISHEL(2)
      REAL*8 T,DBARGWWJ
      REAL*8 R,SUMHEL,TS(NCOMB)
      INTEGER I,IDEN
      INTEGER JC(NEXTERNAL),II
      LOGICAL GOODHEL(NCOMB,2)
      REAL*8 HWGT, XTOT, XTRY, XREJ, XR, YFRAC(0:NCOMB)
      INTEGER IDUM, NGOOD(2), IGOOD(NCOMB,2)
      INTEGER JHEL(2), J, JJ
      REAL     XRNDM
      EXTERNAL XRNDM
C     
C     GLOBAL VARIABLES
C     
      DOUBLE PRECISION AMP2(MAXAMPS), JAMP2(0:MAXFLOW)
      COMMON/TO_AMPS/  AMP2,       JAMP2

      CHARACTER*101         HEL_BUFF
      COMMON/TO_HELICITY/  HEL_BUFF

      INTEGER IMIRROR
      COMMON/TO_MIRROR/ IMIRROR

      REAL*8 POL(2)
      COMMON/TO_POLARIZATION/ POL

      INTEGER          ISUM_HEL
      LOGICAL                    MULTI_CHANNEL
      COMMON/TO_MATRIX/ISUM_HEL, MULTI_CHANNEL
      INTEGER MAPCONFIG(0:LMAXCONFIGS), ICONFIG
      COMMON/TO_MCONFIGS/MAPCONFIG, ICONFIG
      INTEGER SUBDIAG(MAXSPROC),IB(2)
      COMMON/TO_SUB_DIAG/SUBDIAG,IB
      DATA IDUM /0/
      DATA XTRY, XREJ /0,0/
      DATA NTRY /0,0/
      DATA NGOOD /0,0/
      DATA ISHEL/0,0/
      SAVE YFRAC, IGOOD, JHEL
      DATA GOODHEL/THEL*.FALSE./
      DATA (NHEL(I,   1),I=1,7) /-1,-1,-1,-1,-1,-1,-1/
      DATA (NHEL(I,   2),I=1,7) /-1,-1,-1,-1,-1,-1, 1/
      DATA (NHEL(I,   3),I=1,7) /-1,-1,-1,-1,-1, 1,-1/
      DATA (NHEL(I,   4),I=1,7) /-1,-1,-1,-1,-1, 1, 1/
      DATA (NHEL(I,   5),I=1,7) /-1,-1,-1,-1, 1,-1,-1/
      DATA (NHEL(I,   6),I=1,7) /-1,-1,-1,-1, 1,-1, 1/
      DATA (NHEL(I,   7),I=1,7) /-1,-1,-1,-1, 1, 1,-1/
      DATA (NHEL(I,   8),I=1,7) /-1,-1,-1,-1, 1, 1, 1/
      DATA (NHEL(I,   9),I=1,7) /-1,-1,-1, 1,-1,-1,-1/
      DATA (NHEL(I,  10),I=1,7) /-1,-1,-1, 1,-1,-1, 1/
      DATA (NHEL(I,  11),I=1,7) /-1,-1,-1, 1,-1, 1,-1/
      DATA (NHEL(I,  12),I=1,7) /-1,-1,-1, 1,-1, 1, 1/
      DATA (NHEL(I,  13),I=1,7) /-1,-1,-1, 1, 1,-1,-1/
      DATA (NHEL(I,  14),I=1,7) /-1,-1,-1, 1, 1,-1, 1/
      DATA (NHEL(I,  15),I=1,7) /-1,-1,-1, 1, 1, 1,-1/
      DATA (NHEL(I,  16),I=1,7) /-1,-1,-1, 1, 1, 1, 1/
      DATA (NHEL(I,  17),I=1,7) /-1,-1, 1,-1,-1,-1,-1/
      DATA (NHEL(I,  18),I=1,7) /-1,-1, 1,-1,-1,-1, 1/
      DATA (NHEL(I,  19),I=1,7) /-1,-1, 1,-1,-1, 1,-1/
      DATA (NHEL(I,  20),I=1,7) /-1,-1, 1,-1,-1, 1, 1/
      DATA (NHEL(I,  21),I=1,7) /-1,-1, 1,-1, 1,-1,-1/
      DATA (NHEL(I,  22),I=1,7) /-1,-1, 1,-1, 1,-1, 1/
      DATA (NHEL(I,  23),I=1,7) /-1,-1, 1,-1, 1, 1,-1/
      DATA (NHEL(I,  24),I=1,7) /-1,-1, 1,-1, 1, 1, 1/
      DATA (NHEL(I,  25),I=1,7) /-1,-1, 1, 1,-1,-1,-1/
      DATA (NHEL(I,  26),I=1,7) /-1,-1, 1, 1,-1,-1, 1/
      DATA (NHEL(I,  27),I=1,7) /-1,-1, 1, 1,-1, 1,-1/
      DATA (NHEL(I,  28),I=1,7) /-1,-1, 1, 1,-1, 1, 1/
      DATA (NHEL(I,  29),I=1,7) /-1,-1, 1, 1, 1,-1,-1/
      DATA (NHEL(I,  30),I=1,7) /-1,-1, 1, 1, 1,-1, 1/
      DATA (NHEL(I,  31),I=1,7) /-1,-1, 1, 1, 1, 1,-1/
      DATA (NHEL(I,  32),I=1,7) /-1,-1, 1, 1, 1, 1, 1/
      DATA (NHEL(I,  33),I=1,7) /-1, 1,-1,-1,-1,-1,-1/
      DATA (NHEL(I,  34),I=1,7) /-1, 1,-1,-1,-1,-1, 1/
      DATA (NHEL(I,  35),I=1,7) /-1, 1,-1,-1,-1, 1,-1/
      DATA (NHEL(I,  36),I=1,7) /-1, 1,-1,-1,-1, 1, 1/
      DATA (NHEL(I,  37),I=1,7) /-1, 1,-1,-1, 1,-1,-1/
      DATA (NHEL(I,  38),I=1,7) /-1, 1,-1,-1, 1,-1, 1/
      DATA (NHEL(I,  39),I=1,7) /-1, 1,-1,-1, 1, 1,-1/
      DATA (NHEL(I,  40),I=1,7) /-1, 1,-1,-1, 1, 1, 1/
      DATA (NHEL(I,  41),I=1,7) /-1, 1,-1, 1,-1,-1,-1/
      DATA (NHEL(I,  42),I=1,7) /-1, 1,-1, 1,-1,-1, 1/
      DATA (NHEL(I,  43),I=1,7) /-1, 1,-1, 1,-1, 1,-1/
      DATA (NHEL(I,  44),I=1,7) /-1, 1,-1, 1,-1, 1, 1/
      DATA (NHEL(I,  45),I=1,7) /-1, 1,-1, 1, 1,-1,-1/
      DATA (NHEL(I,  46),I=1,7) /-1, 1,-1, 1, 1,-1, 1/
      DATA (NHEL(I,  47),I=1,7) /-1, 1,-1, 1, 1, 1,-1/
      DATA (NHEL(I,  48),I=1,7) /-1, 1,-1, 1, 1, 1, 1/
      DATA (NHEL(I,  49),I=1,7) /-1, 1, 1,-1,-1,-1,-1/
      DATA (NHEL(I,  50),I=1,7) /-1, 1, 1,-1,-1,-1, 1/
      DATA (NHEL(I,  51),I=1,7) /-1, 1, 1,-1,-1, 1,-1/
      DATA (NHEL(I,  52),I=1,7) /-1, 1, 1,-1,-1, 1, 1/
      DATA (NHEL(I,  53),I=1,7) /-1, 1, 1,-1, 1,-1,-1/
      DATA (NHEL(I,  54),I=1,7) /-1, 1, 1,-1, 1,-1, 1/
      DATA (NHEL(I,  55),I=1,7) /-1, 1, 1,-1, 1, 1,-1/
      DATA (NHEL(I,  56),I=1,7) /-1, 1, 1,-1, 1, 1, 1/
      DATA (NHEL(I,  57),I=1,7) /-1, 1, 1, 1,-1,-1,-1/
      DATA (NHEL(I,  58),I=1,7) /-1, 1, 1, 1,-1,-1, 1/
      DATA (NHEL(I,  59),I=1,7) /-1, 1, 1, 1,-1, 1,-1/
      DATA (NHEL(I,  60),I=1,7) /-1, 1, 1, 1,-1, 1, 1/
      DATA (NHEL(I,  61),I=1,7) /-1, 1, 1, 1, 1,-1,-1/
      DATA (NHEL(I,  62),I=1,7) /-1, 1, 1, 1, 1,-1, 1/
      DATA (NHEL(I,  63),I=1,7) /-1, 1, 1, 1, 1, 1,-1/
      DATA (NHEL(I,  64),I=1,7) /-1, 1, 1, 1, 1, 1, 1/
      DATA (NHEL(I,  65),I=1,7) / 1,-1,-1,-1,-1,-1,-1/
      DATA (NHEL(I,  66),I=1,7) / 1,-1,-1,-1,-1,-1, 1/
      DATA (NHEL(I,  67),I=1,7) / 1,-1,-1,-1,-1, 1,-1/
      DATA (NHEL(I,  68),I=1,7) / 1,-1,-1,-1,-1, 1, 1/
      DATA (NHEL(I,  69),I=1,7) / 1,-1,-1,-1, 1,-1,-1/
      DATA (NHEL(I,  70),I=1,7) / 1,-1,-1,-1, 1,-1, 1/
      DATA (NHEL(I,  71),I=1,7) / 1,-1,-1,-1, 1, 1,-1/
      DATA (NHEL(I,  72),I=1,7) / 1,-1,-1,-1, 1, 1, 1/
      DATA (NHEL(I,  73),I=1,7) / 1,-1,-1, 1,-1,-1,-1/
      DATA (NHEL(I,  74),I=1,7) / 1,-1,-1, 1,-1,-1, 1/
      DATA (NHEL(I,  75),I=1,7) / 1,-1,-1, 1,-1, 1,-1/
      DATA (NHEL(I,  76),I=1,7) / 1,-1,-1, 1,-1, 1, 1/
      DATA (NHEL(I,  77),I=1,7) / 1,-1,-1, 1, 1,-1,-1/
      DATA (NHEL(I,  78),I=1,7) / 1,-1,-1, 1, 1,-1, 1/
      DATA (NHEL(I,  79),I=1,7) / 1,-1,-1, 1, 1, 1,-1/
      DATA (NHEL(I,  80),I=1,7) / 1,-1,-1, 1, 1, 1, 1/
      DATA (NHEL(I,  81),I=1,7) / 1,-1, 1,-1,-1,-1,-1/
      DATA (NHEL(I,  82),I=1,7) / 1,-1, 1,-1,-1,-1, 1/
      DATA (NHEL(I,  83),I=1,7) / 1,-1, 1,-1,-1, 1,-1/
      DATA (NHEL(I,  84),I=1,7) / 1,-1, 1,-1,-1, 1, 1/
      DATA (NHEL(I,  85),I=1,7) / 1,-1, 1,-1, 1,-1,-1/
      DATA (NHEL(I,  86),I=1,7) / 1,-1, 1,-1, 1,-1, 1/
      DATA (NHEL(I,  87),I=1,7) / 1,-1, 1,-1, 1, 1,-1/
      DATA (NHEL(I,  88),I=1,7) / 1,-1, 1,-1, 1, 1, 1/
      DATA (NHEL(I,  89),I=1,7) / 1,-1, 1, 1,-1,-1,-1/
      DATA (NHEL(I,  90),I=1,7) / 1,-1, 1, 1,-1,-1, 1/
      DATA (NHEL(I,  91),I=1,7) / 1,-1, 1, 1,-1, 1,-1/
      DATA (NHEL(I,  92),I=1,7) / 1,-1, 1, 1,-1, 1, 1/
      DATA (NHEL(I,  93),I=1,7) / 1,-1, 1, 1, 1,-1,-1/
      DATA (NHEL(I,  94),I=1,7) / 1,-1, 1, 1, 1,-1, 1/
      DATA (NHEL(I,  95),I=1,7) / 1,-1, 1, 1, 1, 1,-1/
      DATA (NHEL(I,  96),I=1,7) / 1,-1, 1, 1, 1, 1, 1/
      DATA (NHEL(I,  97),I=1,7) / 1, 1,-1,-1,-1,-1,-1/
      DATA (NHEL(I,  98),I=1,7) / 1, 1,-1,-1,-1,-1, 1/
      DATA (NHEL(I,  99),I=1,7) / 1, 1,-1,-1,-1, 1,-1/
      DATA (NHEL(I, 100),I=1,7) / 1, 1,-1,-1,-1, 1, 1/
      DATA (NHEL(I, 101),I=1,7) / 1, 1,-1,-1, 1,-1,-1/
      DATA (NHEL(I, 102),I=1,7) / 1, 1,-1,-1, 1,-1, 1/
      DATA (NHEL(I, 103),I=1,7) / 1, 1,-1,-1, 1, 1,-1/
      DATA (NHEL(I, 104),I=1,7) / 1, 1,-1,-1, 1, 1, 1/
      DATA (NHEL(I, 105),I=1,7) / 1, 1,-1, 1,-1,-1,-1/
      DATA (NHEL(I, 106),I=1,7) / 1, 1,-1, 1,-1,-1, 1/
      DATA (NHEL(I, 107),I=1,7) / 1, 1,-1, 1,-1, 1,-1/
      DATA (NHEL(I, 108),I=1,7) / 1, 1,-1, 1,-1, 1, 1/
      DATA (NHEL(I, 109),I=1,7) / 1, 1,-1, 1, 1,-1,-1/
      DATA (NHEL(I, 110),I=1,7) / 1, 1,-1, 1, 1,-1, 1/
      DATA (NHEL(I, 111),I=1,7) / 1, 1,-1, 1, 1, 1,-1/
      DATA (NHEL(I, 112),I=1,7) / 1, 1,-1, 1, 1, 1, 1/
      DATA (NHEL(I, 113),I=1,7) / 1, 1, 1,-1,-1,-1,-1/
      DATA (NHEL(I, 114),I=1,7) / 1, 1, 1,-1,-1,-1, 1/
      DATA (NHEL(I, 115),I=1,7) / 1, 1, 1,-1,-1, 1,-1/
      DATA (NHEL(I, 116),I=1,7) / 1, 1, 1,-1,-1, 1, 1/
      DATA (NHEL(I, 117),I=1,7) / 1, 1, 1,-1, 1,-1,-1/
      DATA (NHEL(I, 118),I=1,7) / 1, 1, 1,-1, 1,-1, 1/
      DATA (NHEL(I, 119),I=1,7) / 1, 1, 1,-1, 1, 1,-1/
      DATA (NHEL(I, 120),I=1,7) / 1, 1, 1,-1, 1, 1, 1/
      DATA (NHEL(I, 121),I=1,7) / 1, 1, 1, 1,-1,-1,-1/
      DATA (NHEL(I, 122),I=1,7) / 1, 1, 1, 1,-1,-1, 1/
      DATA (NHEL(I, 123),I=1,7) / 1, 1, 1, 1,-1, 1,-1/
      DATA (NHEL(I, 124),I=1,7) / 1, 1, 1, 1,-1, 1, 1/
      DATA (NHEL(I, 125),I=1,7) / 1, 1, 1, 1, 1,-1,-1/
      DATA (NHEL(I, 126),I=1,7) / 1, 1, 1, 1, 1,-1, 1/
      DATA (NHEL(I, 127),I=1,7) / 1, 1, 1, 1, 1, 1,-1/
      DATA (NHEL(I, 128),I=1,7) / 1, 1, 1, 1, 1, 1, 1/
      DATA IDEN/96/
C     ----------
C     BEGIN CODE
C     ----------
      NTRY(IMIRROR)=NTRY(IMIRROR)+1
      IF (RESET.EQ.1) THEN
           DO I=1,NCOMB
                GOODHEL(I,IMIRROR)=.FALSE.
           ENDDO
           NTRY(IMIRROR)=0
      ENDIF
      DO I=1,NEXTERNAL
        JC(I) = +1
      ENDDO

      IF (MULTI_CHANNEL) THEN
        DO I=1,NDIAGS
          AMP2(I)=0D0
        ENDDO
        JAMP2(0)=1
        DO I=1,INT(JAMP2(0))
          JAMP2(I)=0D0
        ENDDO
      ENDIF
      ANS = 0D0
      WRITE(HEL_BUFF,'(20I5)') (0,I=1,NEXTERNAL)
      DO I=1,NCOMB
        TS(I)=0D0
      ENDDO
      IF (ISHEL(IMIRROR) .EQ. 0 .OR. NTRY(IMIRROR) .LE. MAXTRIES) THEN
        DO I=1,NCOMB
          IF (GOODHEL(I,IMIRROR) .OR. NTRY(IMIRROR).LE.MAXTRIES) THEN
            T=DBARGWWJ(P ,NHEL(1,I),JC(1))
            DO JJ=1,NINCOMING
              IF(POL(JJ).NE.1D0.AND.NHEL(JJ,I).EQ.INT(SIGN(1D0
     $         ,POL(JJ)))) THEN
                T=T*ABS(POL(JJ))
              ELSE IF(POL(JJ).NE.1D0)THEN
                T=T*(2D0-ABS(POL(JJ)))
              ENDIF
            ENDDO
            ANS=ANS+T
            TS(I)=T
          ENDIF
        ENDDO
        JHEL(IMIRROR) = 1
        IF(NTRY(IMIRROR).LE.MAXTRIES)THEN
          DO I=1,NCOMB
            IF (.NOT.GOODHEL(I,IMIRROR) .AND. (TS(I).GT.ANS*LIMHEL
     $       /NCOMB)) THEN
              GOODHEL(I,IMIRROR)=.TRUE.
              NGOOD(IMIRROR) = NGOOD(IMIRROR) +1
              IGOOD(NGOOD(IMIRROR),IMIRROR) = I
              PRINT *,'ADDED GOOD HELICITY ',I,TS(I)*NCOMB/ANS
            ENDIF
          ENDDO
        ENDIF
        IF(NTRY(IMIRROR).EQ.MAXTRIES)THEN
          ISHEL(IMIRROR)=MIN(ISUM_HEL,NGOOD(IMIRROR))
        ENDIF
      ELSE  !LOOP OVER GOOD HELICITIES
        DO J=1,ISHEL(IMIRROR)
          JHEL(IMIRROR)=JHEL(IMIRROR)+1
          IF (JHEL(IMIRROR) .GT. NGOOD(IMIRROR)) JHEL(IMIRROR)=1
          HWGT = REAL(NGOOD(IMIRROR))/REAL(ISHEL(IMIRROR))
          I = IGOOD(JHEL(IMIRROR),IMIRROR)
          T=DBARGWWJ(P ,NHEL(1,I),JC(1))
          DO JJ=1,NINCOMING
            IF(POL(JJ).NE.1D0.AND.NHEL(JJ,I).EQ.INT(SIGN(1D0,POL(JJ)))
     $       ) THEN
              T=T*ABS(POL(JJ))
            ELSE IF(POL(JJ).NE.1D0)THEN
              T=T*(2D0-ABS(POL(JJ)))
            ENDIF
          ENDDO
          ANS=ANS+T*HWGT
          TS(I)=T*HWGT
        ENDDO
        IF (ISHEL(IMIRROR) .EQ. 1) THEN
          WRITE(HEL_BUFF,'(20I5)')(NHEL(II,I),II=1,NEXTERNAL)
        ENDIF
      ENDIF
      IF (ISHEL(IMIRROR) .NE. 1) THEN
        R=XRNDM(IDUM)*ANS
        SUMHEL=0D0
        DO I=1,NCOMB
          SUMHEL=SUMHEL+TS(I)
          IF(R.LT.SUMHEL)THEN
            WRITE(HEL_BUFF,'(20I5)')(NHEL(II,I),II=1,NEXTERNAL)
            GOTO 10
          ENDIF
        ENDDO
 10     CONTINUE
      ENDIF
      IF (MULTI_CHANNEL) THEN
        XTOT=0D0
        DO I=1,NDIAGS
          XTOT=XTOT+AMP2(I)
        ENDDO
        IF (XTOT.NE.0D0) THEN
          ANS=ANS*AMP2(SUBDIAG(4))/XTOT
        ELSE
          ANS=0D0
        ENDIF
      ENDIF
      ANS=ANS/DBLE(IDEN)
      END


      REAL*8 FUNCTION DBARGWWJ(P,NHEL,IC)
C     
C     GENERATED BY MADGRAPH 5 V. 1.4.2, 2012-02-16
C     BY THE MADGRAPH DEVELOPMENT TEAM
C     PLEASE VISIT US AT HTTPS://LAUNCHPAD.NET/MADGRAPH5
C     
C     RETURNS AMPLITUDE SQUARED SUMMED/AVG OVER COLORS
C     FOR THE POINT WITH EXTERNAL LINES W(0:6,NEXTERNAL)
C     
C     PROCESS: D~ G > W+ W- > E+ E- VE VE~ D~ / A WEIGHTED=9
C     PROCESS: S~ G > W+ W- > E+ E- VE VE~ S~ / A WEIGHTED=9
C     
      IMPLICIT NONE
      INTEGER RESET
C     
C     CONSTANTS
C     
      INTEGER    NGRAPHS
      PARAMETER (NGRAPHS=5)
      INTEGER MAX_PARTICLES
      PARAMETER(MAX_PARTICLES=7)
      INTEGER    MAX_BRANCH
      PARAMETER (MAX_BRANCH=MAX_PARTICLES-1)
      INTEGER    NG     , MAXDIM     , MAXINVAR     , MAXCONFIGS
      PARAMETER (NG = 96, MAXDIM = 3*(MAX_PARTICLES-2)-1, MAXINVAR= 4*MAX_PARTICLES, MAXCONFIGS=10)
      DOUBLE PRECISION  XGMIN,     XGMAX
      PARAMETER        (XGMIN=-1D0, XGMAX=1D0)
      INTEGER    MAXEVENTS         !REQUIRES ABOUT 1K/EVENT
      PARAMETER (MAXEVENTS=200000)  !MAXIMUM # EVENTS TO WRITE TO DISK
      INTEGER    MAX_HOST   ,MAXPLACE    ,MAXPOINTS    ,MAXANS
      PARAMETER (MAX_HOST=9,MAXPLACE=9,MAXPOINTS=10,MAXANS=5)
      INTEGER    MAXPRB
      PARAMETER (MAXPRB = MAXCONFIGS*MAXPLACE*MAXPOINTS)
      INTEGER    MAXFPRB
      PARAMETER (MAXFPRB = MAXINVAR*MAXPLACE*MAXPOINTS)
      REAL*8 LIMHEL
      PARAMETER(LIMHEL=1E-6)
      INTEGER MAXTRIES
      PARAMETER(MAXTRIES=500)
      INTEGER    NEXTERNAL
      PARAMETER (NEXTERNAL=7)
      INTEGER    NINCOMING
      PARAMETER (NINCOMING=2)
      INTEGER    MAXAMPS, MAXFLOW, MAXPROC, MAXSPROC
      PARAMETER (MAXAMPS=5, MAXFLOW=1)
      PARAMETER (MAXPROC=2, MAXSPROC=4)
      INTEGER    NWAVEFUNCS,     NCOLOR
      PARAMETER (NWAVEFUNCS=16, NCOLOR=1)
      REAL*8     ZERO
      PARAMETER (ZERO=0D0)
      COMPLEX*16 IMAG1
      PARAMETER (IMAG1=(0D0,1D0))
C     
C     ARGUMENTS 
C     
      REAL*8 P(0:3,NEXTERNAL)
      INTEGER NHEL(NEXTERNAL), IC(NEXTERNAL)
C     
C     LOCAL VARIABLES 
C     
      INTEGER I,J
      COMPLEX*16 ZTEMP
      REAL*8 DENOM(NCOLOR), CF(NCOLOR,NCOLOR)
      COMPLEX*16 AMP(NGRAPHS), JAMP(NCOLOR)
      COMPLEX*16 W(6,NWAVEFUNCS)
C     
C     GLOBAL VARIABLES
C     
      DOUBLE PRECISION AMP2(MAXAMPS), JAMP2(0:MAXFLOW)
      COMMON/TO_AMPS/  AMP2,       JAMP2
      INCLUDE 'SMCOUPLINGS.INC'
C     
C     COLOR DATA
C     
      DATA DENOM(1)/1/
      DATA (CF(I,  1),I=  1,  1) /    4/
C     1 T(2,1,7)
C     ----------
C     BEGIN CODE
C     ----------
      CALL OXXXXX(P(0,1),ZERO,NHEL(1),-1*IC(1),W(1,1))
      CALL VXXXXX(P(0,2),ZERO,NHEL(2),-1*IC(2),W(1,2))
      CALL IXXXXX(P(0,3),ZERO,NHEL(3),-1*IC(3),W(1,3))
      CALL OXXXXX(P(0,4),ZERO,NHEL(4),+1*IC(4),W(1,4))
      CALL OXXXXX(P(0,5),ZERO,NHEL(5),+1*IC(5),W(1,5))
      CALL IXXXXX(P(0,6),ZERO,NHEL(6),-1*IC(6),W(1,6))
      CALL IXXXXX(P(0,7),ZERO,NHEL(7),-1*IC(7),W(1,7))
      CALL FFV1_1(W(1,1),W(1,2),GC_5,ZERO, ZERO, W(1,8))
      CALL FFV2_3(W(1,3),W(1,5),GC_16,MW, WW, W(1,9))
      CALL FFV2_3(W(1,6),W(1,4),GC_16,MW, WW, W(1,10))
      CALL FFV2_1(W(1,8),W(1,9),GC_16,ZERO, ZERO, W(1,11))
C     AMPLITUDE(S) FOR DIAGRAM NUMBER 1
      CALL FFV2_0(W(1,7),W(1,11),W(1,10),GC_16,AMP(1))
      CALL FFV2_3_3(W(1,7),W(1,8),GC_21,GC_23,MZ, WZ, W(1,12))
C     AMPLITUDE(S) FOR DIAGRAM NUMBER 2
      CALL VVV1_0(W(1,10),W(1,9),W(1,12),GC_7,AMP(2))
      CALL FFV1_2(W(1,7),W(1,2),GC_5,ZERO, ZERO, W(1,13))
      CALL FFV2_3_3(W(1,13),W(1,1),GC_21,GC_23,MZ, WZ, W(1,14))
C     AMPLITUDE(S) FOR DIAGRAM NUMBER 3
      CALL VVV1_0(W(1,10),W(1,9),W(1,14),GC_7,AMP(3))
      CALL FFV2_1(W(1,1),W(1,9),GC_16,ZERO, ZERO, W(1,15))
C     AMPLITUDE(S) FOR DIAGRAM NUMBER 4
      CALL FFV2_0(W(1,13),W(1,15),W(1,10),GC_16,AMP(4))
      CALL FFV2_2(W(1,7),W(1,10),GC_16,ZERO, ZERO, W(1,16))
C     AMPLITUDE(S) FOR DIAGRAM NUMBER 5
      CALL FFV1_0(W(1,16),W(1,15),W(1,2),GC_5,AMP(5))
      JAMP(1)=-AMP(1)-AMP(2)-AMP(3)-AMP(4)-AMP(5)
      DBARGWWJ = 0.D0
      DO I = 1, NCOLOR
        ZTEMP = (0.D0,0.D0)
        DO J = 1, NCOLOR
          ZTEMP = ZTEMP + CF(J,I)*JAMP(J)
        ENDDO
        DBARGWWJ=DBARGWWJ+ZTEMP*DCONJG(JAMP(I))/DENOM(I)
      ENDDO
      AMP2(1)=AMP2(1)+AMP(1)*DCONJG(AMP(1))
      AMP2(2)=AMP2(2)+AMP(2)*DCONJG(AMP(2))
      AMP2(3)=AMP2(3)+AMP(3)*DCONJG(AMP(3))
      AMP2(4)=AMP2(4)+AMP(4)*DCONJG(AMP(4))
      AMP2(5)=AMP2(5)+AMP(5)*DCONJG(AMP(5))
      DO I = 1, NCOLOR
        JAMP2(I)=JAMP2(I)+JAMP(I)*DCONJG(JAMP(I))
      ENDDO

      END

