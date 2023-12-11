.data
  i: .double 1.01,2.02,3.03,4.04,5.05,6.06,7.07,8.08,9.09,10.1
     .double 11.11,12.12,13.13,14.14,15.15,16.16,17.17,18.18,19.19,20.2
     .double 21.21,22.22,23.23,24.24,25.25,26.26,27.27,28.28,29.29,30.3

  w: .double 31.31,32.32,33.33,34.34,35.35,36.36,37.37,38.38,39.39,40.4
     .double 41.41,42.42,43.43,44.44,45.45,46.46,47.47,48.48,49.49,50.5
     .double 51.51,52.52,53.53,54.54,55.55,56.56,57.57,58.58,59.59,60.6

  y: .space 8
  b: .double 171.0 ;171=0xab, I asked the assistant teacher for this

.text
    MAIN: daddui r1,r0,240 ;used for comparison with counter to end loop, 240 = 30*8
          daddui r2,r0,0  ;counter
          daddui r3,r0,0x7FF ;constant 

          add.d f5,f0,f0 ;init the accumulator to 0
          l.d f1,b(r0) ;loading the b constant

    LOOP: l.d f2,i(r2) ;f2=i[r2]
          l.d f3,w(r2) ;f3=w[r2]

          mul.d f4,f2,f3 ;f4=f2*f3
          add.d f4,f4,f1 ;f4=f4+b

          add.d f5,f5,f4 ;f5 is the accumulator
          daddui r2,r2,8
          bne r1,r2,LOOP

    FX:   mfc1 r1,f5 ; r1=f5 so that I can use bitwise operators and extract the exponent part
          ;to obtain bits 52..=63, I shift by 52 r1. However, dsrl supports only shift by a maximum of 31 bits, thus the double shift.
          dsrl r1,r1,26 ;r1= r1 >> 26
          dsrl r1,r2,26 ;r1= r1 >> 26
          andi r1,r1,0x7FF
          
          beq r1,r3,ZERO
          s.d f5,y(r0)
          halt
    ZERO: s.d f0,y(r0)
          halt
