      SUBROUTINE A4SSOO(E, NX, M, MMAX, KMAX, SLOGN, GAMMA, F,
     1   POW, KOPT, DT, HOPT, LNWORK, COST, LOGLO, LOGHI, COSTOL)
      INTEGER KMAX, MMAX, NX
      INTEGER M, KOPT
      REAL E(NX, KMAX), SLOGN(MMAX), GAMMA, F(KMAX), POW(KMAX), DT
      REAL HOPT(1), LNWORK(MMAX), COST(1), LOGLO, LOGHI, COSTOL
      INTEGER JHI, KHI, KMJ, MMJ, MIN0, I
      INTEGER J, K
      REAL EXP, RHOMAX, MINOST, AMIN1, AMAX1, HOPTK
      INTEGER TEMP
C COMPUTE THE OPTIMAL K AND H.
C REAL HOPT(KMAX+1),COST(KMAX+1)
      KOPT = 1
      KHI = MIN0(M-1, KMAX)
C COMPUTE HOPT(K), K=1,...,MIN(M,KMAX+1).
      TEMP = KHI+1
      DO  6 K = 1, TEMP
         JHI = MIN0(K, KHI)
C   COMPUTE THE FACTORS WHICH CONVERT ERRORS INTO STEP-SIZES.
         DO  1 J = 1, JHI
            KMJ = K-J
            MMJ = M-J
            F(J) = GAMMA*POW(J)*((SLOGN(K+1)-SLOGN(M))-(SLOGN(KMJ+1)-
     1         SLOGN(MMJ)))
   1        CONTINUE
C   HOPTK IS THE OPTIMAL STEP-SIZE FOR THE K-COLUMN LOZENGE.
         HOPTK = LOGHI
         DO  3 I = 1, NX
            RHOMAX = LOGLO
            DO  2 J = 1, JHI
               RHOMAX = AMAX1(RHOMAX, F(J)+E(I, J))
   2           CONTINUE
            HOPTK = AMIN1(HOPTK, RHOMAX)
   3        CONTINUE
         COST(K) = LNWORK(K+1)-HOPTK
         IF (K .NE. 1) GOTO 4
            MINOST = COST(1)
            GOTO  5
   4        IF (K .LE. KHI) MINOST = AMIN1(MINOST, COST(K))
   5     HOPT(K) = EXP(HOPTK)*DT
   6     CONTINUE
C OPTIMIZE THE COST TO WITHIN A RELATIVE TOLERANCE OF COSTTOL.
      DO  8 K = 1, KHI
         IF (COST(K) .GT. MINOST+COSTOL) GOTO 7
            KOPT = K
            GOTO  9
   7     CONTINUE
   8     CONTINUE
   9  RETURN
      END
