.data
  v1: .double 1.1,2.2,3.3,4.4,5.5,6.6,7.7,8.8,9.9,10.10,11.11,12.12,13.13,14.14,15.15,16.16
      .double 17.17,18.18,19.19,20.20,21.21,22.22,23.23,24.24,25.25,26.26,27.27,28.28,29.29,30.30,31.31,32.32
      .double 33.33,34.34,35.35,36.36,37.37,38.38,39.39,40.40,41.41,42.42,43.43,44.44,45.45,46.46,47.47,48.48
      .double 49.49,50.50,51.51,52.52,53.53,54.54,55.55,56.56,57.57,58.58,59.59,60.60,61.61,62.62,63.63,64.64

  v2: .double 64.64,63.63,62.62,61.61,60.60,59.59,58.58,57.57,56.56,55.55,54.54,53.53,52.52,51.51,50.50,49.49
      .double 48.48,47.47,46.46,45.45,44.44,43.43,42.42,41.41,40.40,39.39,38.38,37.37,36.36,35.35,34.34,33.33
      .double 32.32,31.31,30.30,29.29,28.28,27.27,26.26,25.25,24.24,23.23,22.22,21.21,20.20,19.19,18.18,17.17
      .double 16.16,15.15,14.14,13.13,12.12,11.11,10.10,9.9,8.8,7.7,6.6,5.5,4.4,3.3,2.2,1.1

  v3: .double 1.1,2.2,3.3,4.4,5.5,6.6,7.7,8.8,9.9,10.10,11.11,12.12,13.13,14.14,15.15,16.16
      .double 17.17,18.18,19.19,20.20,21.21,22.22,23.23,24.24,25.25,26.26,27.27,28.28,29.29,30.30,31.31,32.32
      .double 33.33,34.34,35.35,36.36,37.37,38.38,39.39,40.40,41.41,42.42,43.43,44.44,45.45,46.46,47.47,48.48
      .double 49.49,50.50,51.51,52.52,53.53,54.54,55.55,56.56,57.57,58.58,59.59,60.60,61.61,62.62,63.63,64.64

  v4: .double 64.64,63.63,62.62,61.61,60.60,59.59,58.58,57.57,56.56,55.55,54.54,53.53,52.52,51.51,50.50,49.49
      .double 48.48,47.47,46.46,45.45,44.44,43.43,42.42,41.41,40.40,39.39,38.38,37.37,36.36,35.35,34.34,33.33
      .double 32.32,31.31,30.30,29.29,28.28,27.27,26.26,25.25,24.24,23.23,22.22,21.21,20.20,19.19,18.18,17.17
      .double 16.16,15.15,14.14,13.13,12.12,11.11,10.10,9.9,8.8,7.7,6.6,5.5,4.4,3.3,2.2,1.1

  v5: .space 512
  v6: .space 512
  v7: .space 512
;TODO: farlo in versione da 64 elementi7
;for (i = 0; i < 64; i++){	
;	v5[i] = ((v1[i]* v2[i]) + v3[i])+v4[i];
;	v6[i] = v5[i]/(v4[i]+v1[i]);
; v7[i] = v6[i]*(v2[i]+v3[i]);
;}

.text
    MAIN: daddui r1,r0,512 ;used for comparison with counter to end loop, 512 = 64*8
          daddui r2,r0,0  ;counter

    LOOP: l.d f1,v1(r2) ;v1[i]
          l.d f2,v2(r2) ;v2[i]
          l.d f3,v3(r2) ;v3[i]
          l.d f4,v4(r2) ;v4[i]

          mul.d f5,f1,f2 ;f5 = v1[i]*v2[i]
          add.d f5,f5,f3 ;f5 = f5+v3[i]
          add.d f5,f5,f4 ;f5 = f5+v4[i] -> here f5 = ((v1[i]* v2[i]) + v3[i])+v4[i];

          add.d f6,f4,f1 ;f6 = v4[i]+v3[i]
          div.d f6,f5,f6 ;f6 = f5 / f6  -> here f6 = v5[i]/(v4[i]+v1[i]);

          add.d f7,f2,f3 ;f7 = v2[i]+v3[i]
          mul.d f7,f6,f7 ;f7 = f6 * f7  -> here f7 = v6[i]*(v2[i]+v3[i]);

          s.d f5,v5(r2)
          s.d f6,v6(r2)
          s.d f7,v7(r2)

          daddui r2,r2,8
          bne r1,r2,LOOP
          nop
          halt

