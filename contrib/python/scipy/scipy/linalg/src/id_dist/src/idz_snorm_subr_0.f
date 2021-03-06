        subroutine idz_snorm(m,n,matveca,p1a,p2a,p3a,p4a,
     1                       matvec,p1,p2,p3,p4,its,snorm,v,u)
c
c       estimates the spectral norm of a matrix a specified
c       by a routine matvec for applying a to an arbitrary vector,
c       and by a routine matveca for applying a^*
c       to an arbitrary vector. This routine uses the power method
c       with a random starting vector.
c
c       input:
c       m -- number of rows in a
c       n -- number of columns in a
c       matveca -- routine which applies the adjoint of a
c                  to an arbitrary vector; this routine must have
c                  a calling sequence of the form
c
c                  matveca(m,x,n,y,p1a,p2a,p3a,p4a),
c
c                  where m is the length of x,
c                  x is the vector to which the adjoint of a
c                  is to be applied,
c                  n is the length of y,
c                  y is the product of the adjoint of a and x,
c                  and p1a, p2a, p3a, and p4a are user-specified
c                  parameters
c       p1a -- parameter to be passed to routine matveca
c       p2a -- parameter to be passed to routine matveca
c       p3a -- parameter to be passed to routine matveca
c       p4a -- parameter to be passed to routine matveca
c       matvec -- routine which applies the matrix a
c                 to an arbitrary vector; this routine must have
c                 a calling sequence of the form
c
c                 matvec(n,x,m,y,p1,p2,p3,p4),
c
c                 where n is the length of x,
c                 x is the vector to which a is to be applied,
c                 m is the length of y,
c                 y is the product of a and x,
c                 and p1, p2, p3, and p4 are user-specified parameters
c       p1 -- parameter to be passed to routine matvec
c       p2 -- parameter to be passed to routine matvec
c       p3 -- parameter to be passed to routine matvec
c       p4 -- parameter to be passed to routine matvec
c       its -- number of iterations of the power method to conduct
c
c       output:
c       snorm -- estimate of the spectral norm of a
c       v -- estimate of a normalized right singular vector
c            corresponding to the greatest singular value of a
c
c       work:
c       u -- must be at least m complex*16 elements long
c
c       reference:
c       Kuczynski and Wozniakowski, "Estimating the largest eigenvalue
c            by the power and Lanczos algorithms with a random start,"
c            SIAM Journal on Matrix Analysis and Applications,
c            13 (4): 1992, 1094-1122.
c
        implicit none
        integer m,n,its,it,n2,k
        real*8 snorm,enorm
        complex*16 p1a,p2a,p3a,p4a,p1,p2,p3,p4,u(m),v(n)
        external matveca,matvec
c
c
c       Fill the real and imaginary parts of each entry
c       of the initial vector v with i.i.d. random variables
c       drawn uniformly from [-1,1].
c
        n2 = 2*n
        call id_srand(n2,v)
c
        do k = 1,n
          v(k) = 2*v(k)-1
        enddo ! k
c
c
c       Normalize v.
c
        call idz_enorm(n,v,enorm)
c
        do k = 1,n
          v(k) = v(k)/enorm
        enddo ! k
c
c
        do it = 1,its
c
c         Apply a to v, obtaining u.
c
          call matvec(n,v,m,u,p1,p2,p3,p4)
c
c         Apply a^* to u, obtaining v.
c
          call matveca(m,u,n,v,p1a,p2a,p3a,p4a)
c
c         Normalize v.
c
          call idz_enorm(n,v,snorm)
c
          if(snorm .ne. 0) then
c
            do k = 1,n
              v(k) = v(k)/snorm
            enddo ! k
c
          endif
c
          snorm = sqrt(snorm)
c
        enddo ! it
c
c
        return
        end
c
c
c
c
