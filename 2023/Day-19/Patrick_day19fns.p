

FUNCTION fnhz RETURNS CHARACTER (x AS INT, m AS INT, a AS INT, s AS INT):
/*------------------------------------------------------------------------------
Purpose: Workflow implemenation for 'hz'
Notes:   hz{m>3518:A,A}
------------------------------------------------------------------------------*/
   IF m > 3518 THEN RETURN "A".
   RETURN "A".
END FUNCTION.

FUNCTION fnxjq RETURNS CHARACTER (x AS INT, m AS INT, a AS INT, s AS INT):
/*------------------------------------------------------------------------------
Purpose: Workflow implemenation for 'xjq'
Notes:   xjq{s<700:R,x>3290:A,a>2004:R,R}
------------------------------------------------------------------------------*/
   IF s < 700 THEN RETURN "R".
   IF x > 3290 THEN RETURN "A".
   IF a > 2004 THEN RETURN "R".
   RETURN "R".
END FUNCTION.

FUNCTION fndn RETURNS CHARACTER (x AS INT, m AS INT, a AS INT, s AS INT):
/*------------------------------------------------------------------------------
Purpose: Workflow implemenation for 'dn'
Notes:   dn{x<1908:R,a>539:A,s>1576:R,kdn}
------------------------------------------------------------------------------*/
   IF x < 1908 THEN RETURN "R".
   IF a > 539 THEN RETURN "A".
   IF s > 1576 THEN RETURN "R".
   RETURN "kdn".
END FUNCTION.

FUNCTION fnql RETURNS CHARACTER (x AS INT, m AS INT, a AS INT, s AS INT):
/*------------------------------------------------------------------------------
Purpose: Workflow implemenation for 'ql'
Notes:   ql{m<3667:rpl,A}
------------------------------------------------------------------------------*/
   IF m < 3667 THEN RETURN "rpl".
   RETURN "A".
END FUNCTION.

FUNCTION fnjsd RETURNS CHARACTER (x AS INT, m AS INT, a AS INT, s AS INT):
/*------------------------------------------------------------------------------
Purpose: Workflow implemenation for 'jsd'
Notes:   jsd{m>1643:R,R}
------------------------------------------------------------------------------*/
   IF m > 1643 THEN RETURN "R".
   RETURN "R".
END FUNCTION.

FUNCTION fndvq RETURNS CHARACTER (x AS INT, m AS INT, a AS INT, s AS INT):
/*------------------------------------------------------------------------------
Purpose: Workflow implemenation for 'dvq'
Notes:   dvq{s<1083:R,x>2321:A,A}
------------------------------------------------------------------------------*/
   IF s < 1083 THEN RETURN "R".
   IF x > 2321 THEN RETURN "A".
   RETURN "A".
END FUNCTION.

FUNCTION fnqzq RETURNS CHARACTER (x AS INT, m AS INT, a AS INT, s AS INT):
/*------------------------------------------------------------------------------
Purpose: Workflow implemenation for 'qzq'
Notes:   qzq{x<3660:A,a>2909:jnb,vhm}
------------------------------------------------------------------------------*/
   IF x < 3660 THEN RETURN "A".
   IF a > 2909 THEN RETURN "jnb".
   RETURN "vhm".
END FUNCTION.

FUNCTION fnpz RETURNS CHARACTER (x AS INT, m AS INT, a AS INT, s AS INT):
/*------------------------------------------------------------------------------
Purpose: Workflow implemenation for 'pz'
Notes:   pz{s>3001:jlf,zj}
------------------------------------------------------------------------------*/
   IF s > 3001 THEN RETURN "jlf".
   RETURN "zj".
END FUNCTION.

FUNCTION fngb RETURNS CHARACTER (x AS INT, m AS INT, a AS INT, s AS INT):
/*------------------------------------------------------------------------------
Purpose: Workflow implemenation for 'gb'
Notes:   gb{s>236:tpj,mk}
------------------------------------------------------------------------------*/
   IF s > 236 THEN RETURN "tpj".
   RETURN "mk".
END FUNCTION.

FUNCTION fnkgl RETURNS CHARACTER (x AS INT, m AS INT, a AS INT, s AS INT):
/*------------------------------------------------------------------------------
Purpose: Workflow implemenation for 'kgl'
Notes:   kgl{s<3549:nfm,a>2025:R,x>1769:A,A}
------------------------------------------------------------------------------*/
   IF s < 3549 THEN RETURN "nfm".
   IF a > 2025 THEN RETURN "R".
   IF x > 1769 THEN RETURN "A".
   RETURN "A".
END FUNCTION.

FUNCTION fnjkc RETURNS CHARACTER (x AS INT, m AS INT, a AS INT, s AS INT):
/*------------------------------------------------------------------------------
Purpose: Workflow implemenation for 'jkc'
Notes:   jkc{s>1836:A,x>1826:A,vt}
------------------------------------------------------------------------------*/
   IF s > 1836 THEN RETURN "A".
   IF x > 1826 THEN RETURN "A".
   RETURN "vt".
END FUNCTION.

FUNCTION fnzn RETURNS CHARACTER (x AS INT, m AS INT, a AS INT, s AS INT):
/*------------------------------------------------------------------------------
Purpose: Workflow implemenation for 'zn'
Notes:   zn{a<471:A,s<757:lmg,th}
------------------------------------------------------------------------------*/
   IF a < 471 THEN RETURN "A".
   IF s < 757 THEN RETURN "lmg".
   RETURN "th".
END FUNCTION.

FUNCTION fnvhm RETURNS CHARACTER (x AS INT, m AS INT, a AS INT, s AS INT):
/*------------------------------------------------------------------------------
Purpose: Workflow implemenation for 'vhm'
Notes:   vhm{s<3774:A,a<2437:A,A}
------------------------------------------------------------------------------*/
   IF s < 3774 THEN RETURN "A".
   IF a < 2437 THEN RETURN "A".
   RETURN "A".
END FUNCTION.

FUNCTION fngq RETURNS CHARACTER (x AS INT, m AS INT, a AS INT, s AS INT):
/*------------------------------------------------------------------------------
Purpose: Workflow implemenation for 'gq'
Notes:   gq{x>3007:ngs,xmr}
------------------------------------------------------------------------------*/
   IF x > 3007 THEN RETURN "ngs".
   RETURN "xmr".
END FUNCTION.

FUNCTION fnlz RETURNS CHARACTER (x AS INT, m AS INT, a AS INT, s AS INT):
/*------------------------------------------------------------------------------
Purpose: Workflow implemenation for 'lz'
Notes:   lz{x>314:R,a>1284:R,A}
------------------------------------------------------------------------------*/
   IF x > 314 THEN RETURN "R".
   IF a > 1284 THEN RETURN "R".
   RETURN "A".
END FUNCTION.

FUNCTION fngsg RETURNS CHARACTER (x AS INT, m AS INT, a AS INT, s AS INT):
/*------------------------------------------------------------------------------
Purpose: Workflow implemenation for 'gsg'
Notes:   gsg{m>1029:R,x>3382:R,R}
------------------------------------------------------------------------------*/
   IF m > 1029 THEN RETURN "R".
   IF x > 3382 THEN RETURN "R".
   RETURN "R".
END FUNCTION.

FUNCTION fncqj RETURNS CHARACTER (x AS INT, m AS INT, a AS INT, s AS INT):
/*------------------------------------------------------------------------------
Purpose: Workflow implemenation for 'cqj'
Notes:   cqj{x<2250:A,A}
------------------------------------------------------------------------------*/
   IF x < 2250 THEN RETURN "A".
   RETURN "A".
END FUNCTION.

FUNCTION fnczh RETURNS CHARACTER (x AS INT, m AS INT, a AS INT, s AS INT):
/*------------------------------------------------------------------------------
Purpose: Workflow implemenation for 'czh'
Notes:   czh{x<2534:ntq,s>296:nvl,cq}
------------------------------------------------------------------------------*/
   IF x < 2534 THEN RETURN "ntq".
   IF s > 296 THEN RETURN "nvl".
   RETURN "cq".
END FUNCTION.

FUNCTION fnsjb RETURNS CHARACTER (x AS INT, m AS INT, a AS INT, s AS INT):
/*------------------------------------------------------------------------------
Purpose: Workflow implemenation for 'sjb'
Notes:   sjb{m>910:A,s>2975:A,R}
------------------------------------------------------------------------------*/
   IF m > 910 THEN RETURN "A".
   IF s > 2975 THEN RETURN "A".
   RETURN "R".
END FUNCTION.

FUNCTION fngss RETURNS CHARACTER (x AS INT, m AS INT, a AS INT, s AS INT):
/*------------------------------------------------------------------------------
Purpose: Workflow implemenation for 'gss'
Notes:   gss{m<3349:R,R}
------------------------------------------------------------------------------*/
   IF m < 3349 THEN RETURN "R".
   RETURN "R".
END FUNCTION.

FUNCTION fnsf RETURNS CHARACTER (x AS INT, m AS INT, a AS INT, s AS INT):
/*------------------------------------------------------------------------------
Purpose: Workflow implemenation for 'sf'
Notes:   sf{m<1613:A,x>1749:R,s<2024:R,R}
------------------------------------------------------------------------------*/
   IF m < 1613 THEN RETURN "A".
   IF x > 1749 THEN RETURN "R".
   IF s < 2024 THEN RETURN "R".
   RETURN "R".
END FUNCTION.

FUNCTION fnqd RETURNS CHARACTER (x AS INT, m AS INT, a AS INT, s AS INT):
/*------------------------------------------------------------------------------
Purpose: Workflow implemenation for 'qd'
Notes:   qd{m<2979:R,s>420:A,s<211:mmr,hc}
------------------------------------------------------------------------------*/
   IF m < 2979 THEN RETURN "R".
   IF s > 420 THEN RETURN "A".
   IF s < 211 THEN RETURN "mmr".
   RETURN "hc".
END FUNCTION.

FUNCTION fnnm RETURNS CHARACTER (x AS INT, m AS INT, a AS INT, s AS INT):
/*------------------------------------------------------------------------------
Purpose: Workflow implemenation for 'nm'
Notes:   nm{m<2530:A,a<690:R,A}
------------------------------------------------------------------------------*/
   IF m < 2530 THEN RETURN "A".
   IF a < 690 THEN RETURN "R".
   RETURN "A".
END FUNCTION.

FUNCTION fncf RETURNS CHARACTER (x AS INT, m AS INT, a AS INT, s AS INT):
/*------------------------------------------------------------------------------
Purpose: Workflow implemenation for 'cf'
Notes:   cf{s<2923:A,A}
------------------------------------------------------------------------------*/
   IF s < 2923 THEN RETURN "A".
   RETURN "A".
END FUNCTION.

FUNCTION fngqh RETURNS CHARACTER (x AS INT, m AS INT, a AS INT, s AS INT):
/*------------------------------------------------------------------------------
Purpose: Workflow implemenation for 'gqh'
Notes:   gqh{m<690:gzc,ft}
------------------------------------------------------------------------------*/
   IF m < 690 THEN RETURN "gzc".
   RETURN "ft".
END FUNCTION.

FUNCTION fnkxg RETURNS CHARACTER (x AS INT, m AS INT, a AS INT, s AS INT):
/*------------------------------------------------------------------------------
Purpose: Workflow implemenation for 'kxg'
Notes:   kxg{s<868:A,s>881:R,x<2889:R,R}
------------------------------------------------------------------------------*/
   IF s < 868 THEN RETURN "A".
   IF s > 881 THEN RETURN "R".
   IF x < 2889 THEN RETURN "R".
   RETURN "R".
END FUNCTION.

FUNCTION fnbqk RETURNS CHARACTER (x AS INT, m AS INT, a AS INT, s AS INT):
/*------------------------------------------------------------------------------
Purpose: Workflow implemenation for 'bqk'
Notes:   bqk{s>1277:rqv,a>1262:xrn,xtd}
------------------------------------------------------------------------------*/
   IF s > 1277 THEN RETURN "rqv".
   IF a > 1262 THEN RETURN "xrn".
   RETURN "xtd".
END FUNCTION.

FUNCTION fnjjf RETURNS CHARACTER (x AS INT, m AS INT, a AS INT, s AS INT):
/*------------------------------------------------------------------------------
Purpose: Workflow implemenation for 'jjf'
Notes:   jjf{s<2363:R,a>312:R,R}
------------------------------------------------------------------------------*/
   IF s < 2363 THEN RETURN "R".
   IF a > 312 THEN RETURN "R".
   RETURN "R".
END FUNCTION.

FUNCTION fnqlv RETURNS CHARACTER (x AS INT, m AS INT, a AS INT, s AS INT):
/*------------------------------------------------------------------------------
Purpose: Workflow implemenation for 'qlv'
Notes:   qlv{a>1656:rp,sx}
------------------------------------------------------------------------------*/
   IF a > 1656 THEN RETURN "rp".
   RETURN "sx".
END FUNCTION.

FUNCTION fnczx RETURNS CHARACTER (x AS INT, m AS INT, a AS INT, s AS INT):
/*------------------------------------------------------------------------------
Purpose: Workflow implemenation for 'czx'
Notes:   czx{s<374:R,A}
------------------------------------------------------------------------------*/
   IF s < 374 THEN RETURN "R".
   RETURN "A".
END FUNCTION.

FUNCTION fncvm RETURNS CHARACTER (x AS INT, m AS INT, a AS INT, s AS INT):
/*------------------------------------------------------------------------------
Purpose: Workflow implemenation for 'cvm'
Notes:   cvm{m<3623:A,a>3090:R,a<2883:R,A}
------------------------------------------------------------------------------*/
   IF m < 3623 THEN RETURN "A".
   IF a > 3090 THEN RETURN "R".
   IF a < 2883 THEN RETURN "R".
   RETURN "A".
END FUNCTION.

FUNCTION fnnp RETURNS CHARACTER (x AS INT, m AS INT, a AS INT, s AS INT):
/*------------------------------------------------------------------------------
Purpose: Workflow implemenation for 'np'
Notes:   np{x<57:R,R}
------------------------------------------------------------------------------*/
   IF x < 57 THEN RETURN "R".
   RETURN "R".
END FUNCTION.

FUNCTION fndf RETURNS CHARACTER (x AS INT, m AS INT, a AS INT, s AS INT):
/*------------------------------------------------------------------------------
Purpose: Workflow implemenation for 'df'
Notes:   df{a>2646:tct,qgd}
------------------------------------------------------------------------------*/
   IF a > 2646 THEN RETURN "tct".
   RETURN "qgd".
END FUNCTION.

FUNCTION fnpq RETURNS CHARACTER (x AS INT, m AS INT, a AS INT, s AS INT):
/*------------------------------------------------------------------------------
Purpose: Workflow implemenation for 'pq'
Notes:   pq{m>3886:A,s>1300:A,A}
------------------------------------------------------------------------------*/
   IF m > 3886 THEN RETURN "A".
   IF s > 1300 THEN RETURN "A".
   RETURN "A".
END FUNCTION.

FUNCTION fngvj RETURNS CHARACTER (x AS INT, m AS INT, a AS INT, s AS INT):
/*------------------------------------------------------------------------------
Purpose: Workflow implemenation for 'gvj'
Notes:   gvj{x<3344:A,m<3208:A,x<3652:R,A}
------------------------------------------------------------------------------*/
   IF x < 3344 THEN RETURN "A".
   IF m < 3208 THEN RETURN "A".
   IF x < 3652 THEN RETURN "R".
   RETURN "A".
END FUNCTION.

FUNCTION fnftk RETURNS CHARACTER (x AS INT, m AS INT, a AS INT, s AS INT):
/*------------------------------------------------------------------------------
Purpose: Workflow implemenation for 'ftk'
Notes:   ftk{s>183:czh,m<2812:dxs,mpj}
------------------------------------------------------------------------------*/
   IF s > 183 THEN RETURN "czh".
   IF m < 2812 THEN RETURN "dxs".
   RETURN "mpj".
END FUNCTION.

FUNCTION fngdl RETURNS CHARACTER (x AS INT, m AS INT, a AS INT, s AS INT):
/*------------------------------------------------------------------------------
Purpose: Workflow implemenation for 'gdl'
Notes:   gdl{a>2242:R,A}
------------------------------------------------------------------------------*/
   IF a > 2242 THEN RETURN "R".
   RETURN "A".
END FUNCTION.

FUNCTION fntpj RETURNS CHARACTER (x AS INT, m AS INT, a AS INT, s AS INT):
/*------------------------------------------------------------------------------
Purpose: Workflow implemenation for 'tpj'
Notes:   tpj{a>1952:R,x>414:A,a>1633:A,R}
------------------------------------------------------------------------------*/
   IF a > 1952 THEN RETURN "R".
   IF x > 414 THEN RETURN "A".
   IF a > 1633 THEN RETURN "A".
   RETURN "R".
END FUNCTION.

FUNCTION fnhd RETURNS CHARACTER (x AS INT, m AS INT, a AS INT, s AS INT):
/*------------------------------------------------------------------------------
Purpose: Workflow implemenation for 'hd'
Notes:   hd{m<746:A,x>3172:A,x<2654:lk,jjf}
------------------------------------------------------------------------------*/
   IF m < 746 THEN RETURN "A".
   IF x > 3172 THEN RETURN "A".
   IF x < 2654 THEN RETURN "lk".
   RETURN "jjf".
END FUNCTION.

FUNCTION fnpqj RETURNS CHARACTER (x AS INT, m AS INT, a AS INT, s AS INT):
/*------------------------------------------------------------------------------
Purpose: Workflow implemenation for 'pqj'
Notes:   pqj{m<2823:rlq,m>3109:rj,A}
------------------------------------------------------------------------------*/
   IF m < 2823 THEN RETURN "rlq".
   IF m > 3109 THEN RETURN "rj".
   RETURN "A".
END FUNCTION.

FUNCTION fnttj RETURNS CHARACTER (x AS INT, m AS INT, a AS INT, s AS INT):
/*------------------------------------------------------------------------------
Purpose: Workflow implemenation for 'ttj'
Notes:   ttj{s<1462:mj,A}
------------------------------------------------------------------------------*/
   IF s < 1462 THEN RETURN "mj".
   RETURN "A".
END FUNCTION.

FUNCTION fnvcl RETURNS CHARACTER (x AS INT, m AS INT, a AS INT, s AS INT):
/*------------------------------------------------------------------------------
Purpose: Workflow implemenation for 'vcl'
Notes:   vcl{x>2410:A,s>1991:A,x<2115:R,A}
------------------------------------------------------------------------------*/
   IF x > 2410 THEN RETURN "A".
   IF s > 1991 THEN RETURN "A".
   IF x < 2115 THEN RETURN "R".
   RETURN "A".
END FUNCTION.

FUNCTION fngsd RETURNS CHARACTER (x AS INT, m AS INT, a AS INT, s AS INT):
/*------------------------------------------------------------------------------
Purpose: Workflow implemenation for 'gsd'
Notes:   gsd{m>2665:A,x<2552:R,s<1074:A,A}
------------------------------------------------------------------------------*/
   IF m > 2665 THEN RETURN "A".
   IF x < 2552 THEN RETURN "R".
   IF s < 1074 THEN RETURN "A".
   RETURN "A".
END FUNCTION.

FUNCTION fndh RETURNS CHARACTER (x AS INT, m AS INT, a AS INT, s AS INT):
/*------------------------------------------------------------------------------
Purpose: Workflow implemenation for 'dh'
Notes:   dh{s<1213:A,bvg}
------------------------------------------------------------------------------*/
   IF s < 1213 THEN RETURN "A".
   RETURN "bvg".
END FUNCTION.

FUNCTION fnxf RETURNS CHARACTER (x AS INT, m AS INT, a AS INT, s AS INT):
/*------------------------------------------------------------------------------
Purpose: Workflow implemenation for 'xf'
Notes:   xf{s>2328:pc,s<1137:jmc,tlf}
------------------------------------------------------------------------------*/
   IF s > 2328 THEN RETURN "pc".
   IF s < 1137 THEN RETURN "jmc".
   RETURN "tlf".
END FUNCTION.

FUNCTION fnjkd RETURNS CHARACTER (x AS INT, m AS INT, a AS INT, s AS INT):
/*------------------------------------------------------------------------------
Purpose: Workflow implemenation for 'jkd'
Notes:   jkd{x>1888:cf,x<908:kc,A}
------------------------------------------------------------------------------*/
   IF x > 1888 THEN RETURN "cf".
   IF x < 908 THEN RETURN "kc".
   RETURN "A".
END FUNCTION.

FUNCTION fnnxd RETURNS CHARACTER (x AS INT, m AS INT, a AS INT, s AS INT):
/*------------------------------------------------------------------------------
Purpose: Workflow implemenation for 'nxd'
Notes:   nxd{m>3569:A,x<552:R,A}
------------------------------------------------------------------------------*/
   IF m > 3569 THEN RETURN "A".
   IF x < 552 THEN RETURN "R".
   RETURN "A".
END FUNCTION.

FUNCTION fnkjv RETURNS CHARACTER (x AS INT, m AS INT, a AS INT, s AS INT):
/*------------------------------------------------------------------------------
Purpose: Workflow implemenation for 'kjv'
Notes:   kjv{x<2636:zt,x<3183:lkx,m>3114:qrb,pn}
------------------------------------------------------------------------------*/
   IF x < 2636 THEN RETURN "zt".
   IF x < 3183 THEN RETURN "lkx".
   IF m > 3114 THEN RETURN "qrb".
   RETURN "pn".
END FUNCTION.

FUNCTION fnkrp RETURNS CHARACTER (x AS INT, m AS INT, a AS INT, s AS INT):
/*------------------------------------------------------------------------------
Purpose: Workflow implemenation for 'krp'
Notes:   krp{s>3241:R,m<3498:A,A}
------------------------------------------------------------------------------*/
   IF s > 3241 THEN RETURN "R".
   IF m < 3498 THEN RETURN "A".
   RETURN "A".
END FUNCTION.

FUNCTION fnsmm RETURNS CHARACTER (x AS INT, m AS INT, a AS INT, s AS INT):
/*------------------------------------------------------------------------------
Purpose: Workflow implemenation for 'smm'
Notes:   smm{m<734:A,R}
------------------------------------------------------------------------------*/
   IF m < 734 THEN RETURN "A".
   RETURN "R".
END FUNCTION.

FUNCTION fnph RETURNS CHARACTER (x AS INT, m AS INT, a AS INT, s AS INT):
/*------------------------------------------------------------------------------
Purpose: Workflow implemenation for 'ph'
Notes:   ph{a<3213:A,m>3216:R,A}
------------------------------------------------------------------------------*/
   IF a < 3213 THEN RETURN "A".
   IF m > 3216 THEN RETURN "R".
   RETURN "A".
END FUNCTION.

FUNCTION fnnz RETURNS CHARACTER (x AS INT, m AS INT, a AS INT, s AS INT):
/*------------------------------------------------------------------------------
Purpose: Workflow implemenation for 'nz'
Notes:   nz{x<2386:dtq,s>2080:A,A}
------------------------------------------------------------------------------*/
   IF x < 2386 THEN RETURN "dtq".
   IF s > 2080 THEN RETURN "A".
   RETURN "A".
END FUNCTION.

FUNCTION fnsgj RETURNS CHARACTER (x AS INT, m AS INT, a AS INT, s AS INT):
/*------------------------------------------------------------------------------
Purpose: Workflow implemenation for 'sgj'
Notes:   sgj{a<1835:R,A}
------------------------------------------------------------------------------*/
   IF a < 1835 THEN RETURN "R".
   RETURN "A".
END FUNCTION.

FUNCTION fnqrb RETURNS CHARACTER (x AS INT, m AS INT, a AS INT, s AS INT):
/*------------------------------------------------------------------------------
Purpose: Workflow implemenation for 'qrb'
Notes:   qrb{a<955:cxr,m>3690:dc,tn}
------------------------------------------------------------------------------*/
   IF a < 955 THEN RETURN "cxr".
   IF m > 3690 THEN RETURN "dc".
   RETURN "tn".
END FUNCTION.

FUNCTION fnnk RETURNS CHARACTER (x AS INT, m AS INT, a AS INT, s AS INT):
/*------------------------------------------------------------------------------
Purpose: Workflow implemenation for 'nk'
Notes:   nk{x>795:qp,A}
------------------------------------------------------------------------------*/
   IF x > 795 THEN RETURN "qp".
   RETURN "A".
END FUNCTION.

FUNCTION fnplm RETURNS CHARACTER (x AS INT, m AS INT, a AS INT, s AS INT):
/*------------------------------------------------------------------------------
Purpose: Workflow implemenation for 'plm'
Notes:   plm{m<1874:jbr,nkj}
------------------------------------------------------------------------------*/
   IF m < 1874 THEN RETURN "jbr".
   RETURN "nkj".
END FUNCTION.

FUNCTION fnlc RETURNS CHARACTER (x AS INT, m AS INT, a AS INT, s AS INT):
/*------------------------------------------------------------------------------
Purpose: Workflow implemenation for 'lc'
Notes:   lc{x>454:A,x<266:R,A}
------------------------------------------------------------------------------*/
   IF x > 454 THEN RETURN "A".
   IF x < 266 THEN RETURN "R".
   RETURN "A".
END FUNCTION.

FUNCTION fnjj RETURNS CHARACTER (x AS INT, m AS INT, a AS INT, s AS INT):
/*------------------------------------------------------------------------------
Purpose: Workflow implemenation for 'jj'
Notes:   jj{a>2841:A,a<2118:A,R}
------------------------------------------------------------------------------*/
   IF a > 2841 THEN RETURN "A".
   IF a < 2118 THEN RETURN "A".
   RETURN "R".
END FUNCTION.

FUNCTION fnpj RETURNS CHARACTER (x AS INT, m AS INT, a AS INT, s AS INT):
/*------------------------------------------------------------------------------
Purpose: Workflow implemenation for 'pj'
Notes:   pj{m>3173:nxd,x<414:A,hdb}
------------------------------------------------------------------------------*/
   IF m > 3173 THEN RETURN "nxd".
   IF x < 414 THEN RETURN "A".
   RETURN "hdb".
END FUNCTION.

FUNCTION fnrh RETURNS CHARACTER (x AS INT, m AS INT, a AS INT, s AS INT):
/*------------------------------------------------------------------------------
Purpose: Workflow implemenation for 'rh'
Notes:   rh{x<3019:R,A}
------------------------------------------------------------------------------*/
   IF x < 3019 THEN RETURN "R".
   RETURN "A".
END FUNCTION.

FUNCTION fnnfm RETURNS CHARACTER (x AS INT, m AS INT, a AS INT, s AS INT):
/*------------------------------------------------------------------------------
Purpose: Workflow implemenation for 'nfm'
Notes:   nfm{x>1631:R,A}
------------------------------------------------------------------------------*/
   IF x > 1631 THEN RETURN "R".
   RETURN "A".
END FUNCTION.

FUNCTION fnblh RETURNS CHARACTER (x AS INT, m AS INT, a AS INT, s AS INT):
/*------------------------------------------------------------------------------
Purpose: Workflow implemenation for 'blh'
Notes:   blh{x<1029:pj,brl}
------------------------------------------------------------------------------*/
   IF x < 1029 THEN RETURN "pj".
   RETURN "brl".
END FUNCTION.

FUNCTION fnppt RETURNS CHARACTER (x AS INT, m AS INT, a AS INT, s AS INT):
/*------------------------------------------------------------------------------
Purpose: Workflow implemenation for 'ppt'
Notes:   ppt{a<3642:R,m<1223:gsg,A}
------------------------------------------------------------------------------*/
   IF a < 3642 THEN RETURN "R".
   IF m < 1223 THEN RETURN "gsg".
   RETURN "A".
END FUNCTION.

FUNCTION fnhk RETURNS CHARACTER (x AS INT, m AS INT, a AS INT, s AS INT):
/*------------------------------------------------------------------------------
Purpose: Workflow implemenation for 'hk'
Notes:   hk{a<2029:hpn,s<492:zbb,jt}
------------------------------------------------------------------------------*/
   IF a < 2029 THEN RETURN "hpn".
   IF s < 492 THEN RETURN "zbb".
   RETURN "jt".
END FUNCTION.

FUNCTION fnnmj RETURNS CHARACTER (x AS INT, m AS INT, a AS INT, s AS INT):
/*------------------------------------------------------------------------------
Purpose: Workflow implemenation for 'nmj'
Notes:   nmj{s<207:R,m<3830:A,x<2241:A,R}
------------------------------------------------------------------------------*/
   IF s < 207 THEN RETURN "R".
   IF m < 3830 THEN RETURN "A".
   IF x < 2241 THEN RETURN "A".
   RETURN "R".
END FUNCTION.

FUNCTION fndl RETURNS CHARACTER (x AS INT, m AS INT, a AS INT, s AS INT):
/*------------------------------------------------------------------------------
Purpose: Workflow implemenation for 'dl'
Notes:   dl{a<871:A,m>2275:A,A}
------------------------------------------------------------------------------*/
   IF a < 871 THEN RETURN "A".
   IF m > 2275 THEN RETURN "A".
   RETURN "A".
END FUNCTION.

FUNCTION fncbs RETURNS CHARACTER (x AS INT, m AS INT, a AS INT, s AS INT):
/*------------------------------------------------------------------------------
Purpose: Workflow implemenation for 'cbs'
Notes:   cbs{s<609:vx,s<657:R,A}
------------------------------------------------------------------------------*/
   IF s < 609 THEN RETURN "vx".
   IF s < 657 THEN RETURN "R".
   RETURN "A".
END FUNCTION.

FUNCTION fnvf RETURNS CHARACTER (x AS INT, m AS INT, a AS INT, s AS INT):
/*------------------------------------------------------------------------------
Purpose: Workflow implemenation for 'vf'
Notes:   vf{m>3366:A,a>560:R,a>296:A,A}
------------------------------------------------------------------------------*/
   IF m > 3366 THEN RETURN "A".
   IF a > 560 THEN RETURN "R".
   IF a > 296 THEN RETURN "A".
   RETURN "A".
END FUNCTION.

FUNCTION fnxq RETURNS CHARACTER (x AS INT, m AS INT, a AS INT, s AS INT):
/*------------------------------------------------------------------------------
Purpose: Workflow implemenation for 'xq'
Notes:   xq{a>1033:R,a<956:A,A}
------------------------------------------------------------------------------*/
   IF a > 1033 THEN RETURN "R".
   IF a < 956 THEN RETURN "A".
   RETURN "A".
END FUNCTION.

FUNCTION fnpc RETURNS CHARACTER (x AS INT, m AS INT, a AS INT, s AS INT):
/*------------------------------------------------------------------------------
Purpose: Workflow implemenation for 'pc'
Notes:   pc{x>3394:A,x<3086:R,a>2727:A,A}
------------------------------------------------------------------------------*/
   IF x > 3394 THEN RETURN "A".
   IF x < 3086 THEN RETURN "R".
   IF a > 2727 THEN RETURN "A".
   RETURN "A".
END FUNCTION.

FUNCTION fnnnk RETURNS CHARACTER (x AS INT, m AS INT, a AS INT, s AS INT):
/*------------------------------------------------------------------------------
Purpose: Workflow implemenation for 'nnk'
Notes:   nnk{m>2619:R,a>3006:hpp,jkh}
------------------------------------------------------------------------------*/
   IF m > 2619 THEN RETURN "R".
   IF a > 3006 THEN RETURN "hpp".
   RETURN "jkh".
END FUNCTION.

FUNCTION fnzt RETURNS CHARACTER (x AS INT, m AS INT, a AS INT, s AS INT):
/*------------------------------------------------------------------------------
Purpose: Workflow implemenation for 'zt'
Notes:   zt{m>3191:zpb,bsq}
------------------------------------------------------------------------------*/
   IF m > 3191 THEN RETURN "zpb".
   RETURN "bsq".
END FUNCTION.

FUNCTION fnvl RETURNS CHARACTER (x AS INT, m AS INT, a AS INT, s AS INT):
/*------------------------------------------------------------------------------
Purpose: Workflow implemenation for 'vl'
Notes:   vl{x<3532:A,s>887:A,R}
------------------------------------------------------------------------------*/
   IF x < 3532 THEN RETURN "A".
   IF s > 887 THEN RETURN "A".
   RETURN "R".
END FUNCTION.

FUNCTION fnlmg RETURNS CHARACTER (x AS INT, m AS INT, a AS INT, s AS INT):
/*------------------------------------------------------------------------------
Purpose: Workflow implemenation for 'lmg'
Notes:   lmg{m>3564:R,R}
------------------------------------------------------------------------------*/
   IF m > 3564 THEN RETURN "R".
   RETURN "R".
END FUNCTION.

FUNCTION fnxrf RETURNS CHARACTER (x AS INT, m AS INT, a AS INT, s AS INT):
/*------------------------------------------------------------------------------
Purpose: Workflow implemenation for 'xrf'
Notes:   xrf{s>425:kq,m>2828:A,a>324:nm,fsk}
------------------------------------------------------------------------------*/
   IF s > 425 THEN RETURN "kq".
   IF m > 2828 THEN RETURN "A".
   IF a > 324 THEN RETURN "nm".
   RETURN "fsk".
END FUNCTION.

FUNCTION fntn RETURNS CHARACTER (x AS INT, m AS INT, a AS INT, s AS INT):
/*------------------------------------------------------------------------------
Purpose: Workflow implemenation for 'tn'
Notes:   tn{x<3644:zpz,m<3397:A,rch}
------------------------------------------------------------------------------*/
   IF x < 3644 THEN RETURN "zpz".
   IF m < 3397 THEN RETURN "A".
   RETURN "rch".
END FUNCTION.

FUNCTION fnhf RETURNS CHARACTER (x AS INT, m AS INT, a AS INT, s AS INT):
/*------------------------------------------------------------------------------
Purpose: Workflow implemenation for 'hf'
Notes:   hf{a<1446:A,x<2942:A,x<3022:A,R}
------------------------------------------------------------------------------*/
   IF a < 1446 THEN RETURN "A".
   IF x < 2942 THEN RETURN "A".
   IF x < 3022 THEN RETURN "A".
   RETURN "R".
END FUNCTION.

FUNCTION fnbt RETURNS CHARACTER (x AS INT, m AS INT, a AS INT, s AS INT):
/*------------------------------------------------------------------------------
Purpose: Workflow implemenation for 'bt'
Notes:   bt{s<2790:lbf,a>1654:qpp,s>3238:nql,kjv}
------------------------------------------------------------------------------*/
   IF s < 2790 THEN RETURN "lbf".
   IF a > 1654 THEN RETURN "qpp".
   IF s > 3238 THEN RETURN "nql".
   RETURN "kjv".
END FUNCTION.

FUNCTION fngg RETURNS CHARACTER (x AS INT, m AS INT, a AS INT, s AS INT):
/*------------------------------------------------------------------------------
Purpose: Workflow implemenation for 'gg'
Notes:   gg{a>2956:gsd,m<2713:dvq,R}
------------------------------------------------------------------------------*/
   IF a > 2956 THEN RETURN "gsd".
   IF m < 2713 THEN RETURN "dvq".
   RETURN "R".
END FUNCTION.

FUNCTION fnmv RETURNS CHARACTER (x AS INT, m AS INT, a AS INT, s AS INT):
/*------------------------------------------------------------------------------
Purpose: Workflow implemenation for 'mv'
Notes:   mv{s>651:A,m<1448:A,x<146:A,A}
------------------------------------------------------------------------------*/
   IF s > 651 THEN RETURN "A".
   IF m < 1448 THEN RETURN "A".
   IF x < 146 THEN RETURN "A".
   RETURN "A".
END FUNCTION.

FUNCTION fntp RETURNS CHARACTER (x AS INT, m AS INT, a AS INT, s AS INT):
/*------------------------------------------------------------------------------
Purpose: Workflow implemenation for 'tp'
Notes:   tp{m>3253:gss,x>1334:A,ms}
------------------------------------------------------------------------------*/
   IF m > 3253 THEN RETURN "gss".
   IF x > 1334 THEN RETURN "A".
   RETURN "ms".
END FUNCTION.

FUNCTION fnpg RETURNS CHARACTER (x AS INT, m AS INT, a AS INT, s AS INT):
/*------------------------------------------------------------------------------
Purpose: Workflow implemenation for 'pg'
Notes:   pg{x<2282:R,a<1349:vg,m>2840:R,hfl}
------------------------------------------------------------------------------*/
   IF x < 2282 THEN RETURN "R".
   IF a < 1349 THEN RETURN "vg".
   IF m > 2840 THEN RETURN "R".
   RETURN "hfl".
END FUNCTION.

FUNCTION fnrch RETURNS CHARACTER (x AS INT, m AS INT, a AS INT, s AS INT):
/*------------------------------------------------------------------------------
Purpose: Workflow implemenation for 'rch'
Notes:   rch{x>3834:A,s<3078:R,A}
------------------------------------------------------------------------------*/
   IF x > 3834 THEN RETURN "A".
   IF s < 3078 THEN RETURN "R".
   RETURN "A".
END FUNCTION.

FUNCTION fncxr RETURNS CHARACTER (x AS INT, m AS INT, a AS INT, s AS INT):
/*------------------------------------------------------------------------------
Purpose: Workflow implemenation for 'cxr'
Notes:   cxr{s>2975:plt,x>3547:R,x<3385:gr,fxd}
------------------------------------------------------------------------------*/
   IF s > 2975 THEN RETURN "plt".
   IF x > 3547 THEN RETURN "R".
   IF x < 3385 THEN RETURN "gr".
   RETURN "fxd".
END FUNCTION.

FUNCTION fnbk RETURNS CHARACTER (x AS INT, m AS INT, a AS INT, s AS INT):
/*------------------------------------------------------------------------------
Purpose: Workflow implemenation for 'bk'
Notes:   bk{m<3130:hkl,m<3476:tp,m>3712:bgc,skz}
------------------------------------------------------------------------------*/
   IF m < 3130 THEN RETURN "hkl".
   IF m < 3476 THEN RETURN "tp".
   IF m > 3712 THEN RETURN "bgc".
   RETURN "skz".
END FUNCTION.

FUNCTION fnxbx RETURNS CHARACTER (x AS INT, m AS INT, a AS INT, s AS INT):
/*------------------------------------------------------------------------------
Purpose: Workflow implemenation for 'xbx'
Notes:   xbx{a>3426:rc,s<863:sd,hq}
------------------------------------------------------------------------------*/
   IF a > 3426 THEN RETURN "rc".
   IF s < 863 THEN RETURN "sd".
   RETURN "hq".
END FUNCTION.

FUNCTION fnkd RETURNS CHARACTER (x AS INT, m AS INT, a AS INT, s AS INT):
/*------------------------------------------------------------------------------
Purpose: Workflow implemenation for 'kd'
Notes:   kd{s>1340:A,A}
------------------------------------------------------------------------------*/
   IF s > 1340 THEN RETURN "A".
   RETURN "A".
END FUNCTION.

FUNCTION fnbjf RETURNS CHARACTER (x AS INT, m AS INT, a AS INT, s AS INT):
/*------------------------------------------------------------------------------
Purpose: Workflow implemenation for 'bjf'
Notes:   bjf{a<593:R,A}
------------------------------------------------------------------------------*/
   IF a < 593 THEN RETURN "R".
   RETURN "A".
END FUNCTION.

FUNCTION fnmhm RETURNS CHARACTER (x AS INT, m AS INT, a AS INT, s AS INT):
/*------------------------------------------------------------------------------
Purpose: Workflow implemenation for 'mhm'
Notes:   mhm{a>1647:A,a>1415:A,m<2372:A,A}
------------------------------------------------------------------------------*/
   IF a > 1647 THEN RETURN "A".
   IF a > 1415 THEN RETURN "A".
   IF m < 2372 THEN RETURN "A".
   RETURN "A".
END FUNCTION.

FUNCTION fnfx RETURNS CHARACTER (x AS INT, m AS INT, a AS INT, s AS INT):
/*------------------------------------------------------------------------------
Purpose: Workflow implemenation for 'fx'
Notes:   fx{a<3216:vz,srj}
------------------------------------------------------------------------------*/
   IF a < 3216 THEN RETURN "vz".
   RETURN "srj".
END FUNCTION.

FUNCTION fnml RETURNS CHARACTER (x AS INT, m AS INT, a AS INT, s AS INT):
/*------------------------------------------------------------------------------
Purpose: Workflow implemenation for 'ml'
Notes:   ml{a<2860:R,R}
------------------------------------------------------------------------------*/
   IF a < 2860 THEN RETURN "R".
   RETURN "R".
END FUNCTION.

FUNCTION fnkzv RETURNS CHARACTER (x AS INT, m AS INT, a AS INT, s AS INT):
/*------------------------------------------------------------------------------
Purpose: Workflow implemenation for 'kzv'
Notes:   kzv{s<1301:A,R}
------------------------------------------------------------------------------*/
   IF s < 1301 THEN RETURN "A".
   RETURN "R".
END FUNCTION.

FUNCTION fnjkh RETURNS CHARACTER (x AS INT, m AS INT, a AS INT, s AS INT):
/*------------------------------------------------------------------------------
Purpose: Workflow implemenation for 'jkh'
Notes:   jkh{s<947:R,R}
------------------------------------------------------------------------------*/
   IF s < 947 THEN RETURN "R".
   RETURN "R".
END FUNCTION.

FUNCTION fnpcl RETURNS CHARACTER (x AS INT, m AS INT, a AS INT, s AS INT):
/*------------------------------------------------------------------------------
Purpose: Workflow implemenation for 'pcl'
Notes:   pcl{m<3722:rvk,s>1134:pq,a<2815:R,A}
------------------------------------------------------------------------------*/
   IF m < 3722 THEN RETURN "rvk".
   IF s > 1134 THEN RETURN "pq".
   IF a < 2815 THEN RETURN "R".
   RETURN "A".
END FUNCTION.

FUNCTION fnbm RETURNS CHARACTER (x AS INT, m AS INT, a AS INT, s AS INT):
/*------------------------------------------------------------------------------
Purpose: Workflow implemenation for 'bm'
Notes:   bm{m<776:A,a>3600:R,A}
------------------------------------------------------------------------------*/
   IF m < 776 THEN RETURN "A".
   IF a > 3600 THEN RETURN "R".
   RETURN "A".
END FUNCTION.

FUNCTION fnhrt RETURNS CHARACTER (x AS INT, m AS INT, a AS INT, s AS INT):
/*------------------------------------------------------------------------------
Purpose: Workflow implemenation for 'hrt'
Notes:   hrt{s<674:R,x>2588:R,a>2018:R,A}
------------------------------------------------------------------------------*/
   IF s < 674 THEN RETURN "R".
   IF x > 2588 THEN RETURN "R".
   IF a > 2018 THEN RETURN "R".
   RETURN "A".
END FUNCTION.

FUNCTION fnlqj RETURNS CHARACTER (x AS INT, m AS INT, a AS INT, s AS INT):
/*------------------------------------------------------------------------------
Purpose: Workflow implemenation for 'lqj'
Notes:   lqj{x<676:kfp,x>856:lt,br}
------------------------------------------------------------------------------*/
   IF x < 676 THEN RETURN "kfp".
   IF x > 856 THEN RETURN "lt".
   RETURN "br".
END FUNCTION.

FUNCTION fndhd RETURNS CHARACTER (x AS INT, m AS INT, a AS INT, s AS INT):
/*------------------------------------------------------------------------------
Purpose: Workflow implemenation for 'dhd'
Notes:   dhd{m<2607:R,A}
------------------------------------------------------------------------------*/
   IF m < 2607 THEN RETURN "R".
   RETURN "A".
END FUNCTION.

FUNCTION fnqcv RETURNS CHARACTER (x AS INT, m AS INT, a AS INT, s AS INT):
/*------------------------------------------------------------------------------
Purpose: Workflow implemenation for 'qcv'
Notes:   qcv{x<1535:kl,R}
------------------------------------------------------------------------------*/
   IF x < 1535 THEN RETURN "kl".
   RETURN "R".
END FUNCTION.

FUNCTION fnszq RETURNS CHARACTER (x AS INT, m AS INT, a AS INT, s AS INT):
/*------------------------------------------------------------------------------
Purpose: Workflow implemenation for 'szq'
Notes:   szq{x>2379:hd,a>306:dn,s<1822:hkd,dns}
------------------------------------------------------------------------------*/
   IF x > 2379 THEN RETURN "hd".
   IF a > 306 THEN RETURN "dn".
   IF s < 1822 THEN RETURN "hkd".
   RETURN "dns".
END FUNCTION.

FUNCTION fntqq RETURNS CHARACTER (x AS INT, m AS INT, a AS INT, s AS INT):
/*------------------------------------------------------------------------------
Purpose: Workflow implemenation for 'tqq'
Notes:   tqq{a<522:mb,R}
------------------------------------------------------------------------------*/
   IF a < 522 THEN RETURN "mb".
   RETURN "R".
END FUNCTION.

FUNCTION fnlkx RETURNS CHARACTER (x AS INT, m AS INT, a AS INT, s AS INT):
/*------------------------------------------------------------------------------
Purpose: Workflow implemenation for 'lkx'
Notes:   lkx{a<878:tqq,sbt}
------------------------------------------------------------------------------*/
   IF a < 878 THEN RETURN "tqq".
   RETURN "sbt".
END FUNCTION.

FUNCTION fnvcc RETURNS CHARACTER (x AS INT, m AS INT, a AS INT, s AS INT):
/*------------------------------------------------------------------------------
Purpose: Workflow implemenation for 'vcc'
Notes:   vcc{x>109:R,m<1781:R,m<1933:np,R}
------------------------------------------------------------------------------*/
   IF x > 109 THEN RETURN "R".
   IF m < 1781 THEN RETURN "R".
   IF m < 1933 THEN RETURN "np".
   RETURN "R".
END FUNCTION.

FUNCTION fngdz RETURNS CHARACTER (x AS INT, m AS INT, a AS INT, s AS INT):
/*------------------------------------------------------------------------------
Purpose: Workflow implemenation for 'gdz'
Notes:   gdz{a>3532:A,A}
------------------------------------------------------------------------------*/
   IF a > 3532 THEN RETURN "A".
   RETURN "A".
END FUNCTION.

FUNCTION fnvgt RETURNS CHARACTER (x AS INT, m AS INT, a AS INT, s AS INT):
/*------------------------------------------------------------------------------
Purpose: Workflow implemenation for 'vgt'
Notes:   vgt{m<1215:vcl,jcg}
------------------------------------------------------------------------------*/
   IF m < 1215 THEN RETURN "vcl".
   RETURN "jcg".
END FUNCTION.

FUNCTION fnbxp RETURNS CHARACTER (x AS INT, m AS INT, a AS INT, s AS INT):
/*------------------------------------------------------------------------------
Purpose: Workflow implemenation for 'bxp'
Notes:   bxp{s>1485:A,s<563:R,m>1025:A,A}
------------------------------------------------------------------------------*/
   IF s > 1485 THEN RETURN "A".
   IF s < 563 THEN RETURN "R".
   IF m > 1025 THEN RETURN "A".
   RETURN "A".
END FUNCTION.

FUNCTION fnbmd RETURNS CHARACTER (x AS INT, m AS INT, a AS INT, s AS INT):
/*------------------------------------------------------------------------------
Purpose: Workflow implemenation for 'bmd'
Notes:   bmd{x<2839:rxh,a>2312:nmm,s>1414:krn,bq}
------------------------------------------------------------------------------*/
   IF x < 2839 THEN RETURN "rxh".
   IF a > 2312 THEN RETURN "nmm".
   IF s > 1414 THEN RETURN "krn".
   RETURN "bq".
END FUNCTION.

FUNCTION fnrhg RETURNS CHARACTER (x AS INT, m AS INT, a AS INT, s AS INT):
/*------------------------------------------------------------------------------
Purpose: Workflow implemenation for 'rhg'
Notes:   rhg{s<152:A,R}
------------------------------------------------------------------------------*/
   IF s < 152 THEN RETURN "A".
   RETURN "R".
END FUNCTION.

FUNCTION fncz RETURNS CHARACTER (x AS INT, m AS INT, a AS INT, s AS INT):
/*------------------------------------------------------------------------------
Purpose: Workflow implemenation for 'cz'
Notes:   cz{a<1432:ztv,xfr}
------------------------------------------------------------------------------*/
   IF a < 1432 THEN RETURN "ztv".
   RETURN "xfr".
END FUNCTION.

FUNCTION fnvsd RETURNS CHARACTER (x AS INT, m AS INT, a AS INT, s AS INT):
/*------------------------------------------------------------------------------
Purpose: Workflow implemenation for 'vsd'
Notes:   vsd{a>2247:R,a>1946:R,a>1844:A,R}
------------------------------------------------------------------------------*/
   IF a > 2247 THEN RETURN "R".
   IF a > 1946 THEN RETURN "R".
   IF a > 1844 THEN RETURN "A".
   RETURN "R".
END FUNCTION.

FUNCTION fnmqt RETURNS CHARACTER (x AS INT, m AS INT, a AS INT, s AS INT):
/*------------------------------------------------------------------------------
Purpose: Workflow implemenation for 'mqt'
Notes:   mqt{x<3172:R,x<3581:R,x>3825:R,R}
------------------------------------------------------------------------------*/
   IF x < 3172 THEN RETURN "R".
   IF x < 3581 THEN RETURN "R".
   IF x > 3825 THEN RETURN "R".
   RETURN "R".
END FUNCTION.

FUNCTION fntq RETURNS CHARACTER (x AS INT, m AS INT, a AS INT, s AS INT):
/*------------------------------------------------------------------------------
Purpose: Workflow implemenation for 'tq'
Notes:   tq{x<2593:R,A}
------------------------------------------------------------------------------*/
   IF x < 2593 THEN RETURN "R".
   RETURN "A".
END FUNCTION.

FUNCTION fnfj RETURNS CHARACTER (x AS INT, m AS INT, a AS INT, s AS INT):
/*------------------------------------------------------------------------------
Purpose: Workflow implemenation for 'fj'
Notes:   fj{m<3481:rh,tv}
------------------------------------------------------------------------------*/
   IF m < 3481 THEN RETURN "rh".
   RETURN "tv".
END FUNCTION.

FUNCTION fngx RETURNS CHARACTER (x AS INT, m AS INT, a AS INT, s AS INT):
/*------------------------------------------------------------------------------
Purpose: Workflow implemenation for 'gx'
Notes:   gx{m>2883:R,R}
------------------------------------------------------------------------------*/
   IF m > 2883 THEN RETURN "R".
   RETURN "R".
END FUNCTION.

FUNCTION fnch RETURNS CHARACTER (x AS INT, m AS INT, a AS INT, s AS INT):
/*------------------------------------------------------------------------------
Purpose: Workflow implemenation for 'ch'
Notes:   ch{m<517:nk,pd}
------------------------------------------------------------------------------*/
   IF m < 517 THEN RETURN "nk".
   RETURN "pd".
END FUNCTION.

FUNCTION fnmbs RETURNS CHARACTER (x AS INT, m AS INT, a AS INT, s AS INT):
/*------------------------------------------------------------------------------
Purpose: Workflow implemenation for 'mbs'
Notes:   mbs{s>1219:A,s<1197:R,x>2230:R,R}
------------------------------------------------------------------------------*/
   IF s > 1219 THEN RETURN "A".
   IF s < 1197 THEN RETURN "R".
   IF x > 2230 THEN RETURN "R".
   RETURN "R".
END FUNCTION.

FUNCTION fnrr RETURNS CHARACTER (x AS INT, m AS INT, a AS INT, s AS INT):
/*------------------------------------------------------------------------------
Purpose: Workflow implemenation for 'rr'
Notes:   rr{s<927:A,x>1452:A,x<1372:R,R}
------------------------------------------------------------------------------*/
   IF s < 927 THEN RETURN "A".
   IF x > 1452 THEN RETURN "A".
   IF x < 1372 THEN RETURN "R".
   RETURN "R".
END FUNCTION.

FUNCTION fncgj RETURNS CHARACTER (x AS INT, m AS INT, a AS INT, s AS INT):
/*------------------------------------------------------------------------------
Purpose: Workflow implemenation for 'cgj'
Notes:   cgj{s<3063:R,A}
------------------------------------------------------------------------------*/
   IF s < 3063 THEN RETURN "R".
   RETURN "A".
END FUNCTION.

FUNCTION fnbbv RETURNS CHARACTER (x AS INT, m AS INT, a AS INT, s AS INT):
/*------------------------------------------------------------------------------
Purpose: Workflow implemenation for 'bbv'
Notes:   bbv{s>1112:R,R}
------------------------------------------------------------------------------*/
   IF s > 1112 THEN RETURN "R".
   RETURN "R".
END FUNCTION.

FUNCTION fntqz RETURNS CHARACTER (x AS INT, m AS INT, a AS INT, s AS INT):
/*------------------------------------------------------------------------------
Purpose: Workflow implemenation for 'tqz'
Notes:   tqz{a>3803:nbb,psq}
------------------------------------------------------------------------------*/
   IF a > 3803 THEN RETURN "nbb".
   RETURN "psq".
END FUNCTION.

FUNCTION fnncz RETURNS CHARACTER (x AS INT, m AS INT, a AS INT, s AS INT):
/*------------------------------------------------------------------------------
Purpose: Workflow implemenation for 'ncz'
Notes:   ncz{m>3717:R,a<634:R,R}
------------------------------------------------------------------------------*/
   IF m > 3717 THEN RETURN "R".
   IF a < 634 THEN RETURN "R".
   RETURN "R".
END FUNCTION.

FUNCTION fnjcg RETURNS CHARACTER (x AS INT, m AS INT, a AS INT, s AS INT):
/*------------------------------------------------------------------------------
Purpose: Workflow implemenation for 'jcg'
Notes:   jcg{s<2537:R,m<1343:R,A}
------------------------------------------------------------------------------*/
   IF s < 2537 THEN RETURN "R".
   IF m < 1343 THEN RETURN "R".
   RETURN "A".
END FUNCTION.

FUNCTION fnjt RETURNS CHARACTER (x AS INT, m AS INT, a AS INT, s AS INT):
/*------------------------------------------------------------------------------
Purpose: Workflow implemenation for 'jt'
Notes:   jt{x<1325:pbb,R}
------------------------------------------------------------------------------*/
   IF x < 1325 THEN RETURN "pbb".
   RETURN "R".
END FUNCTION.

FUNCTION fnkzb RETURNS CHARACTER (x AS INT, m AS INT, a AS INT, s AS INT):
/*------------------------------------------------------------------------------
Purpose: Workflow implemenation for 'kzb'
Notes:   kzb{m>3653:jqx,m>3482:gf,x>3249:xsk,rjx}
------------------------------------------------------------------------------*/
   IF m > 3653 THEN RETURN "jqx".
   IF m > 3482 THEN RETURN "gf".
   IF x > 3249 THEN RETURN "xsk".
   RETURN "rjx".
END FUNCTION.

FUNCTION fnrqv RETURNS CHARACTER (x AS INT, m AS INT, a AS INT, s AS INT):
/*------------------------------------------------------------------------------
Purpose: Workflow implemenation for 'rqv'
Notes:   rqv{m<3538:zzl,s<1338:tkq,R}
------------------------------------------------------------------------------*/
   IF m < 3538 THEN RETURN "zzl".
   IF s < 1338 THEN RETURN "tkq".
   RETURN "R".
END FUNCTION.

FUNCTION fnhsb RETURNS CHARACTER (x AS INT, m AS INT, a AS INT, s AS INT):
/*------------------------------------------------------------------------------
Purpose: Workflow implemenation for 'hsb'
Notes:   hsb{a>1037:R,x>870:R,A}
------------------------------------------------------------------------------*/
   IF a > 1037 THEN RETURN "R".
   IF x > 870 THEN RETURN "R".
   RETURN "A".
END FUNCTION.

FUNCTION fnjb RETURNS CHARACTER (x AS INT, m AS INT, a AS INT, s AS INT):
/*------------------------------------------------------------------------------
Purpose: Workflow implemenation for 'jb'
Notes:   jb{x<2075:A,x<2506:lxt,A}
------------------------------------------------------------------------------*/
   IF x < 2075 THEN RETURN "A".
   IF x < 2506 THEN RETURN "lxt".
   RETURN "A".
END FUNCTION.

FUNCTION fnvbk RETURNS CHARACTER (x AS INT, m AS INT, a AS INT, s AS INT):
/*------------------------------------------------------------------------------
Purpose: Workflow implemenation for 'vbk'
Notes:   vbk{a<2870:gjb,a>3277:A,dp}
------------------------------------------------------------------------------*/
   IF a < 2870 THEN RETURN "gjb".
   IF a > 3277 THEN RETURN "A".
   RETURN "dp".
END FUNCTION.

FUNCTION fnjqs RETURNS CHARACTER (x AS INT, m AS INT, a AS INT, s AS INT):
/*------------------------------------------------------------------------------
Purpose: Workflow implemenation for 'jqs'
Notes:   jqs{a<1324:A,m>2852:R,a>1529:R,A}
------------------------------------------------------------------------------*/
   IF a < 1324 THEN RETURN "A".
   IF m > 2852 THEN RETURN "R".
   IF a > 1529 THEN RETURN "R".
   RETURN "A".
END FUNCTION.

FUNCTION fnqm RETURNS CHARACTER (x AS INT, m AS INT, a AS INT, s AS INT):
/*------------------------------------------------------------------------------
Purpose: Workflow implemenation for 'qm'
Notes:   qm{a>3573:A,R}
------------------------------------------------------------------------------*/
   IF a > 3573 THEN RETURN "A".
   RETURN "R".
END FUNCTION.

FUNCTION fnrzk RETURNS CHARACTER (x AS INT, m AS INT, a AS INT, s AS INT):
/*------------------------------------------------------------------------------
Purpose: Workflow implemenation for 'rzk'
Notes:   rzk{x<557:vmp,s<83:tvm,m<3236:mc,ncz}
------------------------------------------------------------------------------*/
   IF x < 557 THEN RETURN "vmp".
   IF s < 83 THEN RETURN "tvm".
   IF m < 3236 THEN RETURN "mc".
   RETURN "ncz".
END FUNCTION.

FUNCTION fnts RETURNS CHARACTER (x AS INT, m AS INT, a AS INT, s AS INT):
/*------------------------------------------------------------------------------
Purpose: Workflow implemenation for 'ts'
Notes:   ts{s<3733:fh,tfn}
------------------------------------------------------------------------------*/
   IF s < 3733 THEN RETURN "fh".
   RETURN "tfn".
END FUNCTION.

FUNCTION fnnsj RETURNS CHARACTER (x AS INT, m AS INT, a AS INT, s AS INT):
/*------------------------------------------------------------------------------
Purpose: Workflow implemenation for 'nsj'
Notes:   nsj{a<1336:A,a>1857:A,a>1584:A,R}
------------------------------------------------------------------------------*/
   IF a < 1336 THEN RETURN "A".
   IF a > 1857 THEN RETURN "A".
   IF a > 1584 THEN RETURN "A".
   RETURN "R".
END FUNCTION.

FUNCTION fnvt RETURNS CHARACTER (x AS INT, m AS INT, a AS INT, s AS INT):
/*------------------------------------------------------------------------------
Purpose: Workflow implemenation for 'vt'
Notes:   vt{a>1102:R,m>2866:R,A}
------------------------------------------------------------------------------*/
   IF a > 1102 THEN RETURN "R".
   IF m > 2866 THEN RETURN "R".
   RETURN "A".
END FUNCTION.

FUNCTION fnzkj RETURNS CHARACTER (x AS INT, m AS INT, a AS INT, s AS INT):
/*------------------------------------------------------------------------------
Purpose: Workflow implemenation for 'zkj'
Notes:   zkj{x>2500:R,a<467:A,R}
------------------------------------------------------------------------------*/
   IF x > 2500 THEN RETURN "R".
   IF a < 467 THEN RETURN "A".
   RETURN "R".
END FUNCTION.

FUNCTION fnbs RETURNS CHARACTER (x AS INT, m AS INT, a AS INT, s AS INT):
/*------------------------------------------------------------------------------
Purpose: Workflow implemenation for 'bs'
Notes:   bs{m<724:A,x>3306:fhb,x>3204:A,kdl}
------------------------------------------------------------------------------*/
   IF m < 724 THEN RETURN "A".
   IF x > 3306 THEN RETURN "fhb".
   IF x > 3204 THEN RETURN "A".
   RETURN "kdl".
END FUNCTION.

FUNCTION fnplt RETURNS CHARACTER (x AS INT, m AS INT, a AS INT, s AS INT):
/*------------------------------------------------------------------------------
Purpose: Workflow implemenation for 'plt'
Notes:   plt{x>3572:R,m<3702:R,s<3130:R,A}
------------------------------------------------------------------------------*/
   IF x > 3572 THEN RETURN "R".
   IF m < 3702 THEN RETURN "R".
   IF s < 3130 THEN RETURN "R".
   RETURN "A".
END FUNCTION.

FUNCTION fnjfc RETURNS CHARACTER (x AS INT, m AS INT, a AS INT, s AS INT):
/*------------------------------------------------------------------------------
Purpose: Workflow implemenation for 'jfc'
Notes:   jfc{x>924:sf,m<1651:lz,mpg}
------------------------------------------------------------------------------*/
   IF x > 924 THEN RETURN "sf".
   IF m < 1651 THEN RETURN "lz".
   RETURN "mpg".
END FUNCTION.

FUNCTION fnknp RETURNS CHARACTER (x AS INT, m AS INT, a AS INT, s AS INT):
/*------------------------------------------------------------------------------
Purpose: Workflow implemenation for 'knp'
Notes:   knp{m>564:A,m<232:A,s>2339:A,R}
------------------------------------------------------------------------------*/
   IF m > 564 THEN RETURN "A".
   IF m < 232 THEN RETURN "A".
   IF s > 2339 THEN RETURN "A".
   RETURN "R".
END FUNCTION.

FUNCTION fnqgd RETURNS CHARACTER (x AS INT, m AS INT, a AS INT, s AS INT):
/*------------------------------------------------------------------------------
Purpose: Workflow implemenation for 'qgd'
Notes:   qgd{a<1965:cm,A}
------------------------------------------------------------------------------*/
   IF a < 1965 THEN RETURN "cm".
   RETURN "A".
END FUNCTION.

FUNCTION fntdm RETURNS CHARACTER (x AS INT, m AS INT, a AS INT, s AS INT):
/*------------------------------------------------------------------------------
Purpose: Workflow implemenation for 'tdm'
Notes:   tdm{m>2827:R,m>2718:A,a>3015:R,A}
------------------------------------------------------------------------------*/
   IF m > 2827 THEN RETURN "R".
   IF m > 2718 THEN RETURN "A".
   IF a > 3015 THEN RETURN "R".
   RETURN "A".
END FUNCTION.

FUNCTION fnhgj RETURNS CHARACTER (x AS INT, m AS INT, a AS INT, s AS INT):
/*------------------------------------------------------------------------------
Purpose: Workflow implemenation for 'hgj'
Notes:   hgj{s>1445:zq,xrb}
------------------------------------------------------------------------------*/
   IF s > 1445 THEN RETURN "zq".
   RETURN "xrb".
END FUNCTION.

FUNCTION fnztv RETURNS CHARACTER (x AS INT, m AS INT, a AS INT, s AS INT):
/*------------------------------------------------------------------------------
Purpose: Workflow implemenation for 'ztv'
Notes:   ztv{m>1357:qsl,tpx}
------------------------------------------------------------------------------*/
   IF m > 1357 THEN RETURN "qsl".
   RETURN "tpx".
END FUNCTION.

FUNCTION fnfhb RETURNS CHARACTER (x AS INT, m AS INT, a AS INT, s AS INT):
/*------------------------------------------------------------------------------
Purpose: Workflow implemenation for 'fhb'
Notes:   fhb{s>1607:R,a<3027:R,A}
------------------------------------------------------------------------------*/
   IF s > 1607 THEN RETURN "R".
   IF a < 3027 THEN RETURN "R".
   RETURN "A".
END FUNCTION.

FUNCTION fnkhd RETURNS CHARACTER (x AS INT, m AS INT, a AS INT, s AS INT):
/*------------------------------------------------------------------------------
Purpose: Workflow implemenation for 'khd'
Notes:   khd{a>3834:R,m>3473:R,R}
------------------------------------------------------------------------------*/
   IF a > 3834 THEN RETURN "R".
   IF m > 3473 THEN RETURN "R".
   RETURN "R".
END FUNCTION.

FUNCTION fntrc RETURNS CHARACTER (x AS INT, m AS INT, a AS INT, s AS INT):
/*------------------------------------------------------------------------------
Purpose: Workflow implemenation for 'trc'
Notes:   trc{s>512:rrk,m>2509:nd,s>326:sxh,cng}
------------------------------------------------------------------------------*/
   IF s > 512 THEN RETURN "rrk".
   IF m > 2509 THEN RETURN "nd".
   IF s > 326 THEN RETURN "sxh".
   RETURN "cng".
END FUNCTION.

FUNCTION fnhr RETURNS CHARACTER (x AS INT, m AS INT, a AS INT, s AS INT):
/*------------------------------------------------------------------------------
Purpose: Workflow implemenation for 'hr'
Notes:   hr{a>656:A,m>2850:R,x>3389:A,A}
------------------------------------------------------------------------------*/
   IF a > 656 THEN RETURN "A".
   IF m > 2850 THEN RETURN "R".
   IF x > 3389 THEN RETURN "A".
   RETURN "A".
END FUNCTION.

FUNCTION fnrp RETURNS CHARACTER (x AS INT, m AS INT, a AS INT, s AS INT):
/*------------------------------------------------------------------------------
Purpose: Workflow implemenation for 'rp'
Notes:   rp{a>2022:R,R}
------------------------------------------------------------------------------*/
   IF a > 2022 THEN RETURN "R".
   RETURN "R".
END FUNCTION.

FUNCTION fngjb RETURNS CHARACTER (x AS INT, m AS INT, a AS INT, s AS INT):
/*------------------------------------------------------------------------------
Purpose: Workflow implemenation for 'gjb'
Notes:   gjb{a<2267:A,R}
------------------------------------------------------------------------------*/
   IF a < 2267 THEN RETURN "A".
   RETURN "R".
END FUNCTION.

FUNCTION fnfd RETURNS CHARACTER (x AS INT, m AS INT, a AS INT, s AS INT):
/*------------------------------------------------------------------------------
Purpose: Workflow implemenation for 'fd'
Notes:   fd{x<1052:vtp,a<949:jrn,hk}
------------------------------------------------------------------------------*/
   IF x < 1052 THEN RETURN "vtp".
   IF a < 949 THEN RETURN "jrn".
   RETURN "hk".
END FUNCTION.

FUNCTION fnfz RETURNS CHARACTER (x AS INT, m AS INT, a AS INT, s AS INT):
/*------------------------------------------------------------------------------
Purpose: Workflow implemenation for 'fz'
Notes:   fz{a>980:R,A}
------------------------------------------------------------------------------*/
   IF a > 980 THEN RETURN "R".
   RETURN "A".
END FUNCTION.

FUNCTION fnccg RETURNS CHARACTER (x AS INT, m AS INT, a AS INT, s AS INT):
/*------------------------------------------------------------------------------
Purpose: Workflow implemenation for 'ccg'
Notes:   ccg{m>2905:R,a>2436:R,R}
------------------------------------------------------------------------------*/
   IF m > 2905 THEN RETURN "R".
   IF a > 2436 THEN RETURN "R".
   RETURN "R".
END FUNCTION.

FUNCTION fnqlg RETURNS CHARACTER (x AS INT, m AS INT, a AS INT, s AS INT):
/*------------------------------------------------------------------------------
Purpose: Workflow implemenation for 'qlg'
Notes:   qlg{m>1037:R,R}
------------------------------------------------------------------------------*/
   IF m > 1037 THEN RETURN "R".
   RETURN "R".
END FUNCTION.

FUNCTION fnnhh RETURNS CHARACTER (x AS INT, m AS INT, a AS INT, s AS INT):
/*------------------------------------------------------------------------------
Purpose: Workflow implemenation for 'nhh'
Notes:   nhh{x>2581:ql,m>3642:nmj,a>1170:kpf,jdt}
------------------------------------------------------------------------------*/
   IF x > 2581 THEN RETURN "ql".
   IF m > 3642 THEN RETURN "nmj".
   IF a > 1170 THEN RETURN "kpf".
   RETURN "jdt".
END FUNCTION.

FUNCTION fnjlf RETURNS CHARACTER (x AS INT, m AS INT, a AS INT, s AS INT):
/*------------------------------------------------------------------------------
Purpose: Workflow implemenation for 'jlf'
Notes:   jlf{x>3531:R,s>3219:A,A}
------------------------------------------------------------------------------*/
   IF x > 3531 THEN RETURN "R".
   IF s > 3219 THEN RETURN "A".
   RETURN "A".
END FUNCTION.

FUNCTION fnnd RETURNS CHARACTER (x AS INT, m AS INT, a AS INT, s AS INT):
/*------------------------------------------------------------------------------
Purpose: Workflow implemenation for 'nd'
Notes:   nd{s<173:vbb,s>385:npn,bxz}
------------------------------------------------------------------------------*/
   IF s < 173 THEN RETURN "vbb".
   IF s > 385 THEN RETURN "npn".
   RETURN "bxz".
END FUNCTION.

FUNCTION fnfhj RETURNS CHARACTER (x AS INT, m AS INT, a AS INT, s AS INT):
/*------------------------------------------------------------------------------
Purpose: Workflow implemenation for 'fhj'
Notes:   fhj{m<724:R,a>3762:R,x>3053:R,R}
------------------------------------------------------------------------------*/
   IF m < 724 THEN RETURN "R".
   IF a > 3762 THEN RETURN "R".
   IF x > 3053 THEN RETURN "R".
   RETURN "R".
END FUNCTION.

FUNCTION fntx RETURNS CHARACTER (x AS INT, m AS INT, a AS INT, s AS INT):
/*------------------------------------------------------------------------------
Purpose: Workflow implemenation for 'tx'
Notes:   tx{m>1717:A,m<1555:R,R}
------------------------------------------------------------------------------*/
   IF m > 1717 THEN RETURN "A".
   IF m < 1555 THEN RETURN "R".
   RETURN "R".
END FUNCTION.

FUNCTION fnqz RETURNS CHARACTER (x AS INT, m AS INT, a AS INT, s AS INT):
/*------------------------------------------------------------------------------
Purpose: Workflow implemenation for 'qz'
Notes:   qz{x<3152:R,m<1947:R,tz}
------------------------------------------------------------------------------*/
   IF x < 3152 THEN RETURN "R".
   IF m < 1947 THEN RETURN "R".
   RETURN "tz".
END FUNCTION.

FUNCTION fnbln RETURNS CHARACTER (x AS INT, m AS INT, a AS INT, s AS INT):
/*------------------------------------------------------------------------------
Purpose: Workflow implemenation for 'bln'
Notes:   bln{m>1964:A,R}
------------------------------------------------------------------------------*/
   IF m > 1964 THEN RETURN "A".
   RETURN "R".
END FUNCTION.

FUNCTION fnlh RETURNS CHARACTER (x AS INT, m AS INT, a AS INT, s AS INT):
/*------------------------------------------------------------------------------
Purpose: Workflow implemenation for 'lh'
Notes:   lh{s<2877:xqk,R}
------------------------------------------------------------------------------*/
   IF s < 2877 THEN RETURN "xqk".
   RETURN "R".
END FUNCTION.

FUNCTION fnxhd RETURNS CHARACTER (x AS INT, m AS INT, a AS INT, s AS INT):
/*------------------------------------------------------------------------------
Purpose: Workflow implemenation for 'xhd'
Notes:   xhd{x<3255:ps,dz}
------------------------------------------------------------------------------*/
   IF x < 3255 THEN RETURN "ps".
   RETURN "dz".
END FUNCTION.

FUNCTION fnkrn RETURNS CHARACTER (x AS INT, m AS INT, a AS INT, s AS INT):
/*------------------------------------------------------------------------------
Purpose: Workflow implemenation for 'krn'
Notes:   krn{m>1099:gm,gjk}
------------------------------------------------------------------------------*/
   IF m > 1099 THEN RETURN "gm".
   RETURN "gjk".
END FUNCTION.

FUNCTION fnhpp RETURNS CHARACTER (x AS INT, m AS INT, a AS INT, s AS INT):
/*------------------------------------------------------------------------------
Purpose: Workflow implemenation for 'hpp'
Notes:   hpp{a<3169:A,s<938:R,A}
------------------------------------------------------------------------------*/
   IF a < 3169 THEN RETURN "A".
   IF s < 938 THEN RETURN "R".
   RETURN "A".
END FUNCTION.

FUNCTION fnsrj RETURNS CHARACTER (x AS INT, m AS INT, a AS INT, s AS INT):
/*------------------------------------------------------------------------------
Purpose: Workflow implemenation for 'srj'
Notes:   srj{m<3640:A,A}
------------------------------------------------------------------------------*/
   IF m < 3640 THEN RETURN "A".
   RETURN "A".
END FUNCTION.

FUNCTION fnfgh RETURNS CHARACTER (x AS INT, m AS INT, a AS INT, s AS INT):
/*------------------------------------------------------------------------------
Purpose: Workflow implemenation for 'fgh'
Notes:   fgh{m>1756:R,m>1722:R,s>1813:A,R}
------------------------------------------------------------------------------*/
   IF m > 1756 THEN RETURN "R".
   IF m > 1722 THEN RETURN "R".
   IF s > 1813 THEN RETURN "A".
   RETURN "R".
END FUNCTION.

FUNCTION fngrd RETURNS CHARACTER (x AS INT, m AS INT, a AS INT, s AS INT):
/*------------------------------------------------------------------------------
Purpose: Workflow implemenation for 'grd'
Notes:   grd{x<1684:A,x>2484:A,x<2179:R,A}
------------------------------------------------------------------------------*/
   IF x < 1684 THEN RETURN "A".
   IF x > 2484 THEN RETURN "A".
   IF x < 2179 THEN RETURN "R".
   RETURN "A".
END FUNCTION.

FUNCTION fnmpj RETURNS CHARACTER (x AS INT, m AS INT, a AS INT, s AS INT):
/*------------------------------------------------------------------------------
Purpose: Workflow implemenation for 'mpj'
Notes:   mpj{a<3142:A,x<2258:tpz,R}
------------------------------------------------------------------------------*/
   IF a < 3142 THEN RETURN "A".
   IF x < 2258 THEN RETURN "tpz".
   RETURN "R".
END FUNCTION.

FUNCTION fnjv RETURNS CHARACTER (x AS INT, m AS INT, a AS INT, s AS INT):
/*------------------------------------------------------------------------------
Purpose: Workflow implemenation for 'jv'
Notes:   jv{x>3146:sq,s>269:R,cb}
------------------------------------------------------------------------------*/
   IF x > 3146 THEN RETURN "sq".
   IF s > 269 THEN RETURN "R".
   RETURN "cb".
END FUNCTION.

FUNCTION fnvc RETURNS CHARACTER (x AS INT, m AS INT, a AS INT, s AS INT):
/*------------------------------------------------------------------------------
Purpose: Workflow implemenation for 'vc'
Notes:   vc{a<1112:A,m<1598:jng,m<1694:A,fgh}
------------------------------------------------------------------------------*/
   IF a < 1112 THEN RETURN "A".
   IF m < 1598 THEN RETURN "jng".
   IF m < 1694 THEN RETURN "A".
   RETURN "fgh".
END FUNCTION.

FUNCTION fntct RETURNS CHARACTER (x AS INT, m AS INT, a AS INT, s AS INT):
/*------------------------------------------------------------------------------
Purpose: Workflow implemenation for 'tct'
Notes:   tct{a>3518:R,jp}
------------------------------------------------------------------------------*/
   IF a > 3518 THEN RETURN "R".
   RETURN "jp".
END FUNCTION.

FUNCTION fnszk RETURNS CHARACTER (x AS INT, m AS INT, a AS INT, s AS INT):
/*------------------------------------------------------------------------------
Purpose: Workflow implemenation for 'szk'
Notes:   szk{x>2702:A,s>821:A,x<2020:A,R}
------------------------------------------------------------------------------*/
   IF x > 2702 THEN RETURN "A".
   IF s > 821 THEN RETURN "A".
   IF x < 2020 THEN RETURN "A".
   RETURN "R".
END FUNCTION.

FUNCTION fntt RETURNS CHARACTER (x AS INT, m AS INT, a AS INT, s AS INT):
/*------------------------------------------------------------------------------
Purpose: Workflow implemenation for 'tt'
Notes:   tt{x<3002:A,x<3058:R,s<2845:R,A}
------------------------------------------------------------------------------*/
   IF x < 3002 THEN RETURN "A".
   IF x < 3058 THEN RETURN "R".
   IF s < 2845 THEN RETURN "R".
   RETURN "A".
END FUNCTION.

FUNCTION fnxv RETURNS CHARACTER (x AS INT, m AS INT, a AS INT, s AS INT):
/*------------------------------------------------------------------------------
Purpose: Workflow implemenation for 'xv'
Notes:   xv{a<1832:A,s<1237:A,s<1251:A,R}
------------------------------------------------------------------------------*/
   IF a < 1832 THEN RETURN "A".
   IF s < 1237 THEN RETURN "A".
   IF s < 1251 THEN RETURN "A".
   RETURN "R".
END FUNCTION.

FUNCTION fnvrq RETURNS CHARACTER (x AS INT, m AS INT, a AS INT, s AS INT):
/*------------------------------------------------------------------------------
Purpose: Workflow implemenation for 'vrq'
Notes:   vrq{a<1062:jtr,R}
------------------------------------------------------------------------------*/
   IF a < 1062 THEN RETURN "jtr".
   RETURN "R".
END FUNCTION.

FUNCTION fnfbz RETURNS CHARACTER (x AS INT, m AS INT, a AS INT, s AS INT):
/*------------------------------------------------------------------------------
Purpose: Workflow implemenation for 'fbz'
Notes:   fbz{m>2837:A,A}
------------------------------------------------------------------------------*/
   IF m > 2837 THEN RETURN "A".
   RETURN "A".
END FUNCTION.

FUNCTION fnms RETURNS CHARACTER (x AS INT, m AS INT, a AS INT, s AS INT):
/*------------------------------------------------------------------------------
Purpose: Workflow implemenation for 'ms'
Notes:   ms{m<3212:A,A}
------------------------------------------------------------------------------*/
   IF m < 3212 THEN RETURN "A".
   RETURN "A".
END FUNCTION.

FUNCTION fndz RETURNS CHARACTER (x AS INT, m AS INT, a AS INT, s AS INT):
/*------------------------------------------------------------------------------
Purpose: Workflow implemenation for 'dz'
Notes:   dz{x>3696:dk,m<3179:A,A}
------------------------------------------------------------------------------*/
   IF x > 3696 THEN RETURN "dk".
   IF m < 3179 THEN RETURN "A".
   RETURN "A".
END FUNCTION.

FUNCTION fnsq RETURNS CHARACTER (x AS INT, m AS INT, a AS INT, s AS INT):
/*------------------------------------------------------------------------------
Purpose: Workflow implemenation for 'sq'
Notes:   sq{x<3517:A,m<1576:R,m>1616:A,R}
------------------------------------------------------------------------------*/
   IF x < 3517 THEN RETURN "A".
   IF m < 1576 THEN RETURN "R".
   IF m > 1616 THEN RETURN "A".
   RETURN "R".
END FUNCTION.

FUNCTION fnvrv RETURNS CHARACTER (x AS INT, m AS INT, a AS INT, s AS INT):
/*------------------------------------------------------------------------------
Purpose: Workflow implemenation for 'vrv'
Notes:   vrv{x>2073:A,m<3335:A,a>3264:R,A}
------------------------------------------------------------------------------*/
   IF x > 2073 THEN RETURN "A".
   IF m < 3335 THEN RETURN "A".
   IF a > 3264 THEN RETURN "R".
   RETURN "A".
END FUNCTION.

FUNCTION fnnx RETURNS CHARACTER (x AS INT, m AS INT, a AS INT, s AS INT):
/*------------------------------------------------------------------------------
Purpose: Workflow implemenation for 'nx'
Notes:   nx{s>284:R,A}
------------------------------------------------------------------------------*/
   IF s > 284 THEN RETURN "R".
   RETURN "A".
END FUNCTION.

FUNCTION fnbq RETURNS CHARACTER (x AS INT, m AS INT, a AS INT, s AS INT):
/*------------------------------------------------------------------------------
Purpose: Workflow implemenation for 'bq'
Notes:   bq{a<1964:ddh,zmr}
------------------------------------------------------------------------------*/
   IF a < 1964 THEN RETURN "ddh".
   RETURN "zmr".
END FUNCTION.

FUNCTION fnghk RETURNS CHARACTER (x AS INT, m AS INT, a AS INT, s AS INT):
/*------------------------------------------------------------------------------
Purpose: Workflow implemenation for 'ghk'
Notes:   ghk{a<441:R,A}
------------------------------------------------------------------------------*/
   IF a < 441 THEN RETURN "R".
   RETURN "A".
END FUNCTION.

FUNCTION fnbr RETURNS CHARACTER (x AS INT, m AS INT, a AS INT, s AS INT):
/*------------------------------------------------------------------------------
Purpose: Workflow implemenation for 'br'
Notes:   br{a<2694:smm,x>795:zzv,s<2123:A,R}
------------------------------------------------------------------------------*/
   IF a < 2694 THEN RETURN "smm".
   IF x > 795 THEN RETURN "zzv".
   IF s < 2123 THEN RETURN "A".
   RETURN "R".
END FUNCTION.

FUNCTION fnkmr RETURNS CHARACTER (x AS INT, m AS INT, a AS INT, s AS INT):
/*------------------------------------------------------------------------------
Purpose: Workflow implemenation for 'kmr'
Notes:   kmr{x>1717:A,a>3663:A,s<3538:R,R}
------------------------------------------------------------------------------*/
   IF x > 1717 THEN RETURN "A".
   IF a > 3663 THEN RETURN "A".
   IF s < 3538 THEN RETURN "R".
   RETURN "R".
END FUNCTION.

FUNCTION fnhc RETURNS CHARACTER (x AS INT, m AS INT, a AS INT, s AS INT):
/*------------------------------------------------------------------------------
Purpose: Workflow implemenation for 'hc'
Notes:   hc{s<318:A,R}
------------------------------------------------------------------------------*/
   IF s < 318 THEN RETURN "A".
   RETURN "R".
END FUNCTION.

FUNCTION fnvr RETURNS CHARACTER (x AS INT, m AS INT, a AS INT, s AS INT):
/*------------------------------------------------------------------------------
Purpose: Workflow implemenation for 'vr'
Notes:   vr{a<399:A,x>2222:A,m>3016:A,A}
------------------------------------------------------------------------------*/
   IF a < 399 THEN RETURN "A".
   IF x > 2222 THEN RETURN "A".
   IF m > 3016 THEN RETURN "A".
   RETURN "A".
END FUNCTION.

FUNCTION fncl RETURNS CHARACTER (x AS INT, m AS INT, a AS INT, s AS INT):
/*------------------------------------------------------------------------------
Purpose: Workflow implemenation for 'cl'
Notes:   cl{m>2530:ct,x<1855:qvv,dh}
------------------------------------------------------------------------------*/
   IF m > 2530 THEN RETURN "ct".
   IF x < 1855 THEN RETURN "qvv".
   RETURN "dh".
END FUNCTION.

FUNCTION fnvmp RETURNS CHARACTER (x AS INT, m AS INT, a AS INT, s AS INT):
/*------------------------------------------------------------------------------
Purpose: Workflow implemenation for 'vmp'
Notes:   vmp{x>236:R,x>131:A,A}
------------------------------------------------------------------------------*/
   IF x > 236 THEN RETURN "R".
   IF x > 131 THEN RETURN "A".
   RETURN "A".
END FUNCTION.

FUNCTION fnvq RETURNS CHARACTER (x AS INT, m AS INT, a AS INT, s AS INT):
/*------------------------------------------------------------------------------
Purpose: Workflow implemenation for 'vq'
Notes:   vq{s>526:vb,a>2478:kf,jv}
------------------------------------------------------------------------------*/
   IF s > 526 THEN RETURN "vb".
   IF a > 2478 THEN RETURN "kf".
   RETURN "jv".
END FUNCTION.

FUNCTION fnmdb RETURNS CHARACTER (x AS INT, m AS INT, a AS INT, s AS INT):
/*------------------------------------------------------------------------------
Purpose: Workflow implemenation for 'mdb'
Notes:   mdb{a<380:R,m<2455:R,A}
------------------------------------------------------------------------------*/
   IF a < 380 THEN RETURN "R".
   IF m < 2455 THEN RETURN "R".
   RETURN "A".
END FUNCTION.

FUNCTION fncpb RETURNS CHARACTER (x AS INT, m AS INT, a AS INT, s AS INT):
/*------------------------------------------------------------------------------
Purpose: Workflow implemenation for 'cpb'
Notes:   cpb{s<1179:dzj,dj}
------------------------------------------------------------------------------*/
   IF s < 1179 THEN RETURN "dzj".
   RETURN "dj".
END FUNCTION.

FUNCTION fnssz RETURNS CHARACTER (x AS INT, m AS INT, a AS INT, s AS INT):
/*------------------------------------------------------------------------------
Purpose: Workflow implemenation for 'ssz'
Notes:   ssz{s>1128:A,R}
------------------------------------------------------------------------------*/
   IF s > 1128 THEN RETURN "A".
   RETURN "R".
END FUNCTION.

FUNCTION fnmmr RETURNS CHARACTER (x AS INT, m AS INT, a AS INT, s AS INT):
/*------------------------------------------------------------------------------
Purpose: Workflow implemenation for 'mmr'
Notes:   mmr{m<3107:R,R}
------------------------------------------------------------------------------*/
   IF m < 3107 THEN RETURN "R".
   RETURN "R".
END FUNCTION.

FUNCTION fnddh RETURNS CHARACTER (x AS INT, m AS INT, a AS INT, s AS INT):
/*------------------------------------------------------------------------------
Purpose: Workflow implemenation for 'ddh'
Notes:   ddh{x>3498:tm,R}
------------------------------------------------------------------------------*/
   IF x > 3498 THEN RETURN "tm".
   RETURN "R".
END FUNCTION.

FUNCTION fnmk RETURNS CHARACTER (x AS INT, m AS INT, a AS INT, s AS INT):
/*------------------------------------------------------------------------------
Purpose: Workflow implemenation for 'mk'
Notes:   mk{x>561:A,s>98:R,x>197:R,R}
------------------------------------------------------------------------------*/
   IF x > 561 THEN RETURN "A".
   IF s > 98 THEN RETURN "R".
   IF x > 197 THEN RETURN "R".
   RETURN "R".
END FUNCTION.

FUNCTION fnjdn RETURNS CHARACTER (x AS INT, m AS INT, a AS INT, s AS INT):
/*------------------------------------------------------------------------------
Purpose: Workflow implemenation for 'jdn'
Notes:   jdn{a>1667:R,xlx}
------------------------------------------------------------------------------*/
   IF a > 1667 THEN RETURN "R".
   RETURN "xlx".
END FUNCTION.

FUNCTION fnskh RETURNS CHARACTER (x AS INT, m AS INT, a AS INT, s AS INT):
/*------------------------------------------------------------------------------
Purpose: Workflow implemenation for 'skh'
Notes:   skh{s<2941:R,a<1171:R,s<3134:A,A}
------------------------------------------------------------------------------*/
   IF s < 2941 THEN RETURN "R".
   IF a < 1171 THEN RETURN "R".
   IF s < 3134 THEN RETURN "A".
   RETURN "A".
END FUNCTION.

FUNCTION fnktr RETURNS CHARACTER (x AS INT, m AS INT, a AS INT, s AS INT):
/*------------------------------------------------------------------------------
Purpose: Workflow implemenation for 'ktr'
Notes:   ktr{s>2122:rk,a<757:tsm,vrq}
------------------------------------------------------------------------------*/
   IF s > 2122 THEN RETURN "rk".
   IF a < 757 THEN RETURN "tsm".
   RETURN "vrq".
END FUNCTION.

FUNCTION fnjs RETURNS CHARACTER (x AS INT, m AS INT, a AS INT, s AS INT):
/*------------------------------------------------------------------------------
Purpose: Workflow implemenation for 'js'
Notes:   js{x<1491:A,R}
------------------------------------------------------------------------------*/
   IF x < 1491 THEN RETURN "A".
   RETURN "R".
END FUNCTION.

FUNCTION fnjnr RETURNS CHARACTER (x AS INT, m AS INT, a AS INT, s AS INT):
/*------------------------------------------------------------------------------
Purpose: Workflow implemenation for 'jnr'
Notes:   jnr{s<796:R,s>1213:R,A}
------------------------------------------------------------------------------*/
   IF s < 796 THEN RETURN "R".
   IF s > 1213 THEN RETURN "R".
   RETURN "A".
END FUNCTION.

FUNCTION fnxd RETURNS CHARACTER (x AS INT, m AS INT, a AS INT, s AS INT):
/*------------------------------------------------------------------------------
Purpose: Workflow implemenation for 'xd'
Notes:   xd{x<2458:hv,x<3129:cgj,m>2807:qbb,pz}
------------------------------------------------------------------------------*/
   IF x < 2458 THEN RETURN "hv".
   IF x < 3129 THEN RETURN "cgj".
   IF m > 2807 THEN RETURN "qbb".
   RETURN "pz".
END FUNCTION.

FUNCTION fnhfl RETURNS CHARACTER (x AS INT, m AS INT, a AS INT, s AS INT):
/*------------------------------------------------------------------------------
Purpose: Workflow implemenation for 'hfl'
Notes:   hfl{s<300:A,R}
------------------------------------------------------------------------------*/
   IF s < 300 THEN RETURN "A".
   RETURN "R".
END FUNCTION.

FUNCTION fnzxt RETURNS CHARACTER (x AS INT, m AS INT, a AS INT, s AS INT):
/*------------------------------------------------------------------------------
Purpose: Workflow implemenation for 'zxt'
Notes:   zxt{s<2782:A,s<3589:A,s>3804:R,R}
------------------------------------------------------------------------------*/
   IF s < 2782 THEN RETURN "A".
   IF s < 3589 THEN RETURN "A".
   IF s > 3804 THEN RETURN "R".
   RETURN "R".
END FUNCTION.

FUNCTION fnkf RETURNS CHARACTER (x AS INT, m AS INT, a AS INT, s AS INT):
/*------------------------------------------------------------------------------
Purpose: Workflow implemenation for 'kf'
Notes:   kf{s<213:kht,s<412:nx,m>1587:A,ksp}
------------------------------------------------------------------------------*/
   IF s < 213 THEN RETURN "kht".
   IF s < 412 THEN RETURN "nx".
   IF m > 1587 THEN RETURN "A".
   RETURN "ksp".
END FUNCTION.

FUNCTION fnjdt RETURNS CHARACTER (x AS INT, m AS INT, a AS INT, s AS INT):
/*------------------------------------------------------------------------------
Purpose: Workflow implemenation for 'jdt'
Notes:   jdt{a<424:R,x<2178:R,a<690:A,tvf}
------------------------------------------------------------------------------*/
   IF a < 424 THEN RETURN "R".
   IF x < 2178 THEN RETURN "R".
   IF a < 690 THEN RETURN "A".
   RETURN "tvf".
END FUNCTION.

FUNCTION fndns RETURNS CHARACTER (x AS INT, m AS INT, a AS INT, s AS INT):
/*------------------------------------------------------------------------------
Purpose: Workflow implemenation for 'dns'
Notes:   dns{s<2857:xbf,s<3399:llz,a>196:fdf,jsq}
------------------------------------------------------------------------------*/
   IF s < 2857 THEN RETURN "xbf".
   IF s < 3399 THEN RETURN "llz".
   IF a > 196 THEN RETURN "fdf".
   RETURN "jsq".
END FUNCTION.

FUNCTION fndd RETURNS CHARACTER (x AS INT, m AS INT, a AS INT, s AS INT):
/*------------------------------------------------------------------------------
Purpose: Workflow implemenation for 'dd'
Notes:   dd{x>1491:R,s<398:A,A}
------------------------------------------------------------------------------*/
   IF x > 1491 THEN RETURN "R".
   IF s < 398 THEN RETURN "A".
   RETURN "A".
END FUNCTION.

FUNCTION fnjmc RETURNS CHARACTER (x AS INT, m AS INT, a AS INT, s AS INT):
/*------------------------------------------------------------------------------
Purpose: Workflow implemenation for 'jmc'
Notes:   jmc{a<2988:xjq,s>688:A,trj}
------------------------------------------------------------------------------*/
   IF a < 2988 THEN RETURN "xjq".
   IF s > 688 THEN RETURN "A".
   RETURN "trj".
END FUNCTION.

FUNCTION fnhkd RETURNS CHARACTER (x AS INT, m AS INT, a AS INT, s AS INT):
/*------------------------------------------------------------------------------
Purpose: Workflow implemenation for 'hkd'
Notes:   hkd{a<163:jnr,R}
------------------------------------------------------------------------------*/
   IF a < 163 THEN RETURN "jnr".
   RETURN "R".
END FUNCTION.

FUNCTION fnzmb RETURNS CHARACTER (x AS INT, m AS INT, a AS INT, s AS INT):
/*------------------------------------------------------------------------------
Purpose: Workflow implemenation for 'zmb'
Notes:   zmb{m<3165:pls,gpv}
------------------------------------------------------------------------------*/
   IF m < 3165 THEN RETURN "pls".
   RETURN "gpv".
END FUNCTION.

FUNCTION fnmb RETURNS CHARACTER (x AS INT, m AS INT, a AS INT, s AS INT):
/*------------------------------------------------------------------------------
Purpose: Workflow implemenation for 'mb'
Notes:   mb{m<3218:A,m>3585:A,m>3436:A,R}
------------------------------------------------------------------------------*/
   IF m < 3218 THEN RETURN "A".
   IF m > 3585 THEN RETURN "A".
   IF m > 3436 THEN RETURN "A".
   RETURN "R".
END FUNCTION.

FUNCTION fnmsx RETURNS CHARACTER (x AS INT, m AS INT, a AS INT, s AS INT):
/*------------------------------------------------------------------------------
Purpose: Workflow implemenation for 'msx'
Notes:   msx{x<3666:R,m<3398:R,a<3006:R,A}
------------------------------------------------------------------------------*/
   IF x < 3666 THEN RETURN "R".
   IF m < 3398 THEN RETURN "R".
   IF a < 3006 THEN RETURN "R".
   RETURN "A".
END FUNCTION.

FUNCTION fnvz RETURNS CHARACTER (x AS INT, m AS INT, a AS INT, s AS INT):
/*------------------------------------------------------------------------------
Purpose: Workflow implemenation for 'vz'
Notes:   vz{s<1252:A,A}
------------------------------------------------------------------------------*/
   IF s < 1252 THEN RETURN "A".
   RETURN "A".
END FUNCTION.

FUNCTION fnbvc RETURNS CHARACTER (x AS INT, m AS INT, a AS INT, s AS INT):
/*------------------------------------------------------------------------------
Purpose: Workflow implemenation for 'bvc'
Notes:   bvc{s<449:R,a>3035:A,R}
------------------------------------------------------------------------------*/
   IF s < 449 THEN RETURN "R".
   IF a > 3035 THEN RETURN "A".
   RETURN "R".
END FUNCTION.

FUNCTION fngz RETURNS CHARACTER (x AS INT, m AS INT, a AS INT, s AS INT):
/*------------------------------------------------------------------------------
Purpose: Workflow implemenation for 'gz'
Notes:   gz{x<3316:zcz,qzq}
------------------------------------------------------------------------------*/
   IF x < 3316 THEN RETURN "zcz".
   RETURN "qzq".
END FUNCTION.

FUNCTION fnbb RETURNS CHARACTER (x AS INT, m AS INT, a AS INT, s AS INT):
/*------------------------------------------------------------------------------
Purpose: Workflow implemenation for 'bb'
Notes:   bb{m<2381:R,x>2178:R,a<1435:R,A}
------------------------------------------------------------------------------*/
   IF m < 2381 THEN RETURN "R".
   IF x > 2178 THEN RETURN "R".
   IF a < 1435 THEN RETURN "R".
   RETURN "A".
END FUNCTION.

FUNCTION fnqch RETURNS CHARACTER (x AS INT, m AS INT, a AS INT, s AS INT):
/*------------------------------------------------------------------------------
Purpose: Workflow implemenation for 'qch'
Notes:   qch{s>2944:A,m>1485:A,s>2282:R,R}
------------------------------------------------------------------------------*/
   IF s > 2944 THEN RETURN "A".
   IF m > 1485 THEN RETURN "A".
   IF s > 2282 THEN RETURN "R".
   RETURN "R".
END FUNCTION.

FUNCTION fnfdf RETURNS CHARACTER (x AS INT, m AS INT, a AS INT, s AS INT):
/*------------------------------------------------------------------------------
Purpose: Workflow implemenation for 'fdf'
Notes:   fdf{a>234:R,a<219:R,m<652:R,R}
------------------------------------------------------------------------------*/
   IF a > 234 THEN RETURN "R".
   IF a < 219 THEN RETURN "R".
   IF m < 652 THEN RETURN "R".
   RETURN "R".
END FUNCTION.

FUNCTION fnbqr RETURNS CHARACTER (x AS INT, m AS INT, a AS INT, s AS INT):
/*------------------------------------------------------------------------------
Purpose: Workflow implemenation for 'bqr'
Notes:   bqr{m<1655:A,A}
------------------------------------------------------------------------------*/
   IF m < 1655 THEN RETURN "A".
   RETURN "A".
END FUNCTION.

FUNCTION fndjn RETURNS CHARACTER (x AS INT, m AS INT, a AS INT, s AS INT):
/*------------------------------------------------------------------------------
Purpose: Workflow implemenation for 'djn'
Notes:   djn{x>2008:nt,a<993:jns,x<1955:R,sjr}
------------------------------------------------------------------------------*/
   IF x > 2008 THEN RETURN "nt".
   IF a < 993 THEN RETURN "jns".
   IF x < 1955 THEN RETURN "R".
   RETURN "sjr".
END FUNCTION.

FUNCTION fnxbf RETURNS CHARACTER (x AS INT, m AS INT, a AS INT, s AS INT):
/*------------------------------------------------------------------------------
Purpose: Workflow implemenation for 'xbf'
Notes:   xbf{m<712:A,x>1977:R,A}
------------------------------------------------------------------------------*/
   IF m < 712 THEN RETURN "A".
   IF x > 1977 THEN RETURN "R".
   RETURN "A".
END FUNCTION.

FUNCTION fnqpp RETURNS CHARACTER (x AS INT, m AS INT, a AS INT, s AS INT):
/*------------------------------------------------------------------------------
Purpose: Workflow implemenation for 'qpp'
Notes:   qpp{s<3361:xd,x>2233:gz,s>3593:ts,sxk}
------------------------------------------------------------------------------*/
   IF s < 3361 THEN RETURN "xd".
   IF x > 2233 THEN RETURN "gz".
   IF s > 3593 THEN RETURN "ts".
   RETURN "sxk".
END FUNCTION.

FUNCTION fnsrq RETURNS CHARACTER (x AS INT, m AS INT, a AS INT, s AS INT):
/*------------------------------------------------------------------------------
Purpose: Workflow implemenation for 'srq'
Notes:   srq{s<567:nhh,s<733:kzb,a<1151:nfr,fj}
------------------------------------------------------------------------------*/
   IF s < 567 THEN RETURN "nhh".
   IF s < 733 THEN RETURN "kzb".
   IF a < 1151 THEN RETURN "nfr".
   RETURN "fj".
END FUNCTION.

FUNCTION fnvgz RETURNS CHARACTER (x AS INT, m AS INT, a AS INT, s AS INT):
/*------------------------------------------------------------------------------
Purpose: Workflow implemenation for 'vgz'
Notes:   vgz{x<2442:R,x>3163:A,s<1109:A,A}
------------------------------------------------------------------------------*/
   IF x < 2442 THEN RETURN "R".
   IF x > 3163 THEN RETURN "A".
   IF s < 1109 THEN RETURN "A".
   RETURN "A".
END FUNCTION.

FUNCTION fnspf RETURNS CHARACTER (x AS INT, m AS INT, a AS INT, s AS INT):
/*------------------------------------------------------------------------------
Purpose: Workflow implemenation for 'spf'
Notes:   spf{m>3098:A,a>1114:R,x<2359:vr,R}
------------------------------------------------------------------------------*/
   IF m > 3098 THEN RETURN "A".
   IF a > 1114 THEN RETURN "R".
   IF x < 2359 THEN RETURN "vr".
   RETURN "R".
END FUNCTION.

FUNCTION fnlk RETURNS CHARACTER (x AS INT, m AS INT, a AS INT, s AS INT):
/*------------------------------------------------------------------------------
Purpose: Workflow implemenation for 'lk'
Notes:   lk{m<1007:R,m<1155:A,A}
------------------------------------------------------------------------------*/
   IF m < 1007 THEN RETURN "R".
   IF m < 1155 THEN RETURN "A".
   RETURN "A".
END FUNCTION.

FUNCTION fncq RETURNS CHARACTER (x AS INT, m AS INT, a AS INT, s AS INT):
/*------------------------------------------------------------------------------
Purpose: Workflow implemenation for 'cq'
Notes:   cq{x<3030:R,m<3304:A,s>244:R,R}
------------------------------------------------------------------------------*/
   IF x < 3030 THEN RETURN "R".
   IF m < 3304 THEN RETURN "A".
   IF s > 244 THEN RETURN "R".
   RETURN "R".
END FUNCTION.

FUNCTION fnhpn RETURNS CHARACTER (x AS INT, m AS INT, a AS INT, s AS INT):
/*------------------------------------------------------------------------------
Purpose: Workflow implemenation for 'hpn'
Notes:   hpn{m>3374:A,s<535:R,R}
------------------------------------------------------------------------------*/
   IF m > 3374 THEN RETURN "A".
   IF s < 535 THEN RETURN "R".
   RETURN "R".
END FUNCTION.

FUNCTION fnpnr RETURNS CHARACTER (x AS INT, m AS INT, a AS INT, s AS INT):
/*------------------------------------------------------------------------------
Purpose: Workflow implemenation for 'pnr'
Notes:   pnr{s<564:R,a>1040:A,x>573:knx,vd}
------------------------------------------------------------------------------*/
   IF s < 564 THEN RETURN "R".
   IF a > 1040 THEN RETURN "A".
   IF x > 573 THEN RETURN "knx".
   RETURN "vd".
END FUNCTION.

FUNCTION fncc RETURNS CHARACTER (x AS INT, m AS INT, a AS INT, s AS INT):
/*------------------------------------------------------------------------------
Purpose: Workflow implemenation for 'cc'
Notes:   cc{s>1430:mfd,A}
------------------------------------------------------------------------------*/
   IF s > 1430 THEN RETURN "mfd".
   RETURN "A".
END FUNCTION.

FUNCTION fnfdb RETURNS CHARACTER (x AS INT, m AS INT, a AS INT, s AS INT):
/*------------------------------------------------------------------------------
Purpose: Workflow implemenation for 'fdb'
Notes:   fdb{s>349:R,s>228:A,s>81:A,A}
------------------------------------------------------------------------------*/
   IF s > 349 THEN RETURN "R".
   IF s > 228 THEN RETURN "A".
   IF s > 81 THEN RETURN "A".
   RETURN "A".
END FUNCTION.

FUNCTION fncm RETURNS CHARACTER (x AS INT, m AS INT, a AS INT, s AS INT):
/*------------------------------------------------------------------------------
Purpose: Workflow implemenation for 'cm'
Notes:   cm{m<1985:R,x>2862:R,A}
------------------------------------------------------------------------------*/
   IF m < 1985 THEN RETURN "R".
   IF x > 2862 THEN RETURN "R".
   RETURN "A".
END FUNCTION.

FUNCTION fnzg RETURNS CHARACTER (x AS INT, m AS INT, a AS INT, s AS INT):
/*------------------------------------------------------------------------------
Purpose: Workflow implemenation for 'zg'
Notes:   zg{x<2013:R,s>3441:A,R}
------------------------------------------------------------------------------*/
   IF x < 2013 THEN RETURN "R".
   IF s > 3441 THEN RETURN "A".
   RETURN "R".
END FUNCTION.

FUNCTION fnth RETURNS CHARACTER (x AS INT, m AS INT, a AS INT, s AS INT):
/*------------------------------------------------------------------------------
Purpose: Workflow implemenation for 'th'
Notes:   th{s<768:A,s<776:R,m>3551:R,R}
------------------------------------------------------------------------------*/
   IF s < 768 THEN RETURN "A".
   IF s < 776 THEN RETURN "R".
   IF m > 3551 THEN RETURN "R".
   RETURN "R".
END FUNCTION.

FUNCTION fnbvt RETURNS CHARACTER (x AS INT, m AS INT, a AS INT, s AS INT):
/*------------------------------------------------------------------------------
Purpose: Workflow implemenation for 'bvt'
Notes:   bvt{s<883:pxk,A}
------------------------------------------------------------------------------*/
   IF s < 883 THEN RETURN "pxk".
   RETURN "A".
END FUNCTION.

FUNCTION fnps RETURNS CHARACTER (x AS INT, m AS INT, a AS INT, s AS INT):
/*------------------------------------------------------------------------------
Purpose: Workflow implemenation for 'ps'
Notes:   ps{x<2852:R,a<1334:kj,R}
------------------------------------------------------------------------------*/
   IF x < 2852 THEN RETURN "R".
   IF a < 1334 THEN RETURN "kj".
   RETURN "R".
END FUNCTION.

FUNCTION fnxmr RETURNS CHARACTER (x AS INT, m AS INT, a AS INT, s AS INT):
/*------------------------------------------------------------------------------
Purpose: Workflow implemenation for 'xmr'
Notes:   xmr{x>2490:xs,x<2141:djn,m>2911:spf,pg}
------------------------------------------------------------------------------*/
   IF x > 2490 THEN RETURN "xs".
   IF x < 2141 THEN RETURN "djn".
   IF m > 2911 THEN RETURN "spf".
   RETURN "pg".
END FUNCTION.

FUNCTION fntsm RETURNS CHARACTER (x AS INT, m AS INT, a AS INT, s AS INT):
/*------------------------------------------------------------------------------
Purpose: Workflow implemenation for 'tsm'
Notes:   tsm{s<872:A,a<426:bln,x>1500:db,A}
------------------------------------------------------------------------------*/
   IF s < 872 THEN RETURN "A".
   IF a < 426 THEN RETURN "bln".
   IF x > 1500 THEN RETURN "db".
   RETURN "A".
END FUNCTION.

FUNCTION fnqsl RETURNS CHARACTER (x AS INT, m AS INT, a AS INT, s AS INT):
/*------------------------------------------------------------------------------
Purpose: Workflow implemenation for 'qsl'
Notes:   qsl{m<1825:gd,m>1995:tmb,m>1914:ktr,plm}
------------------------------------------------------------------------------*/
   IF m < 1825 THEN RETURN "gd".
   IF m > 1995 THEN RETURN "tmb".
   IF m > 1914 THEN RETURN "ktr".
   RETURN "plm".
END FUNCTION.

FUNCTION fntvf RETURNS CHARACTER (x AS INT, m AS INT, a AS INT, s AS INT):
/*------------------------------------------------------------------------------
Purpose: Workflow implemenation for 'tvf'
Notes:   tvf{s<308:A,m<3477:A,x>2430:A,R}
------------------------------------------------------------------------------*/
   IF s < 308 THEN RETURN "A".
   IF m < 3477 THEN RETURN "A".
   IF x > 2430 THEN RETURN "A".
   RETURN "R".
END FUNCTION.

FUNCTION fnnbb RETURNS CHARACTER (x AS INT, m AS INT, a AS INT, s AS INT):
/*------------------------------------------------------------------------------
Purpose: Workflow implemenation for 'nbb'
Notes:   nbb{a>3887:R,m<2823:A,khd}
------------------------------------------------------------------------------*/
   IF a > 3887 THEN RETURN "R".
   IF m < 2823 THEN RETURN "A".
   RETURN "khd".
END FUNCTION.

FUNCTION fnjsq RETURNS CHARACTER (x AS INT, m AS INT, a AS INT, s AS INT):
/*------------------------------------------------------------------------------
Purpose: Workflow implemenation for 'jsq'
Notes:   jsq{m<806:R,a<125:R,R}
------------------------------------------------------------------------------*/
   IF m < 806 THEN RETURN "R".
   IF a < 125 THEN RETURN "R".
   RETURN "R".
END FUNCTION.

FUNCTION fngm RETURNS CHARACTER (x AS INT, m AS INT, a AS INT, s AS INT):
/*------------------------------------------------------------------------------
Purpose: Workflow implemenation for 'gm'
Notes:   gm{s<2956:R,m>1252:dfc,s>3550:R,R}
------------------------------------------------------------------------------*/
   IF s < 2956 THEN RETURN "R".
   IF m > 1252 THEN RETURN "dfc".
   IF s > 3550 THEN RETURN "R".
   RETURN "R".
END FUNCTION.

FUNCTION fnkv RETURNS CHARACTER (x AS INT, m AS INT, a AS INT, s AS INT):
/*------------------------------------------------------------------------------
Purpose: Workflow implemenation for 'kv'
Notes:   kv{x>203:R,x<134:A,m<1920:R,R}
------------------------------------------------------------------------------*/
   IF x > 203 THEN RETURN "R".
   IF x < 134 THEN RETURN "A".
   IF m < 1920 THEN RETURN "R".
   RETURN "R".
END FUNCTION.

FUNCTION fnbgc RETURNS CHARACTER (x AS INT, m AS INT, a AS INT, s AS INT):
/*------------------------------------------------------------------------------
Purpose: Workflow implemenation for 'bgc'
Notes:   bgc{m>3875:R,ssz}
------------------------------------------------------------------------------*/
   IF m > 3875 THEN RETURN "R".
   RETURN "ssz".
END FUNCTION.

FUNCTION fnrxh RETURNS CHARACTER (x AS INT, m AS INT, a AS INT, s AS INT):
/*------------------------------------------------------------------------------
Purpose: Workflow implemenation for 'rxh'
Notes:   rxh{a<2551:vgt,jb}
------------------------------------------------------------------------------*/
   IF a < 2551 THEN RETURN "vgt".
   RETURN "jb".
END FUNCTION.

FUNCTION fnpsq RETURNS CHARACTER (x AS INT, m AS INT, a AS INT, s AS INT):
/*------------------------------------------------------------------------------
Purpose: Workflow implemenation for 'psq'
Notes:   psq{s<967:dvk,m<3358:A,R}
------------------------------------------------------------------------------*/
   IF s < 967 THEN RETURN "dvk".
   IF m < 3358 THEN RETURN "A".
   RETURN "R".
END FUNCTION.

FUNCTION fnrg RETURNS CHARACTER (x AS INT, m AS INT, a AS INT, s AS INT):
/*------------------------------------------------------------------------------
Purpose: Workflow implemenation for 'rg'
Notes:   rg{x>249:R,x<137:A,A}
------------------------------------------------------------------------------*/
   IF x > 249 THEN RETURN "R".
   IF x < 137 THEN RETURN "A".
   RETURN "A".
END FUNCTION.

FUNCTION fnrt RETURNS CHARACTER (x AS INT, m AS INT, a AS INT, s AS INT):
/*------------------------------------------------------------------------------
Purpose: Workflow implemenation for 'rt'
Notes:   rt{a>1268:R,a<1073:A,R}
------------------------------------------------------------------------------*/
   IF a > 1268 THEN RETURN "R".
   IF a < 1073 THEN RETURN "A".
   RETURN "R".
END FUNCTION.

FUNCTION fnrcf RETURNS CHARACTER (x AS INT, m AS INT, a AS INT, s AS INT):
/*------------------------------------------------------------------------------
Purpose: Workflow implemenation for 'rcf'
Notes:   rcf{m<3157:A,x<3888:R,R}
------------------------------------------------------------------------------*/
   IF m < 3157 THEN RETURN "A".
   IF x < 3888 THEN RETURN "R".
   RETURN "R".
END FUNCTION.

FUNCTION fnxtd RETURNS CHARACTER (x AS INT, m AS INT, a AS INT, s AS INT):
/*------------------------------------------------------------------------------
Purpose: Workflow implemenation for 'xtd'
Notes:   xtd{a<718:mbs,a>915:ss,a<801:R,A}
------------------------------------------------------------------------------*/
   IF a < 718 THEN RETURN "mbs".
   IF a > 915 THEN RETURN "ss".
   IF a < 801 THEN RETURN "R".
   RETURN "A".
END FUNCTION.

FUNCTION fntlf RETURNS CHARACTER (x AS INT, m AS INT, a AS INT, s AS INT):
/*------------------------------------------------------------------------------
Purpose: Workflow implemenation for 'tlf'
Notes:   tlf{m>331:A,a>2999:R,A}
------------------------------------------------------------------------------*/
   IF m > 331 THEN RETURN "A".
   IF a > 2999 THEN RETURN "R".
   RETURN "A".
END FUNCTION.

FUNCTION fnzl RETURNS CHARACTER (x AS INT, m AS INT, a AS INT, s AS INT):
/*------------------------------------------------------------------------------
Purpose: Workflow implemenation for 'zl'
Notes:   zl{a<2924:R,a<3347:A,m>592:R,R}
------------------------------------------------------------------------------*/
   IF a < 2924 THEN RETURN "R".
   IF a < 3347 THEN RETURN "A".
   IF m > 592 THEN RETURN "R".
   RETURN "R".
END FUNCTION.

FUNCTION fnkdl RETURNS CHARACTER (x AS INT, m AS INT, a AS INT, s AS INT):
/*------------------------------------------------------------------------------
Purpose: Workflow implemenation for 'kdl'
Notes:   kdl{x<3179:A,a>3060:A,A}
------------------------------------------------------------------------------*/
   IF x < 3179 THEN RETURN "A".
   IF a > 3060 THEN RETURN "A".
   RETURN "A".
END FUNCTION.

FUNCTION fnxrn RETURNS CHARACTER (x AS INT, m AS INT, a AS INT, s AS INT):
/*------------------------------------------------------------------------------
Purpose: Workflow implemenation for 'xrn'
Notes:   xrn{s>1236:mdq,a<2044:A,gj}
------------------------------------------------------------------------------*/
   IF s > 1236 THEN RETURN "mdq".
   IF a < 2044 THEN RETURN "A".
   RETURN "gj".
END FUNCTION.

FUNCTION fngj RETURNS CHARACTER (x AS INT, m AS INT, a AS INT, s AS INT):
/*------------------------------------------------------------------------------
Purpose: Workflow implemenation for 'gj'
Notes:   gj{a>2399:R,a<2219:A,s>1215:A,A}
------------------------------------------------------------------------------*/
   IF a > 2399 THEN RETURN "R".
   IF a < 2219 THEN RETURN "A".
   IF s > 1215 THEN RETURN "A".
   RETURN "A".
END FUNCTION.

FUNCTION fnfq RETURNS CHARACTER (x AS INT, m AS INT, a AS INT, s AS INT):
/*------------------------------------------------------------------------------
Purpose: Workflow implemenation for 'fq'
Notes:   fq{s>518:A,x>3344:A,s>294:A,A}
------------------------------------------------------------------------------*/
   IF s > 518 THEN RETURN "A".
   IF x > 3344 THEN RETURN "A".
   IF s > 294 THEN RETURN "A".
   RETURN "A".
END FUNCTION.

FUNCTION fnrb RETURNS CHARACTER (x AS INT, m AS INT, a AS INT, s AS INT):
/*------------------------------------------------------------------------------
Purpose: Workflow implemenation for 'rb'
Notes:   rb{a>3423:R,a>2952:A,x>915:R,R}
------------------------------------------------------------------------------*/
   IF a > 3423 THEN RETURN "R".
   IF a > 2952 THEN RETURN "A".
   IF x > 915 THEN RETURN "R".
   RETURN "R".
END FUNCTION.

FUNCTION fnbg RETURNS CHARACTER (x AS INT, m AS INT, a AS INT, s AS INT):
/*------------------------------------------------------------------------------
Purpose: Workflow implemenation for 'bg'
Notes:   bg{a<433:dd,A}
------------------------------------------------------------------------------*/
   IF a < 433 THEN RETURN "dd".
   RETURN "A".
END FUNCTION.

FUNCTION fnzzv RETURNS CHARACTER (x AS INT, m AS INT, a AS INT, s AS INT):
/*------------------------------------------------------------------------------
Purpose: Workflow implemenation for 'zzv'
Notes:   zzv{x<828:R,s>2255:A,s>1152:R,R}
------------------------------------------------------------------------------*/
   IF x < 828 THEN RETURN "R".
   IF s > 2255 THEN RETURN "A".
   IF s > 1152 THEN RETURN "R".
   RETURN "R".
END FUNCTION.

FUNCTION fnlp RETURNS CHARACTER (x AS INT, m AS INT, a AS INT, s AS INT):
/*------------------------------------------------------------------------------
Purpose: Workflow implemenation for 'lp'
Notes:   lp{m<3249:A,s<3008:A,m<3278:A,R}
------------------------------------------------------------------------------*/
   IF m < 3249 THEN RETURN "A".
   IF s < 3008 THEN RETURN "A".
   IF m < 3278 THEN RETURN "A".
   RETURN "R".
END FUNCTION.

FUNCTION fncvd RETURNS CHARACTER (x AS INT, m AS INT, a AS INT, s AS INT):
/*------------------------------------------------------------------------------
Purpose: Workflow implemenation for 'cvd'
Notes:   cvd{a<2723:A,gdz}
------------------------------------------------------------------------------*/
   IF a < 2723 THEN RETURN "A".
   RETURN "gdz".
END FUNCTION.

FUNCTION fnzcz RETURNS CHARACTER (x AS INT, m AS INT, a AS INT, s AS INT):
/*------------------------------------------------------------------------------
Purpose: Workflow implemenation for 'zcz'
Notes:   zcz{m>3081:A,a>2862:R,a>2373:A,R}
------------------------------------------------------------------------------*/
   IF m > 3081 THEN RETURN "A".
   IF a > 2862 THEN RETURN "R".
   IF a > 2373 THEN RETURN "A".
   RETURN "R".
END FUNCTION.

FUNCTION fnqk RETURNS CHARACTER (x AS INT, m AS INT, a AS INT, s AS INT):
/*------------------------------------------------------------------------------
Purpose: Workflow implemenation for 'qk'
Notes:   qk{a<1277:R,m<3551:R,R}
------------------------------------------------------------------------------*/
   IF a < 1277 THEN RETURN "R".
   IF m < 3551 THEN RETURN "R".
   RETURN "R".
END FUNCTION.

FUNCTION fnhj RETURNS CHARACTER (x AS INT, m AS INT, a AS INT, s AS INT):
/*------------------------------------------------------------------------------
Purpose: Workflow implemenation for 'hj'
Notes:   hj{m>3271:A,x<1007:A,R}
------------------------------------------------------------------------------*/
   IF m > 3271 THEN RETURN "A".
   IF x < 1007 THEN RETURN "A".
   RETURN "R".
END FUNCTION.

FUNCTION fntr RETURNS CHARACTER (x AS INT, m AS INT, a AS INT, s AS INT):
/*------------------------------------------------------------------------------
Purpose: Workflow implemenation for 'tr'
Notes:   tr{a<839:A,A}
------------------------------------------------------------------------------*/
   IF a < 839 THEN RETURN "A".
   RETURN "A".
END FUNCTION.

FUNCTION fnrld RETURNS CHARACTER (x AS INT, m AS INT, a AS INT, s AS INT):
/*------------------------------------------------------------------------------
Purpose: Workflow implemenation for 'rld'
Notes:   rld{s<823:R,m<2378:R,A}
------------------------------------------------------------------------------*/
   IF s < 823 THEN RETURN "R".
   IF m < 2378 THEN RETURN "R".
   RETURN "A".
END FUNCTION.

FUNCTION fnfzv RETURNS CHARACTER (x AS INT, m AS INT, a AS INT, s AS INT):
/*------------------------------------------------------------------------------
Purpose: Workflow implemenation for 'fzv'
Notes:   fzv{a<1192:mqd,a<1307:kg,nz}
------------------------------------------------------------------------------*/
   IF a < 1192 THEN RETURN "mqd".
   IF a < 1307 THEN RETURN "kg".
   RETURN "nz".
END FUNCTION.

FUNCTION fngpv RETURNS CHARACTER (x AS INT, m AS INT, a AS INT, s AS INT):
/*------------------------------------------------------------------------------
Purpose: Workflow implemenation for 'gpv'
Notes:   gpv{x>1141:R,jl}
------------------------------------------------------------------------------*/
   IF x > 1141 THEN RETURN "R".
   RETURN "jl".
END FUNCTION.

FUNCTION fnzbb RETURNS CHARACTER (x AS INT, m AS INT, a AS INT, s AS INT):
/*------------------------------------------------------------------------------
Purpose: Workflow implemenation for 'zbb'
Notes:   zbb{a>2244:ccg,x>1335:mmf,bh}
------------------------------------------------------------------------------*/
   IF a > 2244 THEN RETURN "ccg".
   IF x > 1335 THEN RETURN "mmf".
   RETURN "bh".
END FUNCTION.

FUNCTION fnss RETURNS CHARACTER (x AS INT, m AS INT, a AS INT, s AS INT):
/*------------------------------------------------------------------------------
Purpose: Workflow implemenation for 'ss'
Notes:   ss{m<3642:A,A}
------------------------------------------------------------------------------*/
   IF m < 3642 THEN RETURN "A".
   RETURN "A".
END FUNCTION.

FUNCTION fnzdd RETURNS CHARACTER (x AS INT, m AS INT, a AS INT, s AS INT):
/*------------------------------------------------------------------------------
Purpose: Workflow implemenation for 'zdd'
Notes:   zdd{m<2602:xt,tdm}
------------------------------------------------------------------------------*/
   IF m < 2602 THEN RETURN "xt".
   RETURN "tdm".
END FUNCTION.

FUNCTION fnzqq RETURNS CHARACTER (x AS INT, m AS INT, a AS INT, s AS INT):
/*------------------------------------------------------------------------------
Purpose: Workflow implemenation for 'zqq'
Notes:   zqq{m>575:R,A}
------------------------------------------------------------------------------*/
   IF m > 575 THEN RETURN "R".
   RETURN "A".
END FUNCTION.

FUNCTION fnzzz RETURNS CHARACTER (x AS INT, m AS INT, a AS INT, s AS INT):
/*------------------------------------------------------------------------------
Purpose: Workflow implemenation for 'zzz'
Notes:   zzz{a>3102:vrv,a<2800:cqj,a<2999:A,bvc}
------------------------------------------------------------------------------*/
   IF a > 3102 THEN RETURN "vrv".
   IF a < 2800 THEN RETURN "cqj".
   IF a < 2999 THEN RETURN "A".
   RETURN "bvc".
END FUNCTION.

FUNCTION fnkfp RETURNS CHARACTER (x AS INT, m AS INT, a AS INT, s AS INT):
/*------------------------------------------------------------------------------
Purpose: Workflow implemenation for 'kfp'
Notes:   kfp{x>515:ml,A}
------------------------------------------------------------------------------*/
   IF x > 515 THEN RETURN "ml".
   RETURN "A".
END FUNCTION.

FUNCTION fndxf RETURNS CHARACTER (x AS INT, m AS INT, a AS INT, s AS INT):
/*------------------------------------------------------------------------------
Purpose: Workflow implemenation for 'dxf'
Notes:   dxf{a>315:R,R}
------------------------------------------------------------------------------*/
   IF a > 315 THEN RETURN "R".
   RETURN "R".
END FUNCTION.

FUNCTION fnvb RETURNS CHARACTER (x AS INT, m AS INT, a AS INT, s AS INT):
/*------------------------------------------------------------------------------
Purpose: Workflow implemenation for 'vb'
Notes:   vb{m>1613:jsd,a>2462:szk,hsz}
------------------------------------------------------------------------------*/
   IF m > 1613 THEN RETURN "jsd".
   IF a > 2462 THEN RETURN "szk".
   RETURN "hsz".
END FUNCTION.

FUNCTION fnlpk RETURNS CHARACTER (x AS INT, m AS INT, a AS INT, s AS INT):
/*------------------------------------------------------------------------------
Purpose: Workflow implemenation for 'lpk'
Notes:   lpk{s>1135:lht,s>989:gg,nnk}
------------------------------------------------------------------------------*/
   IF s > 1135 THEN RETURN "lht".
   IF s > 989 THEN RETURN "gg".
   RETURN "nnk".
END FUNCTION.

FUNCTION fnjtr RETURNS CHARACTER (x AS INT, m AS INT, a AS INT, s AS INT):
/*------------------------------------------------------------------------------
Purpose: Workflow implemenation for 'jtr'
Notes:   jtr{m<1957:A,a<935:R,A}
------------------------------------------------------------------------------*/
   IF m < 1957 THEN RETURN "A".
   IF a < 935 THEN RETURN "R".
   RETURN "A".
END FUNCTION.

FUNCTION fnls RETURNS CHARACTER (x AS INT, m AS INT, a AS INT, s AS INT):
/*------------------------------------------------------------------------------
Purpose: Workflow implemenation for 'ls'
Notes:   ls{x>1788:zg,js}
------------------------------------------------------------------------------*/
   IF x > 1788 THEN RETURN "zg".
   RETURN "js".
END FUNCTION.

FUNCTION fnsd RETURNS CHARACTER (x AS INT, m AS INT, a AS INT, s AS INT):
/*------------------------------------------------------------------------------
Purpose: Workflow implemenation for 'sd'
Notes:   sd{s>376:lxx,ftk}
------------------------------------------------------------------------------*/
   IF s > 376 THEN RETURN "lxx".
   RETURN "ftk".
END FUNCTION.

FUNCTION fnff RETURNS CHARACTER (x AS INT, m AS INT, a AS INT, s AS INT):
/*------------------------------------------------------------------------------
Purpose: Workflow implemenation for 'ff'
Notes:   ff{x>3648:R,a<3816:R,R}
------------------------------------------------------------------------------*/
   IF x > 3648 THEN RETURN "R".
   IF a < 3816 THEN RETURN "R".
   RETURN "R".
END FUNCTION.

FUNCTION fndvk RETURNS CHARACTER (x AS INT, m AS INT, a AS INT, s AS INT):
/*------------------------------------------------------------------------------
Purpose: Workflow implemenation for 'dvk'
Notes:   dvk{m>3204:A,R}
------------------------------------------------------------------------------*/
   IF m > 3204 THEN RETURN "A".
   RETURN "R".
END FUNCTION.

FUNCTION fnnc RETURNS CHARACTER (x AS INT, m AS INT, a AS INT, s AS INT):
/*------------------------------------------------------------------------------
Purpose: Workflow implemenation for 'nc'
Notes:   nc{a<1279:A,x<2499:R,R}
------------------------------------------------------------------------------*/
   IF a < 1279 THEN RETURN "A".
   IF x < 2499 THEN RETURN "R".
   RETURN "R".
END FUNCTION.

FUNCTION fndtq RETURNS CHARACTER (x AS INT, m AS INT, a AS INT, s AS INT):
/*------------------------------------------------------------------------------
Purpose: Workflow implemenation for 'dtq'
Notes:   dtq{x<2009:A,R}
------------------------------------------------------------------------------*/
   IF x < 2009 THEN RETURN "A".
   RETURN "R".
END FUNCTION.

FUNCTION fnrks RETURNS CHARACTER (x AS INT, m AS INT, a AS INT, s AS INT):
/*------------------------------------------------------------------------------
Purpose: Workflow implemenation for 'rks'
Notes:   rks{m<3222:R,R}
------------------------------------------------------------------------------*/
   IF m < 3222 THEN RETURN "R".
   RETURN "R".
END FUNCTION.

FUNCTION fnin RETURNS CHARACTER (x AS INT, m AS INT, a AS INT, s AS INT):
/*------------------------------------------------------------------------------
Purpose: Workflow implemenation for 'in'
Notes:   in{m<2131:cz,mtv}
------------------------------------------------------------------------------*/
   IF m < 2131 THEN RETURN "cz".
   RETURN "mtv".
END FUNCTION.

FUNCTION fnjd RETURNS CHARACTER (x AS INT, m AS INT, a AS INT, s AS INT):
/*------------------------------------------------------------------------------
Purpose: Workflow implemenation for 'jd'
Notes:   jd{s>1478:td,m>1696:df,s<981:vq,vlr}
------------------------------------------------------------------------------*/
   IF s > 1478 THEN RETURN "td".
   IF m > 1696 THEN RETURN "df".
   IF s < 981 THEN RETURN "vq".
   RETURN "vlr".
END FUNCTION.

FUNCTION fnct RETURNS CHARACTER (x AS INT, m AS INT, a AS INT, s AS INT):
/*------------------------------------------------------------------------------
Purpose: Workflow implemenation for 'ct'
Notes:   ct{a>879:xv,m>3005:A,nv}
------------------------------------------------------------------------------*/
   IF a > 879 THEN RETURN "xv".
   IF m > 3005 THEN RETURN "A".
   RETURN "nv".
END FUNCTION.

FUNCTION fnlt RETURNS CHARACTER (x AS INT, m AS INT, a AS INT, s AS INT):
/*------------------------------------------------------------------------------
Purpose: Workflow implemenation for 'lt'
Notes:   lt{s>1942:zf,R}
------------------------------------------------------------------------------*/
   IF s > 1942 THEN RETURN "zf".
   RETURN "R".
END FUNCTION.

FUNCTION fnzfj RETURNS CHARACTER (x AS INT, m AS INT, a AS INT, s AS INT):
/*------------------------------------------------------------------------------
Purpose: Workflow implemenation for 'zfj'
Notes:   zfj{a<1034:zkj,rhg}
------------------------------------------------------------------------------*/
   IF a < 1034 THEN RETURN "zkj".
   RETURN "rhg".
END FUNCTION.

FUNCTION fndfc RETURNS CHARACTER (x AS INT, m AS INT, a AS INT, s AS INT):
/*------------------------------------------------------------------------------
Purpose: Workflow implemenation for 'dfc'
Notes:   dfc{m>1352:R,a>2004:R,x<3229:R,A}
------------------------------------------------------------------------------*/
   IF m > 1352 THEN RETURN "R".
   IF a > 2004 THEN RETURN "R".
   IF x < 3229 THEN RETURN "R".
   RETURN "A".
END FUNCTION.

FUNCTION fnvrx RETURNS CHARACTER (x AS INT, m AS INT, a AS INT, s AS INT):
/*------------------------------------------------------------------------------
Purpose: Workflow implemenation for 'vrx'
Notes:   vrx{m<3175:xxm,R}
------------------------------------------------------------------------------*/
   IF m < 3175 THEN RETURN "xxm".
   RETURN "R".
END FUNCTION.

FUNCTION fnngs RETURNS CHARACTER (x AS INT, m AS INT, a AS INT, s AS INT):
/*------------------------------------------------------------------------------
Purpose: Workflow implemenation for 'ngs'
Notes:   ngs{a<867:lrj,x>3362:nj,qd}
------------------------------------------------------------------------------*/
   IF a < 867 THEN RETURN "lrj".
   IF x > 3362 THEN RETURN "nj".
   RETURN "qd".
END FUNCTION.

FUNCTION fnszg RETURNS CHARACTER (x AS INT, m AS INT, a AS INT, s AS INT):
/*------------------------------------------------------------------------------
Purpose: Workflow implemenation for 'szg'
Notes:   szg{a>2781:A,m<3156:R,a<2714:R,R}
------------------------------------------------------------------------------*/
   IF a > 2781 THEN RETURN "A".
   IF m < 3156 THEN RETURN "R".
   IF a < 2714 THEN RETURN "R".
   RETURN "R".
END FUNCTION.

FUNCTION fnxg RETURNS CHARACTER (x AS INT, m AS INT, a AS INT, s AS INT):
/*------------------------------------------------------------------------------
Purpose: Workflow implemenation for 'xg'
Notes:   xg{m<2460:R,R}
------------------------------------------------------------------------------*/
   IF m < 2460 THEN RETURN "R".
   RETURN "R".
END FUNCTION.

FUNCTION fnhh RETURNS CHARACTER (x AS INT, m AS INT, a AS INT, s AS INT):
/*------------------------------------------------------------------------------
Purpose: Workflow implemenation for 'hh'
Notes:   hh{x>2365:R,A}
------------------------------------------------------------------------------*/
   IF x > 2365 THEN RETURN "R".
   RETURN "A".
END FUNCTION.

FUNCTION fnkg RETURNS CHARACTER (x AS INT, m AS INT, a AS INT, s AS INT):
/*------------------------------------------------------------------------------
Purpose: Workflow implemenation for 'kg'
Notes:   kg{m<614:tq,a<1245:R,x>2659:bxp,R}
------------------------------------------------------------------------------*/
   IF m < 614 THEN RETURN "tq".
   IF a < 1245 THEN RETURN "R".
   IF x > 2659 THEN RETURN "bxp".
   RETURN "R".
END FUNCTION.

FUNCTION fnht RETURNS CHARACTER (x AS INT, m AS INT, a AS INT, s AS INT):
/*------------------------------------------------------------------------------
Purpose: Workflow implemenation for 'ht'
Notes:   ht{s<3063:R,x<1179:A,R}
------------------------------------------------------------------------------*/
   IF s < 3063 THEN RETURN "R".
   IF x < 1179 THEN RETURN "A".
   RETURN "R".
END FUNCTION.

FUNCTION fngv RETURNS CHARACTER (x AS INT, m AS INT, a AS INT, s AS INT):
/*------------------------------------------------------------------------------
Purpose: Workflow implemenation for 'gv'
Notes:   gv{x<2021:R,R}
------------------------------------------------------------------------------*/
   IF x < 2021 THEN RETURN "R".
   RETURN "R".
END FUNCTION.

FUNCTION fnmqd RETURNS CHARACTER (x AS INT, m AS INT, a AS INT, s AS INT):
/*------------------------------------------------------------------------------
Purpose: Workflow implemenation for 'mqd'
Notes:   mqd{m<718:A,s<2597:R,qxn}
------------------------------------------------------------------------------*/
   IF m < 718 THEN RETURN "A".
   IF s < 2597 THEN RETURN "R".
   RETURN "qxn".
END FUNCTION.

FUNCTION fnjng RETURNS CHARACTER (x AS INT, m AS INT, a AS INT, s AS INT):
/*------------------------------------------------------------------------------
Purpose: Workflow implemenation for 'jng'
Notes:   jng{m>1474:A,R}
------------------------------------------------------------------------------*/
   IF m > 1474 THEN RETURN "A".
   RETURN "R".
END FUNCTION.

FUNCTION fnhzf RETURNS CHARACTER (x AS INT, m AS INT, a AS INT, s AS INT):
/*------------------------------------------------------------------------------
Purpose: Workflow implemenation for 'hzf'
Notes:   hzf{m>655:A,A}
------------------------------------------------------------------------------*/
   IF m > 655 THEN RETURN "A".
   RETURN "A".
END FUNCTION.

FUNCTION fntdc RETURNS CHARACTER (x AS INT, m AS INT, a AS INT, s AS INT):
/*------------------------------------------------------------------------------
Purpose: Workflow implemenation for 'tdc'
Notes:   tdc{x<221:A,m>2804:R,A}
------------------------------------------------------------------------------*/
   IF x < 221 THEN RETURN "A".
   IF m > 2804 THEN RETURN "R".
   RETURN "A".
END FUNCTION.

FUNCTION fntpx RETURNS CHARACTER (x AS INT, m AS INT, a AS INT, s AS INT):
/*------------------------------------------------------------------------------
Purpose: Workflow implemenation for 'tpx'
Notes:   tpx{x<1414:ch,a<816:szq,fzv}
------------------------------------------------------------------------------*/
   IF x < 1414 THEN RETURN "ch".
   IF a < 816 THEN RETURN "szq".
   RETURN "fzv".
END FUNCTION.

FUNCTION fnvxm RETURNS CHARACTER (x AS INT, m AS INT, a AS INT, s AS INT):
/*------------------------------------------------------------------------------
Purpose: Workflow implemenation for 'vxm'
Notes:   vxm{s<304:R,x<383:tdc,m<2773:mdb,A}
------------------------------------------------------------------------------*/
   IF s < 304 THEN RETURN "R".
   IF x < 383 THEN RETURN "tdc".
   IF m < 2773 THEN RETURN "mdb".
   RETURN "A".
END FUNCTION.

FUNCTION fndxs RETURNS CHARACTER (x AS INT, m AS INT, a AS INT, s AS INT):
/*------------------------------------------------------------------------------
Purpose: Workflow implemenation for 'dxs'
Notes:   dxs{x<2545:jcn,s<100:xg,s<153:A,jmj}
------------------------------------------------------------------------------*/
   IF x < 2545 THEN RETURN "jcn".
   IF s < 100 THEN RETURN "xg".
   IF s < 153 THEN RETURN "A".
   RETURN "jmj".
END FUNCTION.

FUNCTION fngbb RETURNS CHARACTER (x AS INT, m AS INT, a AS INT, s AS INT):
/*------------------------------------------------------------------------------
Purpose: Workflow implemenation for 'gbb'
Notes:   gbb{x<2907:mvc,m<543:xf,x>3553:gqh,hjt}
------------------------------------------------------------------------------*/
   IF x < 2907 THEN RETURN "mvc".
   IF m < 543 THEN RETURN "xf".
   IF x > 3553 THEN RETURN "gqh".
   RETURN "hjt".
END FUNCTION.

FUNCTION fnvg RETURNS CHARACTER (x AS INT, m AS INT, a AS INT, s AS INT):
/*------------------------------------------------------------------------------
Purpose: Workflow implemenation for 'vg'
Notes:   vg{s<356:A,m<2800:A,A}
------------------------------------------------------------------------------*/
   IF s < 356 THEN RETURN "A".
   IF m < 2800 THEN RETURN "A".
   RETURN "A".
END FUNCTION.

FUNCTION fntkq RETURNS CHARACTER (x AS INT, m AS INT, a AS INT, s AS INT):
/*------------------------------------------------------------------------------
Purpose: Workflow implemenation for 'tkq'
Notes:   tkq{m>3809:A,s<1316:R,x>1546:R,R}
------------------------------------------------------------------------------*/
   IF m > 3809 THEN RETURN "A".
   IF s < 1316 THEN RETURN "R".
   IF x > 1546 THEN RETURN "R".
   RETURN "R".
END FUNCTION.

FUNCTION fnzhp RETURNS CHARACTER (x AS INT, m AS INT, a AS INT, s AS INT):
/*------------------------------------------------------------------------------
Purpose: Workflow implemenation for 'zhp'
Notes:   zhp{m<1606:A,a>167:A,m<1712:A,R}
------------------------------------------------------------------------------*/
   IF m < 1606 THEN RETURN "A".
   IF a > 167 THEN RETURN "A".
   IF m < 1712 THEN RETURN "A".
   RETURN "R".
END FUNCTION.

FUNCTION fnzj RETURNS CHARACTER (x AS INT, m AS INT, a AS INT, s AS INT):
/*------------------------------------------------------------------------------
Purpose: Workflow implemenation for 'zj'
Notes:   zj{a<3026:A,s>2915:A,R}
------------------------------------------------------------------------------*/
   IF a < 3026 THEN RETURN "A".
   IF s > 2915 THEN RETURN "A".
   RETURN "R".
END FUNCTION.

FUNCTION fnrkl RETURNS CHARACTER (x AS INT, m AS INT, a AS INT, s AS INT):
/*------------------------------------------------------------------------------
Purpose: Workflow implemenation for 'rkl'
Notes:   rkl{m>3409:R,A}
------------------------------------------------------------------------------*/
   IF m > 3409 THEN RETURN "R".
   RETURN "A".
END FUNCTION.

FUNCTION fnrj RETURNS CHARACTER (x AS INT, m AS INT, a AS INT, s AS INT):
/*------------------------------------------------------------------------------
Purpose: Workflow implemenation for 'rj'
Notes:   rj{s>1336:A,R}
------------------------------------------------------------------------------*/
   IF s > 1336 THEN RETURN "A".
   RETURN "R".
END FUNCTION.

FUNCTION fnskz RETURNS CHARACTER (x AS INT, m AS INT, a AS INT, s AS INT):
/*------------------------------------------------------------------------------
Purpose: Workflow implemenation for 'skz'
Notes:   skz{s<1142:vgz,m>3577:R,m<3533:nc,qk}
------------------------------------------------------------------------------*/
   IF s < 1142 THEN RETURN "vgz".
   IF m > 3577 THEN RETURN "R".
   IF m < 3533 THEN RETURN "nc".
   RETURN "qk".
END FUNCTION.

FUNCTION fnbf RETURNS CHARACTER (x AS INT, m AS INT, a AS INT, s AS INT):
/*------------------------------------------------------------------------------
Purpose: Workflow implemenation for 'bf'
Notes:   bf{m>2781:zz,a>3752:A,a<3606:fdb,R}
------------------------------------------------------------------------------*/
   IF m > 2781 THEN RETURN "zz".
   IF a > 3752 THEN RETURN "A".
   IF a < 3606 THEN RETURN "fdb".
   RETURN "R".
END FUNCTION.

FUNCTION fnzs RETURNS CHARACTER (x AS INT, m AS INT, a AS INT, s AS INT):
/*------------------------------------------------------------------------------
Purpose: Workflow implemenation for 'zs'
Notes:   zs{a<2108:R,a<2506:R,tx}
------------------------------------------------------------------------------*/
   IF a < 2108 THEN RETURN "R".
   IF a < 2506 THEN RETURN "R".
   RETURN "tx".
END FUNCTION.

FUNCTION fndj RETURNS CHARACTER (x AS INT, m AS INT, a AS INT, s AS INT):
/*------------------------------------------------------------------------------
Purpose: Workflow implemenation for 'dj'
Notes:   dj{s>1374:pzt,m>3269:bqk,s<1274:cl,sdn}
------------------------------------------------------------------------------*/
   IF s > 1374 THEN RETURN "pzt".
   IF m > 3269 THEN RETURN "bqk".
   IF s < 1274 THEN RETURN "cl".
   RETURN "sdn".
END FUNCTION.

FUNCTION fndk RETURNS CHARACTER (x AS INT, m AS INT, a AS INT, s AS INT):
/*------------------------------------------------------------------------------
Purpose: Workflow implemenation for 'dk'
Notes:   dk{m>2966:R,s<971:R,m<2476:R,A}
------------------------------------------------------------------------------*/
   IF m > 2966 THEN RETURN "R".
   IF s < 971 THEN RETURN "R".
   IF m < 2476 THEN RETURN "R".
   RETURN "A".
END FUNCTION.

FUNCTION fnkdn RETURNS CHARACTER (x AS INT, m AS INT, a AS INT, s AS INT):
/*------------------------------------------------------------------------------
Purpose: Workflow implemenation for 'kdn'
Notes:   kdn{a<435:R,s<659:R,A}
------------------------------------------------------------------------------*/
   IF a < 435 THEN RETURN "R".
   IF s < 659 THEN RETURN "R".
   RETURN "A".
END FUNCTION.

FUNCTION fntv RETURNS CHARACTER (x AS INT, m AS INT, a AS INT, s AS INT):
/*------------------------------------------------------------------------------
Purpose: Workflow implemenation for 'tv'
Notes:   tv{a>1679:vsd,m<3686:R,x<2729:R,A}
------------------------------------------------------------------------------*/
   IF a > 1679 THEN RETURN "vsd".
   IF m < 3686 THEN RETURN "R".
   IF x < 2729 THEN RETURN "R".
   RETURN "A".
END FUNCTION.

FUNCTION fnnfx RETURNS CHARACTER (x AS INT, m AS INT, a AS INT, s AS INT):
/*------------------------------------------------------------------------------
Purpose: Workflow implemenation for 'nfx'
Notes:   nfx{s<3034:A,x>3884:A,A}
------------------------------------------------------------------------------*/
   IF s < 3034 THEN RETURN "A".
   IF x > 3884 THEN RETURN "A".
   RETURN "A".
END FUNCTION.

FUNCTION fnknx RETURNS CHARACTER (x AS INT, m AS INT, a AS INT, s AS INT):
/*------------------------------------------------------------------------------
Purpose: Workflow implemenation for 'knx'
Notes:   knx{x>816:R,x<702:A,R}
------------------------------------------------------------------------------*/
   IF x > 816 THEN RETURN "R".
   IF x < 702 THEN RETURN "A".
   RETURN "R".
END FUNCTION.

FUNCTION fnrc RETURNS CHARACTER (x AS INT, m AS INT, a AS INT, s AS INT):
/*------------------------------------------------------------------------------
Purpose: Workflow implemenation for 'rc'
Notes:   rc{x<1712:fnm,tqz}
------------------------------------------------------------------------------*/
   IF x < 1712 THEN RETURN "fnm".
   RETURN "tqz".
END FUNCTION.

FUNCTION fnjbr RETURNS CHARACTER (x AS INT, m AS INT, a AS INT, s AS INT):
/*------------------------------------------------------------------------------
Purpose: Workflow implemenation for 'jbr'
Notes:   jbr{a<852:A,R}
------------------------------------------------------------------------------*/
   IF a < 852 THEN RETURN "A".
   RETURN "R".
END FUNCTION.

FUNCTION fncgb RETURNS CHARACTER (x AS INT, m AS INT, a AS INT, s AS INT):
/*------------------------------------------------------------------------------
Purpose: Workflow implemenation for 'cgb'
Notes:   cgb{a<789:A,s<1835:A,m>3623:rt,A}
------------------------------------------------------------------------------*/
   IF a < 789 THEN RETURN "A".
   IF s < 1835 THEN RETURN "A".
   IF m > 3623 THEN RETURN "rt".
   RETURN "A".
END FUNCTION.

FUNCTION fnxqk RETURNS CHARACTER (x AS INT, m AS INT, a AS INT, s AS INT):
/*------------------------------------------------------------------------------
Purpose: Workflow implemenation for 'xqk'
Notes:   xqk{a<1905:R,a>2223:A,a>2093:A,A}
------------------------------------------------------------------------------*/
   IF a < 1905 THEN RETURN "R".
   IF a > 2223 THEN RETURN "A".
   IF a > 2093 THEN RETURN "A".
   RETURN "A".
END FUNCTION.

FUNCTION fnrrk RETURNS CHARACTER (x AS INT, m AS INT, a AS INT, s AS INT):
/*------------------------------------------------------------------------------
Purpose: Workflow implemenation for 'rrk'
Notes:   rrk{s>719:rld,a<1094:cbs,qlv}
------------------------------------------------------------------------------*/
   IF s > 719 THEN RETURN "rld".
   IF a < 1094 THEN RETURN "cbs".
   RETURN "qlv".
END FUNCTION.

FUNCTION fnbvg RETURNS CHARACTER (x AS INT, m AS INT, a AS INT, s AS INT):
/*------------------------------------------------------------------------------
Purpose: Workflow implemenation for 'bvg'
Notes:   bvg{m<2397:R,R}
------------------------------------------------------------------------------*/
   IF m < 2397 THEN RETURN "R".
   RETURN "R".
END FUNCTION.

FUNCTION fnzb RETURNS CHARACTER (x AS INT, m AS INT, a AS INT, s AS INT):
/*------------------------------------------------------------------------------
Purpose: Workflow implemenation for 'zb'
Notes:   zb{x<3060:R,a<430:qr,csg}
------------------------------------------------------------------------------*/
   IF x < 3060 THEN RETURN "R".
   IF a < 430 THEN RETURN "qr".
   RETURN "csg".
END FUNCTION.

FUNCTION fnvd RETURNS CHARACTER (x AS INT, m AS INT, a AS INT, s AS INT):
/*------------------------------------------------------------------------------
Purpose: Workflow implemenation for 'vd'
Notes:   vd{x>278:A,R}
------------------------------------------------------------------------------*/
   IF x > 278 THEN RETURN "A".
   RETURN "R".
END FUNCTION.

FUNCTION fnqkc RETURNS CHARACTER (x AS INT, m AS INT, a AS INT, s AS INT):
/*------------------------------------------------------------------------------
Purpose: Workflow implemenation for 'qkc'
Notes:   qkc{a<3268:lzc,R}
------------------------------------------------------------------------------*/
   IF a < 3268 THEN RETURN "lzc".
   RETURN "R".
END FUNCTION.

FUNCTION fnhsz RETURNS CHARACTER (x AS INT, m AS INT, a AS INT, s AS INT):
/*------------------------------------------------------------------------------
Purpose: Workflow implemenation for 'hsz'
Notes:   hsz{m<1538:A,s<813:A,A}
------------------------------------------------------------------------------*/
   IF m < 1538 THEN RETURN "A".
   IF s < 813 THEN RETURN "A".
   RETURN "A".
END FUNCTION.

FUNCTION fnfg RETURNS CHARACTER (x AS INT, m AS INT, a AS INT, s AS INT):
/*------------------------------------------------------------------------------
Purpose: Workflow implemenation for 'fg'
Notes:   fg{s>3518:R,a<3152:A,A}
------------------------------------------------------------------------------*/
   IF s > 3518 THEN RETURN "R".
   IF a < 3152 THEN RETURN "A".
   RETURN "A".
END FUNCTION.

FUNCTION fnzf RETURNS CHARACTER (x AS INT, m AS INT, a AS INT, s AS INT):
/*------------------------------------------------------------------------------
Purpose: Workflow implemenation for 'zf'
Notes:   zf{a<2679:A,x>922:R,A}
------------------------------------------------------------------------------*/
   IF a < 2679 THEN RETURN "A".
   IF x > 922 THEN RETURN "R".
   RETURN "A".
END FUNCTION.

FUNCTION fnnfr RETURNS CHARACTER (x AS INT, m AS INT, a AS INT, s AS INT):
/*------------------------------------------------------------------------------
Purpose: Workflow implemenation for 'nfr'
Notes:   nfr{s<786:zn,s>828:qvz,zb}
------------------------------------------------------------------------------*/
   IF s < 786 THEN RETURN "zn".
   IF s > 828 THEN RETURN "qvz".
   RETURN "zb".
END FUNCTION.

FUNCTION fnlsq RETURNS CHARACTER (x AS INT, m AS INT, a AS INT, s AS INT):
/*------------------------------------------------------------------------------
Purpose: Workflow implemenation for 'lsq'
Notes:   lsq{s<2128:R,x<1564:A,R}
------------------------------------------------------------------------------*/
   IF s < 2128 THEN RETURN "R".
   IF x < 1564 THEN RETURN "A".
   RETURN "R".
END FUNCTION.

FUNCTION fnvlr RETURNS CHARACTER (x AS INT, m AS INT, a AS INT, s AS INT):
/*------------------------------------------------------------------------------
Purpose: Workflow implemenation for 'vlr'
Notes:   vlr{m>1602:kzv,s<1153:mqt,fvn}
------------------------------------------------------------------------------*/
   IF m > 1602 THEN RETURN "kzv".
   IF s < 1153 THEN RETURN "mqt".
   RETURN "fvn".
END FUNCTION.

FUNCTION fnpzt RETURNS CHARACTER (x AS INT, m AS INT, a AS INT, s AS INT):
/*------------------------------------------------------------------------------
Purpose: Workflow implemenation for 'pzt'
Notes:   pzt{a<1316:hgj,x>2214:cc,ttj}
------------------------------------------------------------------------------*/
   IF a < 1316 THEN RETURN "hgj".
   IF x > 2214 THEN RETURN "cc".
   RETURN "ttj".
END FUNCTION.

FUNCTION fnfxd RETURNS CHARACTER (x AS INT, m AS INT, a AS INT, s AS INT):
/*------------------------------------------------------------------------------
Purpose: Workflow implemenation for 'fxd'
Notes:   fxd{a>391:R,a>191:R,s<2888:A,A}
------------------------------------------------------------------------------*/
   IF a > 391 THEN RETURN "R".
   IF a > 191 THEN RETURN "R".
   IF s < 2888 THEN RETURN "A".
   RETURN "A".
END FUNCTION.

FUNCTION fnnt RETURNS CHARACTER (x AS INT, m AS INT, a AS INT, s AS INT):
/*------------------------------------------------------------------------------
Purpose: Workflow implemenation for 'nt'
Notes:   nt{s>446:R,x<2086:A,A}
------------------------------------------------------------------------------*/
   IF s > 446 THEN RETURN "R".
   IF x < 2086 THEN RETURN "A".
   RETURN "A".
END FUNCTION.

FUNCTION fnbts RETURNS CHARACTER (x AS INT, m AS INT, a AS INT, s AS INT):
/*------------------------------------------------------------------------------
Purpose: Workflow implemenation for 'bts'
Notes:   bts{a>638:R,A}
------------------------------------------------------------------------------*/
   IF a > 638 THEN RETURN "R".
   RETURN "A".
END FUNCTION.

FUNCTION fnlmt RETURNS CHARACTER (x AS INT, m AS INT, a AS INT, s AS INT):
/*------------------------------------------------------------------------------
Purpose: Workflow implemenation for 'lmt'
Notes:   lmt{a<2621:tt,a<3304:cx,fhj}
------------------------------------------------------------------------------*/
   IF a < 2621 THEN RETURN "tt".
   IF a < 3304 THEN RETURN "cx".
   RETURN "fhj".
END FUNCTION.

FUNCTION fnds RETURNS CHARACTER (x AS INT, m AS INT, a AS INT, s AS INT):
/*------------------------------------------------------------------------------
Purpose: Workflow implemenation for 'ds'
Notes:   ds{x<646:A,A}
------------------------------------------------------------------------------*/
   IF x < 646 THEN RETURN "A".
   RETURN "A".
END FUNCTION.

FUNCTION fnmpg RETURNS CHARACTER (x AS INT, m AS INT, a AS INT, s AS INT):
/*------------------------------------------------------------------------------
Purpose: Workflow implemenation for 'mpg'
Notes:   mpg{m<1752:A,A}
------------------------------------------------------------------------------*/
   IF m < 1752 THEN RETURN "A".
   RETURN "A".
END FUNCTION.

FUNCTION fntz RETURNS CHARACTER (x AS INT, m AS INT, a AS INT, s AS INT):
/*------------------------------------------------------------------------------
Purpose: Workflow implemenation for 'tz'
Notes:   tz{s<2648:A,a>3313:A,s<3179:A,A}
------------------------------------------------------------------------------*/
   IF s < 2648 THEN RETURN "A".
   IF a > 3313 THEN RETURN "A".
   IF s < 3179 THEN RETURN "A".
   RETURN "A".
END FUNCTION.

FUNCTION fnbrk RETURNS CHARACTER (x AS INT, m AS INT, a AS INT, s AS INT):
/*------------------------------------------------------------------------------
Purpose: Workflow implemenation for 'brk'
Notes:   brk{a<277:A,a>456:R,A}
------------------------------------------------------------------------------*/
   IF a < 277 THEN RETURN "A".
   IF a > 456 THEN RETURN "R".
   RETURN "A".
END FUNCTION.

FUNCTION fndc RETURNS CHARACTER (x AS INT, m AS INT, a AS INT, s AS INT):
/*------------------------------------------------------------------------------
Purpose: Workflow implemenation for 'dc'
Notes:   dc{m>3795:R,a>1285:cqc,m<3754:skh,A}
------------------------------------------------------------------------------*/
   IF m > 3795 THEN RETURN "R".
   IF a > 1285 THEN RETURN "cqc".
   IF m < 3754 THEN RETURN "skh".
   RETURN "A".
END FUNCTION.

FUNCTION fnrgq RETURNS CHARACTER (x AS INT, m AS INT, a AS INT, s AS INT):
/*------------------------------------------------------------------------------
Purpose: Workflow implemenation for 'rgq'
Notes:   rgq{a>637:A,x>2228:R,R}
------------------------------------------------------------------------------*/
   IF a > 637 THEN RETURN "A".
   IF x > 2228 THEN RETURN "R".
   RETURN "R".
END FUNCTION.

FUNCTION fnlht RETURNS CHARACTER (x AS INT, m AS INT, a AS INT, s AS INT):
/*------------------------------------------------------------------------------
Purpose: Workflow implemenation for 'lht'
Notes:   lht{a>3119:A,s>1330:A,R}
------------------------------------------------------------------------------*/
   IF a > 3119 THEN RETURN "A".
   IF s > 1330 THEN RETURN "A".
   RETURN "R".
END FUNCTION.

FUNCTION fnmvc RETURNS CHARACTER (x AS INT, m AS INT, a AS INT, s AS INT):
/*------------------------------------------------------------------------------
Purpose: Workflow implemenation for 'mvc'
Notes:   mvc{a<2677:sg,fl}
------------------------------------------------------------------------------*/
   IF a < 2677 THEN RETURN "sg".
   RETURN "fl".
END FUNCTION.

FUNCTION fncng RETURNS CHARACTER (x AS INT, m AS INT, a AS INT, s AS INT):
/*------------------------------------------------------------------------------
Purpose: Workflow implemenation for 'cng'
Notes:   cng{x>2909:tc,s<113:kpq,s>224:fz,zfj}
------------------------------------------------------------------------------*/
   IF x > 2909 THEN RETURN "tc".
   IF s < 113 THEN RETURN "kpq".
   IF s > 224 THEN RETURN "fz".
   RETURN "zfj".
END FUNCTION.

FUNCTION fnqbb RETURNS CHARACTER (x AS INT, m AS INT, a AS INT, s AS INT):
/*------------------------------------------------------------------------------
Purpose: Workflow implemenation for 'qbb'
Notes:   qbb{s<3159:hz,s<3283:krp,msx}
------------------------------------------------------------------------------*/
   IF s < 3159 THEN RETURN "hz".
   IF s < 3283 THEN RETURN "krp".
   RETURN "msx".
END FUNCTION.

FUNCTION fnlrj RETURNS CHARACTER (x AS INT, m AS INT, a AS INT, s AS INT):
/*------------------------------------------------------------------------------
Purpose: Workflow implemenation for 'lrj'
Notes:   lrj{x>3540:A,m<2947:fq,A}
------------------------------------------------------------------------------*/
   IF x > 3540 THEN RETURN "A".
   IF m < 2947 THEN RETURN "fq".
   RETURN "A".
END FUNCTION.

FUNCTION fnjcn RETURNS CHARACTER (x AS INT, m AS INT, a AS INT, s AS INT):
/*------------------------------------------------------------------------------
Purpose: Workflow implemenation for 'jcn'
Notes:   jcn{x>1192:A,m>2569:R,A}
------------------------------------------------------------------------------*/
   IF x > 1192 THEN RETURN "A".
   IF m > 2569 THEN RETURN "R".
   RETURN "A".
END FUNCTION.

FUNCTION fnfcd RETURNS CHARACTER (x AS INT, m AS INT, a AS INT, s AS INT):
/*------------------------------------------------------------------------------
Purpose: Workflow implemenation for 'fcd'
Notes:   fcd{m<948:A,x<1316:ht,qch}
------------------------------------------------------------------------------*/
   IF m < 948 THEN RETURN "A".
   IF x < 1316 THEN RETURN "ht".
   RETURN "qch".
END FUNCTION.

FUNCTION fnqvz RETURNS CHARACTER (x AS INT, m AS INT, a AS INT, s AS INT):
/*------------------------------------------------------------------------------
Purpose: Workflow implemenation for 'qvz'
Notes:   qvz{m>3696:kxg,a<538:R,tr}
------------------------------------------------------------------------------*/
   IF m > 3696 THEN RETURN "kxg".
   IF a < 538 THEN RETURN "R".
   RETURN "tr".
END FUNCTION.

FUNCTION fnmh RETURNS CHARACTER (x AS INT, m AS INT, a AS INT, s AS INT):
/*------------------------------------------------------------------------------
Purpose: Workflow implemenation for 'mh'
Notes:   mh{m<3314:grd,s<712:R,x<1541:A,cvm}
------------------------------------------------------------------------------*/
   IF m < 3314 THEN RETURN "grd".
   IF s < 712 THEN RETURN "R".
   IF x < 1541 THEN RETURN "A".
   RETURN "cvm".
END FUNCTION.

FUNCTION fngbz RETURNS CHARACTER (x AS INT, m AS INT, a AS INT, s AS INT):
/*------------------------------------------------------------------------------
Purpose: Workflow implemenation for 'gbz'
Notes:   gbz{a<622:R,A}
------------------------------------------------------------------------------*/
   IF a < 622 THEN RETURN "R".
   RETURN "A".
END FUNCTION.

FUNCTION fnntq RETURNS CHARACTER (x AS INT, m AS INT, a AS INT, s AS INT):
/*------------------------------------------------------------------------------
Purpose: Workflow implemenation for 'ntq'
Notes:   ntq{s>250:A,m>3001:R,x<845:A,R}
------------------------------------------------------------------------------*/
   IF s > 250 THEN RETURN "A".
   IF m > 3001 THEN RETURN "R".
   IF x < 845 THEN RETURN "A".
   RETURN "R".
END FUNCTION.

FUNCTION fnqr RETURNS CHARACTER (x AS INT, m AS INT, a AS INT, s AS INT):
/*------------------------------------------------------------------------------
Purpose: Workflow implemenation for 'qr'
Notes:   qr{s<813:R,R}
------------------------------------------------------------------------------*/
   IF s < 813 THEN RETURN "R".
   RETURN "R".
END FUNCTION.

FUNCTION fnrl RETURNS CHARACTER (x AS INT, m AS INT, a AS INT, s AS INT):
/*------------------------------------------------------------------------------
Purpose: Workflow implemenation for 'rl'
Notes:   rl{x>2198:A,x>2022:A,R}
------------------------------------------------------------------------------*/
   IF x > 2198 THEN RETURN "A".
   IF x > 2022 THEN RETURN "A".
   RETURN "R".
END FUNCTION.

FUNCTION fncs RETURNS CHARACTER (x AS INT, m AS INT, a AS INT, s AS INT):
/*------------------------------------------------------------------------------
Purpose: Workflow implemenation for 'cs'
Notes:   cs{a<815:A,s>2641:A,m<1444:A,R}
------------------------------------------------------------------------------*/
   IF a < 815 THEN RETURN "A".
   IF s > 2641 THEN RETURN "A".
   IF m < 1444 THEN RETURN "A".
   RETURN "R".
END FUNCTION.

FUNCTION fnjqx RETURNS CHARACTER (x AS INT, m AS INT, a AS INT, s AS INT):
/*------------------------------------------------------------------------------
Purpose: Workflow implemenation for 'jqx'
Notes:   jqx{a<941:A,a>1538:hrt,A}
------------------------------------------------------------------------------*/
   IF a < 941 THEN RETURN "A".
   IF a > 1538 THEN RETURN "hrt".
   RETURN "A".
END FUNCTION.

FUNCTION fnvx RETURNS CHARACTER (x AS INT, m AS INT, a AS INT, s AS INT):
/*------------------------------------------------------------------------------
Purpose: Workflow implemenation for 'vx'
Notes:   vx{m<2417:R,x>3122:R,A}
------------------------------------------------------------------------------*/
   IF m < 2417 THEN RETURN "R".
   IF x > 3122 THEN RETURN "R".
   RETURN "A".
END FUNCTION.

FUNCTION fngt RETURNS CHARACTER (x AS INT, m AS INT, a AS INT, s AS INT):
/*------------------------------------------------------------------------------
Purpose: Workflow implemenation for 'gt'
Notes:   gt{s>2144:bqr,a>368:A,x<2059:zhp,A}
------------------------------------------------------------------------------*/
   IF s > 2144 THEN RETURN "bqr".
   IF a > 368 THEN RETURN "A".
   IF x < 2059 THEN RETURN "zhp".
   RETURN "A".
END FUNCTION.

FUNCTION fnmdq RETURNS CHARACTER (x AS INT, m AS INT, a AS INT, s AS INT):
/*------------------------------------------------------------------------------
Purpose: Workflow implemenation for 'mdq'
Notes:   mdq{x<1604:R,x>2419:R,s<1260:R,A}
------------------------------------------------------------------------------*/
   IF x < 1604 THEN RETURN "R".
   IF x > 2419 THEN RETURN "R".
   IF s < 1260 THEN RETURN "R".
   RETURN "A".
END FUNCTION.

FUNCTION fngzc RETURNS CHARACTER (x AS INT, m AS INT, a AS INT, s AS INT):
/*------------------------------------------------------------------------------
Purpose: Workflow implemenation for 'gzc'
Notes:   gzc{m>604:hzf,zqq}
------------------------------------------------------------------------------*/
   IF m > 604 THEN RETURN "hzf".
   RETURN "zqq".
END FUNCTION.

FUNCTION fnkpq RETURNS CHARACTER (x AS INT, m AS INT, a AS INT, s AS INT):
/*------------------------------------------------------------------------------
Purpose: Workflow implemenation for 'kpq'
Notes:   kpq{x<2542:bb,x>2734:nxl,a>928:R,ghk}
------------------------------------------------------------------------------*/
   IF x < 2542 THEN RETURN "bb".
   IF x > 2734 THEN RETURN "nxl".
   IF a > 928 THEN RETURN "R".
   RETURN "ghk".
END FUNCTION.

FUNCTION fntvm RETURNS CHARACTER (x AS INT, m AS INT, a AS INT, s AS INT):
/*------------------------------------------------------------------------------
Purpose: Workflow implemenation for 'tvm'
Notes:   tvm{s>36:R,a<694:R,m<3038:R,R}
------------------------------------------------------------------------------*/
   IF s > 36 THEN RETURN "R".
   IF a < 694 THEN RETURN "R".
   IF m < 3038 THEN RETURN "R".
   RETURN "R".
END FUNCTION.

FUNCTION fncqc RETURNS CHARACTER (x AS INT, m AS INT, a AS INT, s AS INT):
/*------------------------------------------------------------------------------
Purpose: Workflow implemenation for 'cqc'
Notes:   cqc{m>3736:R,a>1421:A,A}
------------------------------------------------------------------------------*/
   IF m > 3736 THEN RETURN "R".
   IF a > 1421 THEN RETURN "A".
   RETURN "A".
END FUNCTION.

FUNCTION fncx RETURNS CHARACTER (x AS INT, m AS INT, a AS INT, s AS INT):
/*------------------------------------------------------------------------------
Purpose: Workflow implemenation for 'cx'
Notes:   cx{x>2986:R,A}
------------------------------------------------------------------------------*/
   IF x > 2986 THEN RETURN "R".
   RETURN "A".
END FUNCTION.

FUNCTION fnnxl RETURNS CHARACTER (x AS INT, m AS INT, a AS INT, s AS INT):
/*------------------------------------------------------------------------------
Purpose: Workflow implemenation for 'nxl'
Notes:   nxl{m>2336:R,a>1436:R,R}
------------------------------------------------------------------------------*/
   IF m > 2336 THEN RETURN "R".
   IF a > 1436 THEN RETURN "R".
   RETURN "R".
END FUNCTION.

FUNCTION fnlbf RETURNS CHARACTER (x AS INT, m AS INT, a AS INT, s AS INT):
/*------------------------------------------------------------------------------
Purpose: Workflow implemenation for 'lbf'
Notes:   lbf{a>1678:ks,mml}
------------------------------------------------------------------------------*/
   IF a > 1678 THEN RETURN "ks".
   RETURN "mml".
END FUNCTION.

FUNCTION fnmx RETURNS CHARACTER (x AS INT, m AS INT, a AS INT, s AS INT):
/*------------------------------------------------------------------------------
Purpose: Workflow implemenation for 'mx'
Notes:   mx{m<1054:A,a<2830:R,A}
------------------------------------------------------------------------------*/
   IF m < 1054 THEN RETURN "A".
   IF a < 2830 THEN RETURN "R".
   RETURN "A".
END FUNCTION.

FUNCTION fnxlx RETURNS CHARACTER (x AS INT, m AS INT, a AS INT, s AS INT):
/*------------------------------------------------------------------------------
Purpose: Workflow implemenation for 'xlx'
Notes:   xlx{m>2271:R,a>1109:R,x<3278:R,A}
------------------------------------------------------------------------------*/
   IF m > 2271 THEN RETURN "R".
   IF a > 1109 THEN RETURN "R".
   IF x < 3278 THEN RETURN "R".
   RETURN "A".
END FUNCTION.

FUNCTION fnxs RETURNS CHARACTER (x AS INT, m AS INT, a AS INT, s AS INT):
/*------------------------------------------------------------------------------
Purpose: Workflow implemenation for 'xs'
Notes:   xs{x<2732:A,m>3031:czx,x<2854:gzj,R}
------------------------------------------------------------------------------*/
   IF x < 2732 THEN RETURN "A".
   IF m > 3031 THEN RETURN "czx".
   IF x < 2854 THEN RETURN "gzj".
   RETURN "R".
END FUNCTION.

FUNCTION fnkm RETURNS CHARACTER (x AS INT, m AS INT, a AS INT, s AS INT):
/*------------------------------------------------------------------------------
Purpose: Workflow implemenation for 'km'
Notes:   km{x<2607:R,a>927:R,gvj}
------------------------------------------------------------------------------*/
   IF x < 2607 THEN RETURN "R".
   IF a > 927 THEN RETURN "R".
   RETURN "gvj".
END FUNCTION.

FUNCTION fnpf RETURNS CHARACTER (x AS INT, m AS INT, a AS INT, s AS INT):
/*------------------------------------------------------------------------------
Purpose: Workflow implemenation for 'pf'
Notes:   pf{x>1306:rr,mx}
------------------------------------------------------------------------------*/
   IF x > 1306 THEN RETURN "rr".
   RETURN "mx".
END FUNCTION.

FUNCTION fnqj RETURNS CHARACTER (x AS INT, m AS INT, a AS INT, s AS INT):
/*------------------------------------------------------------------------------
Purpose: Workflow implemenation for 'qj'
Notes:   qj{m<2324:brk,R}
------------------------------------------------------------------------------*/
   IF m < 2324 THEN RETURN "brk".
   RETURN "R".
END FUNCTION.

FUNCTION fnjp RETURNS CHARACTER (x AS INT, m AS INT, a AS INT, s AS INT):
/*------------------------------------------------------------------------------
Purpose: Workflow implemenation for 'jp'
Notes:   jp{a>3169:R,s<612:R,a>2848:A,A}
------------------------------------------------------------------------------*/
   IF a > 3169 THEN RETURN "R".
   IF s < 612 THEN RETURN "R".
   IF a > 2848 THEN RETURN "A".
   RETURN "A".
END FUNCTION.

FUNCTION fnnmm RETURNS CHARACTER (x AS INT, m AS INT, a AS INT, s AS INT):
/*------------------------------------------------------------------------------
Purpose: Workflow implemenation for 'nmm'
Notes:   nmm{a<3403:sr,s<2153:sc,ppt}
------------------------------------------------------------------------------*/
   IF a < 3403 THEN RETURN "sr".
   IF s < 2153 THEN RETURN "sc".
   RETURN "ppt".
END FUNCTION.

FUNCTION fnrpl RETURNS CHARACTER (x AS INT, m AS INT, a AS INT, s AS INT):
/*------------------------------------------------------------------------------
Purpose: Workflow implemenation for 'rpl'
Notes:   rpl{s>208:R,R}
------------------------------------------------------------------------------*/
   IF s > 208 THEN RETURN "R".
   RETURN "R".
END FUNCTION.

FUNCTION fngjk RETURNS CHARACTER (x AS INT, m AS INT, a AS INT, s AS INT):
/*------------------------------------------------------------------------------
Purpose: Workflow implemenation for 'gjk'
Notes:   gjk{m>958:qlg,sjb}
------------------------------------------------------------------------------*/
   IF m > 958 THEN RETURN "qlg".
   RETURN "sjb".
END FUNCTION.

FUNCTION fnmc RETURNS CHARACTER (x AS INT, m AS INT, a AS INT, s AS INT):
/*------------------------------------------------------------------------------
Purpose: Workflow implemenation for 'mc'
Notes:   mc{s<140:R,s>158:A,a>577:R,A}
------------------------------------------------------------------------------*/
   IF s < 140 THEN RETURN "R".
   IF s > 158 THEN RETURN "A".
   IF a > 577 THEN RETURN "R".
   RETURN "A".
END FUNCTION.

FUNCTION fnqvv RETURNS CHARACTER (x AS INT, m AS INT, a AS INT, s AS INT):
/*------------------------------------------------------------------------------
Purpose: Workflow implemenation for 'qvv'
Notes:   qvv{s>1224:A,hsb}
------------------------------------------------------------------------------*/
   IF s > 1224 THEN RETURN "A".
   RETURN "hsb".
END FUNCTION.

FUNCTION fncb RETURNS CHARACTER (x AS INT, m AS INT, a AS INT, s AS INT):
/*------------------------------------------------------------------------------
Purpose: Workflow implemenation for 'cb'
Notes:   cb{m>1607:R,R}
------------------------------------------------------------------------------*/
   IF m > 1607 THEN RETURN "R".
   RETURN "R".
END FUNCTION.

FUNCTION fnnvl RETURNS CHARACTER (x AS INT, m AS INT, a AS INT, s AS INT):
/*------------------------------------------------------------------------------
Purpose: Workflow implemenation for 'nvl'
Notes:   nvl{x<3257:R,a<3099:A,A}
------------------------------------------------------------------------------*/
   IF x < 3257 THEN RETURN "R".
   IF a < 3099 THEN RETURN "A".
   RETURN "A".
END FUNCTION.

FUNCTION fnmmf RETURNS CHARACTER (x AS INT, m AS INT, a AS INT, s AS INT):
/*------------------------------------------------------------------------------
Purpose: Workflow implemenation for 'mmf'
Notes:   mmf{m<2967:A,A}
------------------------------------------------------------------------------*/
   IF m < 2967 THEN RETURN "A".
   RETURN "A".
END FUNCTION.

FUNCTION fnkpf RETURNS CHARACTER (x AS INT, m AS INT, a AS INT, s AS INT):
/*------------------------------------------------------------------------------
Purpose: Workflow implemenation for 'kpf'
Notes:   kpf{s>198:rl,R}
------------------------------------------------------------------------------*/
   IF s > 198 THEN RETURN "rl".
   RETURN "R".
END FUNCTION.

FUNCTION fnzmr RETURNS CHARACTER (x AS INT, m AS INT, a AS INT, s AS INT):
/*------------------------------------------------------------------------------
Purpose: Workflow implemenation for 'zmr'
Notes:   zmr{x<3388:vqn,R}
------------------------------------------------------------------------------*/
   IF x < 3388 THEN RETURN "vqn".
   RETURN "R".
END FUNCTION.

FUNCTION fnrv RETURNS CHARACTER (x AS INT, m AS INT, a AS INT, s AS INT):
/*------------------------------------------------------------------------------
Purpose: Workflow implemenation for 'rv'
Notes:   rv{s<3061:R,R}
------------------------------------------------------------------------------*/
   IF s < 3061 THEN RETURN "R".
   RETURN "R".
END FUNCTION.

FUNCTION fnnl RETURNS CHARACTER (x AS INT, m AS INT, a AS INT, s AS INT):
/*------------------------------------------------------------------------------
Purpose: Workflow implemenation for 'nl'
Notes:   nl{s<1931:pf,fcd}
------------------------------------------------------------------------------*/
   IF s < 1931 THEN RETURN "pf".
   RETURN "fcd".
END FUNCTION.

FUNCTION fnxrb RETURNS CHARACTER (x AS INT, m AS INT, a AS INT, s AS INT):
/*------------------------------------------------------------------------------
Purpose: Workflow implemenation for 'xrb'
Notes:   xrb{x<1432:R,A}
------------------------------------------------------------------------------*/
   IF x < 1432 THEN RETURN "R".
   RETURN "A".
END FUNCTION.

FUNCTION fnkc RETURNS CHARACTER (x AS INT, m AS INT, a AS INT, s AS INT):
/*------------------------------------------------------------------------------
Purpose: Workflow implemenation for 'kc'
Notes:   kc{m<2063:R,A}
------------------------------------------------------------------------------*/
   IF m < 2063 THEN RETURN "R".
   RETURN "A".
END FUNCTION.

FUNCTION fnrvk RETURNS CHARACTER (x AS INT, m AS INT, a AS INT, s AS INT):
/*------------------------------------------------------------------------------
Purpose: Workflow implemenation for 'rvk'
Notes:   rvk{s<1178:A,R}
------------------------------------------------------------------------------*/
   IF s < 1178 THEN RETURN "A".
   RETURN "R".
END FUNCTION.

FUNCTION fnkfx RETURNS CHARACTER (x AS INT, m AS INT, a AS INT, s AS INT):
/*------------------------------------------------------------------------------
Purpose: Workflow implemenation for 'kfx'
Notes:   kfx{s>1262:R,x<1201:R,A}
------------------------------------------------------------------------------*/
   IF s > 1262 THEN RETURN "R".
   IF x < 1201 THEN RETURN "R".
   RETURN "A".
END FUNCTION.

FUNCTION fnfb RETURNS CHARACTER (x AS INT, m AS INT, a AS INT, s AS INT):
/*------------------------------------------------------------------------------
Purpose: Workflow implemenation for 'fb'
Notes:   fb{s>2493:A,s>995:rg,m>1647:kv,mv}
------------------------------------------------------------------------------*/
   IF s > 2493 THEN RETURN "A".
   IF s > 995 THEN RETURN "rg".
   IF m > 1647 THEN RETURN "kv".
   RETURN "mv".
END FUNCTION.

FUNCTION fnpls RETURNS CHARACTER (x AS INT, m AS INT, a AS INT, s AS INT):
/*------------------------------------------------------------------------------
Purpose: Workflow implemenation for 'pls'
Notes:   pls{x<1059:ds,s<3787:R,x<1733:A,fqj}
------------------------------------------------------------------------------*/
   IF x < 1059 THEN RETURN "ds".
   IF s < 3787 THEN RETURN "R".
   IF x < 1733 THEN RETURN "A".
   RETURN "fqj".
END FUNCTION.

FUNCTION fnsr RETURNS CHARACTER (x AS INT, m AS INT, a AS INT, s AS INT):
/*------------------------------------------------------------------------------
Purpose: Workflow implemenation for 'sr'
Notes:   sr{a>2831:R,s<1861:vl,R}
------------------------------------------------------------------------------*/
   IF a > 2831 THEN RETURN "R".
   IF s < 1861 THEN RETURN "vl".
   RETURN "R".
END FUNCTION.

FUNCTION fnbxz RETURNS CHARACTER (x AS INT, m AS INT, a AS INT, s AS INT):
/*------------------------------------------------------------------------------
Purpose: Workflow implemenation for 'bxz'
Notes:   bxz{s<250:dhd,A}
------------------------------------------------------------------------------*/
   IF s < 250 THEN RETURN "dhd".
   RETURN "A".
END FUNCTION.

FUNCTION fnnhx RETURNS CHARACTER (x AS INT, m AS INT, a AS INT, s AS INT):
/*------------------------------------------------------------------------------
Purpose: Workflow implemenation for 'nhx'
Notes:   nhx{m>3054:R,R}
------------------------------------------------------------------------------*/
   IF m > 3054 THEN RETURN "R".
   RETURN "R".
END FUNCTION.

FUNCTION fnlhq RETURNS CHARACTER (x AS INT, m AS INT, a AS INT, s AS INT):
/*------------------------------------------------------------------------------
Purpose: Workflow implemenation for 'lhq'
Notes:   lhq{m>650:R,x>2996:zl,s<1699:R,R}
------------------------------------------------------------------------------*/
   IF m > 650 THEN RETURN "R".
   IF x > 2996 THEN RETURN "zl".
   IF s < 1699 THEN RETURN "R".
   RETURN "R".
END FUNCTION.

FUNCTION fnzz RETURNS CHARACTER (x AS INT, m AS INT, a AS INT, s AS INT):
/*------------------------------------------------------------------------------
Purpose: Workflow implemenation for 'zz'
Notes:   zz{x>740:A,m>3478:A,s>359:R,R}
------------------------------------------------------------------------------*/
   IF x > 740 THEN RETURN "A".
   IF m > 3478 THEN RETURN "A".
   IF s > 359 THEN RETURN "R".
   RETURN "R".
END FUNCTION.

FUNCTION fnzd RETURNS CHARACTER (x AS INT, m AS INT, a AS INT, s AS INT):
/*------------------------------------------------------------------------------
Purpose: Workflow implemenation for 'zd'
Notes:   zd{s<2863:knp,R}
------------------------------------------------------------------------------*/
   IF s < 2863 THEN RETURN "knp".
   RETURN "R".
END FUNCTION.

FUNCTION fnsl RETURNS CHARACTER (x AS INT, m AS INT, a AS INT, s AS INT):
/*------------------------------------------------------------------------------
Purpose: Workflow implemenation for 'sl'
Notes:   sl{a>3038:qvb,xj}
------------------------------------------------------------------------------*/
   IF a > 3038 THEN RETURN "qvb".
   RETURN "xj".
END FUNCTION.

FUNCTION fnbh RETURNS CHARACTER (x AS INT, m AS INT, a AS INT, s AS INT):
/*------------------------------------------------------------------------------
Purpose: Workflow implemenation for 'bh'
Notes:   bh{x<1198:R,m<2785:A,R}
------------------------------------------------------------------------------*/
   IF x < 1198 THEN RETURN "R".
   IF m < 2785 THEN RETURN "A".
   RETURN "R".
END FUNCTION.

FUNCTION fntpz RETURNS CHARACTER (x AS INT, m AS INT, a AS INT, s AS INT):
/*------------------------------------------------------------------------------
Purpose: Workflow implemenation for 'tpz'
Notes:   tpz{m<3568:R,R}
------------------------------------------------------------------------------*/
   IF m < 3568 THEN RETURN "R".
   RETURN "R".
END FUNCTION.

FUNCTION fnvtp RETURNS CHARACTER (x AS INT, m AS INT, a AS INT, s AS INT):
/*------------------------------------------------------------------------------
Purpose: Workflow implemenation for 'vtp'
Notes:   vtp{s>401:pnr,a>1078:gb,s<174:rzk,vxm}
------------------------------------------------------------------------------*/
   IF s > 401 THEN RETURN "pnr".
   IF a > 1078 THEN RETURN "gb".
   IF s < 174 THEN RETURN "rzk".
   RETURN "vxm".
END FUNCTION.

FUNCTION fnsp RETURNS CHARACTER (x AS INT, m AS INT, a AS INT, s AS INT):
/*------------------------------------------------------------------------------
Purpose: Workflow implemenation for 'sp'
Notes:   sp{m<1518:cs,s<2529:R,m<1688:A,A}
------------------------------------------------------------------------------*/
   IF m < 1518 THEN RETURN "cs".
   IF s < 2529 THEN RETURN "R".
   IF m < 1688 THEN RETURN "A".
   RETURN "A".
END FUNCTION.

FUNCTION fnxx RETURNS CHARACTER (x AS INT, m AS INT, a AS INT, s AS INT):
/*------------------------------------------------------------------------------
Purpose: Workflow implemenation for 'xx'
Notes:   xx{x>3480:R,x>3304:R,R}
------------------------------------------------------------------------------*/
   IF x > 3480 THEN RETURN "R".
   IF x > 3304 THEN RETURN "R".
   RETURN "R".
END FUNCTION.

FUNCTION fngzj RETURNS CHARACTER (x AS INT, m AS INT, a AS INT, s AS INT):
/*------------------------------------------------------------------------------
Purpose: Workflow implemenation for 'gzj'
Notes:   gzj{m<2860:A,a>1265:R,A}
------------------------------------------------------------------------------*/
   IF m < 2860 THEN RETURN "A".
   IF a > 1265 THEN RETURN "R".
   RETURN "A".
END FUNCTION.

FUNCTION fnfnm RETURNS CHARACTER (x AS INT, m AS INT, a AS INT, s AS INT):
/*------------------------------------------------------------------------------
Purpose: Workflow implemenation for 'fnm'
Notes:   fnm{s>574:hj,bf}
------------------------------------------------------------------------------*/
   IF s > 574 THEN RETURN "hj".
   RETURN "bf".
END FUNCTION.

FUNCTION fnksp RETURNS CHARACTER (x AS INT, m AS INT, a AS INT, s AS INT):
/*------------------------------------------------------------------------------
Purpose: Workflow implemenation for 'ksp'
Notes:   ksp{s>456:A,R}
------------------------------------------------------------------------------*/
   IF s > 456 THEN RETURN "A".
   RETURN "R".
END FUNCTION.

FUNCTION fnpxk RETURNS CHARACTER (x AS INT, m AS INT, a AS INT, s AS INT):
/*------------------------------------------------------------------------------
Purpose: Workflow implemenation for 'pxk'
Notes:   pxk{a>3069:R,s>481:A,R}
------------------------------------------------------------------------------*/
   IF a > 3069 THEN RETURN "R".
   IF s > 481 THEN RETURN "A".
   RETURN "R".
END FUNCTION.

FUNCTION fnxxm RETURNS CHARACTER (x AS INT, m AS INT, a AS INT, s AS INT):
/*------------------------------------------------------------------------------
Purpose: Workflow implemenation for 'xxm'
Notes:   xxm{x>2290:R,A}
------------------------------------------------------------------------------*/
   IF x > 2290 THEN RETURN "R".
   RETURN "A".
END FUNCTION.

FUNCTION fncsg RETURNS CHARACTER (x AS INT, m AS INT, a AS INT, s AS INT):
/*------------------------------------------------------------------------------
Purpose: Workflow implemenation for 'csg'
Notes:   csg{a>838:R,A}
------------------------------------------------------------------------------*/
   IF a > 838 THEN RETURN "R".
   RETURN "A".
END FUNCTION.

FUNCTION fnpn RETURNS CHARACTER (x AS INT, m AS INT, a AS INT, s AS INT):
/*------------------------------------------------------------------------------
Purpose: Workflow implemenation for 'pn'
Notes:   pn{m<2473:sqj,a<1054:lts,qg}
------------------------------------------------------------------------------*/
   IF m < 2473 THEN RETURN "sqj".
   IF a < 1054 THEN RETURN "lts".
   RETURN "qg".
END FUNCTION.

FUNCTION fnbxt RETURNS CHARACTER (x AS INT, m AS INT, a AS INT, s AS INT):
/*------------------------------------------------------------------------------
Purpose: Workflow implemenation for 'bxt'
Notes:   bxt{m<3605:A,s>674:A,R}
------------------------------------------------------------------------------*/
   IF m < 3605 THEN RETURN "A".
   IF s > 674 THEN RETURN "A".
   RETURN "R".
END FUNCTION.

FUNCTION fnkvs RETURNS CHARACTER (x AS INT, m AS INT, a AS INT, s AS INT):
/*------------------------------------------------------------------------------
Purpose: Workflow implemenation for 'kvs'
Notes:   kvs{s<3401:km,rks}
------------------------------------------------------------------------------*/
   IF s < 3401 THEN RETURN "km".
   RETURN "rks".
END FUNCTION.

FUNCTION fnvqn RETURNS CHARACTER (x AS INT, m AS INT, a AS INT, s AS INT):
/*------------------------------------------------------------------------------
Purpose: Workflow implemenation for 'vqn'
Notes:   vqn{m<1234:R,s<899:A,m<1365:R,R}
------------------------------------------------------------------------------*/
   IF m < 1234 THEN RETURN "R".
   IF s < 899 THEN RETURN "A".
   IF m < 1365 THEN RETURN "R".
   RETURN "R".
END FUNCTION.

FUNCTION fndzj RETURNS CHARACTER (x AS INT, m AS INT, a AS INT, s AS INT):
/*------------------------------------------------------------------------------
Purpose: Workflow implemenation for 'dzj'
Notes:   dzj{s>1078:bk,x>2290:xhd,blh}
------------------------------------------------------------------------------*/
   IF s > 1078 THEN RETURN "bk".
   IF x > 2290 THEN RETURN "xhd".
   RETURN "blh".
END FUNCTION.

FUNCTION fnhgz RETURNS CHARACTER (x AS INT, m AS INT, a AS INT, s AS INT):
/*------------------------------------------------------------------------------
Purpose: Workflow implemenation for 'hgz'
Notes:   hgz{a<561:A,s<3039:R,x>1054:R,R}
------------------------------------------------------------------------------*/
   IF a < 561 THEN RETURN "A".
   IF s < 3039 THEN RETURN "R".
   IF x > 1054 THEN RETURN "R".
   RETURN "R".
END FUNCTION.

FUNCTION fnjns RETURNS CHARACTER (x AS INT, m AS INT, a AS INT, s AS INT):
/*------------------------------------------------------------------------------
Purpose: Workflow implemenation for 'jns'
Notes:   jns{s>319:A,m>2997:R,s<151:A,A}
------------------------------------------------------------------------------*/
   IF s > 319 THEN RETURN "A".
   IF m > 2997 THEN RETURN "R".
   IF s < 151 THEN RETURN "A".
   RETURN "A".
END FUNCTION.

FUNCTION fnkj RETURNS CHARACTER (x AS INT, m AS INT, a AS INT, s AS INT):
/*------------------------------------------------------------------------------
Purpose: Workflow implemenation for 'kj'
Notes:   kj{m>3210:A,m>2599:R,A}
------------------------------------------------------------------------------*/
   IF m > 3210 THEN RETURN "A".
   IF m > 2599 THEN RETURN "R".
   RETURN "A".
END FUNCTION.

FUNCTION fnjnb RETURNS CHARACTER (x AS INT, m AS INT, a AS INT, s AS INT):
/*------------------------------------------------------------------------------
Purpose: Workflow implemenation for 'jnb'
Notes:   jnb{x>3800:R,a>3516:A,R}
------------------------------------------------------------------------------*/
   IF x > 3800 THEN RETURN "R".
   IF a > 3516 THEN RETURN "A".
   RETURN "R".
END FUNCTION.

FUNCTION fnpgg RETURNS CHARACTER (x AS INT, m AS INT, a AS INT, s AS INT):
/*------------------------------------------------------------------------------
Purpose: Workflow implemenation for 'pgg'
Notes:   pgg{x>1354:kd,m>2551:gbz,x>763:A,lc}
------------------------------------------------------------------------------*/
   IF x > 1354 THEN RETURN "kd".
   IF m > 2551 THEN RETURN "gbz".
   IF x > 763 THEN RETURN "A".
   RETURN "lc".
END FUNCTION.

FUNCTION fnsdn RETURNS CHARACTER (x AS INT, m AS INT, a AS INT, s AS INT):
/*------------------------------------------------------------------------------
Purpose: Workflow implemenation for 'sdn'
Notes:   sdn{a<991:pgg,s<1308:kzl,pqj}
------------------------------------------------------------------------------*/
   IF a < 991 THEN RETURN "pgg".
   IF s < 1308 THEN RETURN "kzl".
   RETURN "pqj".
END FUNCTION.

FUNCTION fnlxt RETURNS CHARACTER (x AS INT, m AS INT, a AS INT, s AS INT):
/*------------------------------------------------------------------------------
Purpose: Workflow implemenation for 'lxt'
Notes:   lxt{m<1151:R,x>2255:R,s>2561:A,R}
------------------------------------------------------------------------------*/
   IF m < 1151 THEN RETURN "R".
   IF x > 2255 THEN RETURN "R".
   IF s > 2561 THEN RETURN "A".
   RETURN "R".
END FUNCTION.

FUNCTION fnnql RETURNS CHARACTER (x AS INT, m AS INT, a AS INT, s AS INT):
/*------------------------------------------------------------------------------
Purpose: Workflow implemenation for 'nql'
Notes:   nql{s<3500:kvs,x<2601:zmb,hp}
------------------------------------------------------------------------------*/
   IF s < 3500 THEN RETURN "kvs".
   IF x < 2601 THEN RETURN "zmb".
   RETURN "hp".
END FUNCTION.

FUNCTION fnnkj RETURNS CHARACTER (x AS INT, m AS INT, a AS INT, s AS INT):
/*------------------------------------------------------------------------------
Purpose: Workflow implemenation for 'nkj'
Notes:   nkj{x<1439:R,A}
------------------------------------------------------------------------------*/
   IF x < 1439 THEN RETURN "R".
   RETURN "A".
END FUNCTION.

FUNCTION fnmfd RETURNS CHARACTER (x AS INT, m AS INT, a AS INT, s AS INT):
/*------------------------------------------------------------------------------
Purpose: Workflow implemenation for 'mfd'
Notes:   mfd{x<3094:A,x<3593:R,m<2791:R,R}
------------------------------------------------------------------------------*/
   IF x < 3094 THEN RETURN "A".
   IF x < 3593 THEN RETURN "R".
   IF m < 2791 THEN RETURN "R".
   RETURN "R".
END FUNCTION.

FUNCTION fnnpn RETURNS CHARACTER (x AS INT, m AS INT, a AS INT, s AS INT):
/*------------------------------------------------------------------------------
Purpose: Workflow implemenation for 'npn'
Notes:   npn{s<446:R,R}
------------------------------------------------------------------------------*/
   IF s < 446 THEN RETURN "R".
   RETURN "R".
END FUNCTION.

FUNCTION fnrk RETURNS CHARACTER (x AS INT, m AS INT, a AS INT, s AS INT):
/*------------------------------------------------------------------------------
Purpose: Workflow implemenation for 'rk'
Notes:   rk{a<925:A,A}
------------------------------------------------------------------------------*/
   IF a < 925 THEN RETURN "A".
   RETURN "A".
END FUNCTION.

FUNCTION fnfh RETURNS CHARACTER (x AS INT, m AS INT, a AS INT, s AS INT):
/*------------------------------------------------------------------------------
Purpose: Workflow implemenation for 'fh'
Notes:   fh{m<3144:R,a>2601:rb,R}
------------------------------------------------------------------------------*/
   IF m < 3144 THEN RETURN "R".
   IF a > 2601 THEN RETURN "rb".
   RETURN "R".
END FUNCTION.

FUNCTION fnkq RETURNS CHARACTER (x AS INT, m AS INT, a AS INT, s AS INT):
/*------------------------------------------------------------------------------
Purpose: Workflow implemenation for 'kq'
Notes:   kq{x>1327:R,s<628:R,s<719:R,R}
------------------------------------------------------------------------------*/
   IF x > 1327 THEN RETURN "R".
   IF s < 628 THEN RETURN "R".
   IF s < 719 THEN RETURN "R".
   RETURN "R".
END FUNCTION.

FUNCTION fnllz RETURNS CHARACTER (x AS INT, m AS INT, a AS INT, s AS INT):
/*------------------------------------------------------------------------------
Purpose: Workflow implemenation for 'llz'
Notes:   llz{x<1865:R,x<2062:R,m<533:R,A}
------------------------------------------------------------------------------*/
   IF x < 1865 THEN RETURN "R".
   IF x < 2062 THEN RETURN "R".
   IF m < 533 THEN RETURN "R".
   RETURN "A".
END FUNCTION.

FUNCTION fnft RETURNS CHARACTER (x AS INT, m AS INT, a AS INT, s AS INT):
/*------------------------------------------------------------------------------
Purpose: Workflow implemenation for 'ft'
Notes:   ft{s<1983:bbv,a<2323:gqm,a<3139:zxt,bm}
------------------------------------------------------------------------------*/
   IF s < 1983 THEN RETURN "bbv".
   IF a < 2323 THEN RETURN "gqm".
   IF a < 3139 THEN RETURN "zxt".
   RETURN "bm".
END FUNCTION.

FUNCTION fnmml RETURNS CHARACTER (x AS INT, m AS INT, a AS INT, s AS INT):
/*------------------------------------------------------------------------------
Purpose: Workflow implemenation for 'mml'
Notes:   mml{s>2364:vrx,m<3279:jkc,cgb}
------------------------------------------------------------------------------*/
   IF s > 2364 THEN RETURN "vrx".
   IF m < 3279 THEN RETURN "jkc".
   RETURN "cgb".
END FUNCTION.

FUNCTION fnrlq RETURNS CHARACTER (x AS INT, m AS INT, a AS INT, s AS INT):
/*------------------------------------------------------------------------------
Purpose: Workflow implemenation for 'rlq'
Notes:   rlq{x>2132:R,m>2557:R,a>1746:A,A}
------------------------------------------------------------------------------*/
   IF x > 2132 THEN RETURN "R".
   IF m > 2557 THEN RETURN "R".
   IF a > 1746 THEN RETURN "A".
   RETURN "A".
END FUNCTION.

FUNCTION fnprc RETURNS CHARACTER (x AS INT, m AS INT, a AS INT, s AS INT):
/*------------------------------------------------------------------------------
Purpose: Workflow implemenation for 'prc'
Notes:   prc{x>1012:nl,x>429:lqj,m>1338:nhr,dt}
------------------------------------------------------------------------------*/
   IF x > 1012 THEN RETURN "nl".
   IF x > 429 THEN RETURN "lqj".
   IF m > 1338 THEN RETURN "nhr".
   RETURN "dt".
END FUNCTION.

FUNCTION fngqm RETURNS CHARACTER (x AS INT, m AS INT, a AS INT, s AS INT):
/*------------------------------------------------------------------------------
Purpose: Workflow implemenation for 'gqm'
Notes:   gqm{x>3726:A,s<2694:A,m<756:R,R}
------------------------------------------------------------------------------*/
   IF x > 3726 THEN RETURN "A".
   IF s < 2694 THEN RETURN "A".
   IF m < 756 THEN RETURN "R".
   RETURN "R".
END FUNCTION.

FUNCTION fnlvm RETURNS CHARACTER (x AS INT, m AS INT, a AS INT, s AS INT):
/*------------------------------------------------------------------------------
Purpose: Workflow implemenation for 'lvm'
Notes:   lvm{m<3367:A,s>598:A,x<2525:R,R}
------------------------------------------------------------------------------*/
   IF m < 3367 THEN RETURN "A".
   IF s > 598 THEN RETURN "A".
   IF x < 2525 THEN RETURN "R".
   RETURN "R".
END FUNCTION.

FUNCTION fndb RETURNS CHARACTER (x AS INT, m AS INT, a AS INT, s AS INT):
/*------------------------------------------------------------------------------
Purpose: Workflow implemenation for 'db'
Notes:   db{m>1949:R,x>2355:R,A}
------------------------------------------------------------------------------*/
   IF m > 1949 THEN RETURN "R".
   IF x > 2355 THEN RETURN "R".
   RETURN "A".
END FUNCTION.

FUNCTION fnfvh RETURNS CHARACTER (x AS INT, m AS INT, a AS INT, s AS INT):
/*------------------------------------------------------------------------------
Purpose: Workflow implemenation for 'fvh'
Notes:   fvh{m<1036:R,A}
------------------------------------------------------------------------------*/
   IF m < 1036 THEN RETURN "R".
   RETURN "A".
END FUNCTION.

FUNCTION fnfsj RETURNS CHARACTER (x AS INT, m AS INT, a AS INT, s AS INT):
/*------------------------------------------------------------------------------
Purpose: Workflow implemenation for 'fsj'
Notes:   fsj{m>1663:A,x>2977:A,s>2939:R,A}
------------------------------------------------------------------------------*/
   IF m > 1663 THEN RETURN "A".
   IF x > 2977 THEN RETURN "A".
   IF s > 2939 THEN RETURN "R".
   RETURN "A".
END FUNCTION.

FUNCTION fnmtv RETURNS CHARACTER (x AS INT, m AS INT, a AS INT, s AS INT):
/*------------------------------------------------------------------------------
Purpose: Workflow implemenation for 'mtv'
Notes:   mtv{s>1535:bt,a>2595:xbx,s>888:cpb,zjb}
------------------------------------------------------------------------------*/
   IF s > 1535 THEN RETURN "bt".
   IF a > 2595 THEN RETURN "xbx".
   IF s > 888 THEN RETURN "cpb".
   RETURN "zjb".
END FUNCTION.

FUNCTION fnzq RETURNS CHARACTER (x AS INT, m AS INT, a AS INT, s AS INT):
/*------------------------------------------------------------------------------
Purpose: Workflow implemenation for 'zq'
Notes:   zq{x>2291:R,R}
------------------------------------------------------------------------------*/
   IF x > 2291 THEN RETURN "R".
   RETURN "R".
END FUNCTION.

FUNCTION fnfsk RETURNS CHARACTER (x AS INT, m AS INT, a AS INT, s AS INT):
/*------------------------------------------------------------------------------
Purpose: Workflow implemenation for 'fsk'
Notes:   fsk{s>265:R,m<2431:A,s>111:A,A}
------------------------------------------------------------------------------*/
   IF s > 265 THEN RETURN "R".
   IF m < 2431 THEN RETURN "A".
   IF s > 111 THEN RETURN "A".
   RETURN "A".
END FUNCTION.

FUNCTION fnlts RETURNS CHARACTER (x AS INT, m AS INT, a AS INT, s AS INT):
/*------------------------------------------------------------------------------
Purpose: Workflow implemenation for 'lts'
Notes:   lts{x>3595:bjf,hr}
------------------------------------------------------------------------------*/
   IF x > 3595 THEN RETURN "bjf".
   RETURN "hr".
END FUNCTION.

FUNCTION fntmb RETURNS CHARACTER (x AS INT, m AS INT, a AS INT, s AS INT):
/*------------------------------------------------------------------------------
Purpose: Workflow implemenation for 'tmb'
Notes:   tmb{s>1466:jkd,qcv}
------------------------------------------------------------------------------*/
   IF s > 1466 THEN RETURN "jkd".
   RETURN "qcv".
END FUNCTION.

FUNCTION fnxfr RETURNS CHARACTER (x AS INT, m AS INT, a AS INT, s AS INT):
/*------------------------------------------------------------------------------
Purpose: Workflow implemenation for 'xfr'
Notes:   xfr{x<1561:prc,m<833:gbb,m>1471:jd,bmd}
------------------------------------------------------------------------------*/
   IF x < 1561 THEN RETURN "prc".
   IF m < 833 THEN RETURN "gbb".
   IF m > 1471 THEN RETURN "jd".
   RETURN "bmd".
END FUNCTION.

FUNCTION fnzjb RETURNS CHARACTER (x AS INT, m AS INT, a AS INT, s AS INT):
/*------------------------------------------------------------------------------
Purpose: Workflow implemenation for 'zjb'
Notes:   zjb{x<1868:fd,m>3209:srq,m>2729:gq,trc}
------------------------------------------------------------------------------*/
   IF x < 1868 THEN RETURN "fd".
   IF m > 3209 THEN RETURN "srq".
   IF m > 2729 THEN RETURN "gq".
   RETURN "trc".
END FUNCTION.

FUNCTION fngf RETURNS CHARACTER (x AS INT, m AS INT, a AS INT, s AS INT):
/*------------------------------------------------------------------------------
Purpose: Workflow implemenation for 'gf'
Notes:   gf{m<3555:R,x<2969:bxt,m<3599:A,R}
------------------------------------------------------------------------------*/
   IF m < 3555 THEN RETURN "R".
   IF x < 2969 THEN RETURN "bxt".
   IF m < 3599 THEN RETURN "A".
   RETURN "R".
END FUNCTION.

FUNCTION fnhgd RETURNS CHARACTER (x AS INT, m AS INT, a AS INT, s AS INT):
/*------------------------------------------------------------------------------
Purpose: Workflow implemenation for 'hgd'
Notes:   hgd{x<3424:jqs,x<3784:hcv,rcf}
------------------------------------------------------------------------------*/
   IF x < 3424 THEN RETURN "jqs".
   IF x < 3784 THEN RETURN "hcv".
   RETURN "rcf".
END FUNCTION.

FUNCTION fngr RETURNS CHARACTER (x AS INT, m AS INT, a AS INT, s AS INT):
/*------------------------------------------------------------------------------
Purpose: Workflow implemenation for 'gr'
Notes:   gr{m>3624:A,a>594:A,a>338:R,A}
------------------------------------------------------------------------------*/
   IF m > 3624 THEN RETURN "A".
   IF a > 594 THEN RETURN "A".
   IF a > 338 THEN RETURN "R".
   RETURN "A".
END FUNCTION.

FUNCTION fnhcv RETURNS CHARACTER (x AS INT, m AS INT, a AS INT, s AS INT):
/*------------------------------------------------------------------------------
Purpose: Workflow implemenation for 'hcv'
Notes:   hcv{a<1292:A,m>3015:R,R}
------------------------------------------------------------------------------*/
   IF a < 1292 THEN RETURN "A".
   IF m > 3015 THEN RETURN "R".
   RETURN "R".
END FUNCTION.

FUNCTION fnnj RETURNS CHARACTER (x AS INT, m AS INT, a AS INT, s AS INT):
/*------------------------------------------------------------------------------
Purpose: Workflow implemenation for 'nj'
Notes:   nj{m>3046:A,x<3685:fbz,m>2877:R,A}
------------------------------------------------------------------------------*/
   IF m > 3046 THEN RETURN "A".
   IF x < 3685 THEN RETURN "fbz".
   IF m > 2877 THEN RETURN "R".
   RETURN "A".
END FUNCTION.

FUNCTION fnrjx RETURNS CHARACTER (x AS INT, m AS INT, a AS INT, s AS INT):
/*------------------------------------------------------------------------------
Purpose: Workflow implemenation for 'rjx'
Notes:   rjx{s<635:lvm,A}
------------------------------------------------------------------------------*/
   IF s < 635 THEN RETURN "lvm".
   RETURN "A".
END FUNCTION.

FUNCTION fnjmj RETURNS CHARACTER (x AS INT, m AS INT, a AS INT, s AS INT):
/*------------------------------------------------------------------------------
Purpose: Workflow implemenation for 'jmj'
Notes:   jmj{m<2437:A,a<3023:R,A}
------------------------------------------------------------------------------*/
   IF m < 2437 THEN RETURN "A".
   IF a < 3023 THEN RETURN "R".
   RETURN "A".
END FUNCTION.

FUNCTION fnhp RETURNS CHARACTER (x AS INT, m AS INT, a AS INT, s AS INT):
/*------------------------------------------------------------------------------
Purpose: Workflow implemenation for 'hp'
Notes:   hp{a>779:hgd,dxf}
------------------------------------------------------------------------------*/
   IF a > 779 THEN RETURN "hgd".
   RETURN "dxf".
END FUNCTION.

FUNCTION fnsqj RETURNS CHARACTER (x AS INT, m AS INT, a AS INT, s AS INT):
/*------------------------------------------------------------------------------
Purpose: Workflow implemenation for 'sqj'
Notes:   sqj{s<2972:R,m>2255:R,m<2212:rv,xx}
------------------------------------------------------------------------------*/
   IF s < 2972 THEN RETURN "R".
   IF m > 2255 THEN RETURN "R".
   IF m < 2212 THEN RETURN "rv".
   RETURN "xx".
END FUNCTION.

FUNCTION fnvbb RETURNS CHARACTER (x AS INT, m AS INT, a AS INT, s AS INT):
/*------------------------------------------------------------------------------
Purpose: Workflow implemenation for 'vbb'
Notes:   vbb{s<93:A,a<1485:R,R}
------------------------------------------------------------------------------*/
   IF s < 93 THEN RETURN "A".
   IF a < 1485 THEN RETURN "R".
   RETURN "R".
END FUNCTION.

FUNCTION fnsc RETURNS CHARACTER (x AS INT, m AS INT, a AS INT, s AS INT):
/*------------------------------------------------------------------------------
Purpose: Workflow implemenation for 'sc'
Notes:   sc{x<3438:R,m<1135:A,a>3704:ff,qm}
------------------------------------------------------------------------------*/
   IF x < 3438 THEN RETURN "R".
   IF m < 1135 THEN RETURN "A".
   IF a > 3704 THEN RETURN "ff".
   RETURN "qm".
END FUNCTION.

FUNCTION fnbrl RETURNS CHARACTER (x AS INT, m AS INT, a AS INT, s AS INT):
/*------------------------------------------------------------------------------
Purpose: Workflow implemenation for 'brl'
Notes:   brl{s<979:A,a<1569:R,s>1040:R,A}
------------------------------------------------------------------------------*/
   IF s < 979 THEN RETURN "A".
   IF a < 1569 THEN RETURN "R".
   IF s > 1040 THEN RETURN "R".
   RETURN "A".
END FUNCTION.

FUNCTION fnhkl RETURNS CHARACTER (x AS INT, m AS INT, a AS INT, s AS INT):
/*------------------------------------------------------------------------------
Purpose: Workflow implemenation for 'hkl'
Notes:   hkl{a>1206:A,rgq}
------------------------------------------------------------------------------*/
   IF a > 1206 THEN RETURN "A".
   RETURN "rgq".
END FUNCTION.

FUNCTION fnsnt RETURNS CHARACTER (x AS INT, m AS INT, a AS INT, s AS INT):
/*------------------------------------------------------------------------------
Purpose: Workflow implemenation for 'snt'
Notes:   snt{a<3037:pcl,x>2181:qkc,fx}
------------------------------------------------------------------------------*/
   IF a < 3037 THEN RETURN "pcl".
   IF x > 2181 THEN RETURN "qkc".
   RETURN "fx".
END FUNCTION.

FUNCTION fnhv RETURNS CHARACTER (x AS INT, m AS INT, a AS INT, s AS INT):
/*------------------------------------------------------------------------------
Purpose: Workflow implemenation for 'hv'
Notes:   hv{m<2950:R,sdv}
------------------------------------------------------------------------------*/
   IF m < 2950 THEN RETURN "R".
   RETURN "sdv".
END FUNCTION.

FUNCTION fnmj RETURNS CHARACTER (x AS INT, m AS INT, a AS INT, s AS INT):
/*------------------------------------------------------------------------------
Purpose: Workflow implemenation for 'mj'
Notes:   mj{a<1926:A,A}
------------------------------------------------------------------------------*/
   IF a < 1926 THEN RETURN "A".
   RETURN "A".
END FUNCTION.

FUNCTION fntm RETURNS CHARACTER (x AS INT, m AS INT, a AS INT, s AS INT):
/*------------------------------------------------------------------------------
Purpose: Workflow implemenation for 'tm'
Notes:   tm{s>687:R,A}
------------------------------------------------------------------------------*/
   IF s > 687 THEN RETURN "R".
   RETURN "A".
END FUNCTION.

FUNCTION fnsxh RETURNS CHARACTER (x AS INT, m AS INT, a AS INT, s AS INT):
/*------------------------------------------------------------------------------
Purpose: Workflow implemenation for 'sxh'
Notes:   sxh{x>2873:jdn,a>1033:mhm,a<613:qj,dl}
------------------------------------------------------------------------------*/
   IF x > 2873 THEN RETURN "jdn".
   IF a > 1033 THEN RETURN "mhm".
   IF a < 613 THEN RETURN "qj".
   RETURN "dl".
END FUNCTION.

FUNCTION fnsdv RETURNS CHARACTER (x AS INT, m AS INT, a AS INT, s AS INT):
/*------------------------------------------------------------------------------
Purpose: Workflow implemenation for 'sdv'
Notes:   sdv{m<3613:A,R}
------------------------------------------------------------------------------*/
   IF m < 3613 THEN RETURN "A".
   RETURN "R".
END FUNCTION.

FUNCTION fnqg RETURNS CHARACTER (x AS INT, m AS INT, a AS INT, s AS INT):
/*------------------------------------------------------------------------------
Purpose: Workflow implemenation for 'qg'
Notes:   qg{s<2990:R,x<3664:gx,s<3085:nfx,R}
------------------------------------------------------------------------------*/
   IF s < 2990 THEN RETURN "R".
   IF x < 3664 THEN RETURN "gx".
   IF s < 3085 THEN RETURN "nfx".
   RETURN "R".
END FUNCTION.

FUNCTION fnvp RETURNS CHARACTER (x AS INT, m AS INT, a AS INT, s AS INT):
/*------------------------------------------------------------------------------
Purpose: Workflow implemenation for 'vp'
Notes:   vp{s<3458:R,a<3203:R,kmr}
------------------------------------------------------------------------------*/
   IF s < 3458 THEN RETURN "R".
   IF a < 3203 THEN RETURN "R".
   RETURN "kmr".
END FUNCTION.

FUNCTION fnbsq RETURNS CHARACTER (x AS INT, m AS INT, a AS INT, s AS INT):
/*------------------------------------------------------------------------------
Purpose: Workflow implemenation for 'bsq'
Notes:   bsq{s<3005:R,A}
------------------------------------------------------------------------------*/
   IF s < 3005 THEN RETURN "R".
   RETURN "A".
END FUNCTION.

FUNCTION fnqp RETURNS CHARACTER (x AS INT, m AS INT, a AS INT, s AS INT):
/*------------------------------------------------------------------------------
Purpose: Workflow implemenation for 'qp'
Notes:   qp{s<1699:A,A}
------------------------------------------------------------------------------*/
   IF s < 1699 THEN RETURN "A".
   RETURN "A".
END FUNCTION.

FUNCTION fnjl RETURNS CHARACTER (x AS INT, m AS INT, a AS INT, s AS INT):
/*------------------------------------------------------------------------------
Purpose: Workflow implemenation for 'jl'
Notes:   jl{s>3798:A,R}
------------------------------------------------------------------------------*/
   IF s > 3798 THEN RETURN "A".
   RETURN "R".
END FUNCTION.

FUNCTION fnfvn RETURNS CHARACTER (x AS INT, m AS INT, a AS INT, s AS INT):
/*------------------------------------------------------------------------------
Purpose: Workflow implemenation for 'fvn'
Notes:   fvn{x>2512:A,s<1276:R,R}
------------------------------------------------------------------------------*/
   IF x > 2512 THEN RETURN "A".
   IF s < 1276 THEN RETURN "R".
   RETURN "R".
END FUNCTION.

FUNCTION fnzzl RETURNS CHARACTER (x AS INT, m AS INT, a AS INT, s AS INT):
/*------------------------------------------------------------------------------
Purpose: Workflow implemenation for 'zzl'
Notes:   zzl{m>3437:R,x>2355:R,R}
------------------------------------------------------------------------------*/
   IF m > 3437 THEN RETURN "R".
   IF x > 2355 THEN RETURN "R".
   RETURN "R".
END FUNCTION.

FUNCTION fnqxn RETURNS CHARACTER (x AS INT, m AS INT, a AS INT, s AS INT):
/*------------------------------------------------------------------------------
Purpose: Workflow implemenation for 'qxn'
Notes:   qxn{x<3126:R,m<1095:A,R}
------------------------------------------------------------------------------*/
   IF x < 3126 THEN RETURN "R".
   IF m < 1095 THEN RETURN "A".
   RETURN "R".
END FUNCTION.

FUNCTION fnpbb RETURNS CHARACTER (x AS INT, m AS INT, a AS INT, s AS INT):
/*------------------------------------------------------------------------------
Purpose: Workflow implemenation for 'pbb'
Notes:   pbb{m<3066:A,R}
------------------------------------------------------------------------------*/
   IF m < 3066 THEN RETURN "A".
   RETURN "R".
END FUNCTION.

FUNCTION fnks RETURNS CHARACTER (x AS INT, m AS INT, a AS INT, s AS INT):
/*------------------------------------------------------------------------------
Purpose: Workflow implemenation for 'ks'
Notes:   ks{m<3192:cvd,lsq}
------------------------------------------------------------------------------*/
   IF m < 3192 THEN RETURN "cvd".
   RETURN "lsq".
END FUNCTION.

FUNCTION fntfn RETURNS CHARACTER (x AS INT, m AS INT, a AS INT, s AS INT):
/*------------------------------------------------------------------------------
Purpose: Workflow implemenation for 'tfn'
Notes:   tfn{a>3183:nhx,A}
------------------------------------------------------------------------------*/
   IF a > 3183 THEN RETURN "nhx".
   RETURN "A".
END FUNCTION.

FUNCTION fntrj RETURNS CHARACTER (x AS INT, m AS INT, a AS INT, s AS INT):
/*------------------------------------------------------------------------------
Purpose: Workflow implemenation for 'trj'
Notes:   trj{a<3362:A,m>290:A,x<3632:R,A}
------------------------------------------------------------------------------*/
   IF a < 3362 THEN RETURN "A".
   IF m > 290 THEN RETURN "A".
   IF x < 3632 THEN RETURN "R".
   RETURN "A".
END FUNCTION.

FUNCTION fnzpz RETURNS CHARACTER (x AS INT, m AS INT, a AS INT, s AS INT):
/*------------------------------------------------------------------------------
Purpose: Workflow implemenation for 'zpz'
Notes:   zpz{a<1354:R,s<3021:R,A}
------------------------------------------------------------------------------*/
   IF a < 1354 THEN RETURN "R".
   IF s < 3021 THEN RETURN "R".
   RETURN "A".
END FUNCTION.

FUNCTION fnkl RETURNS CHARACTER (x AS INT, m AS INT, a AS INT, s AS INT):
/*------------------------------------------------------------------------------
Purpose: Workflow implemenation for 'kl'
Notes:   kl{m>2073:A,A}
------------------------------------------------------------------------------*/
   IF m > 2073 THEN RETURN "A".
   RETURN "A".
END FUNCTION.

FUNCTION fnkht RETURNS CHARACTER (x AS INT, m AS INT, a AS INT, s AS INT):
/*------------------------------------------------------------------------------
Purpose: Workflow implemenation for 'kht'
Notes:   kht{a>3289:A,x<3178:R,A}
------------------------------------------------------------------------------*/
   IF a > 3289 THEN RETURN "A".
   IF x < 3178 THEN RETURN "R".
   RETURN "A".
END FUNCTION.

FUNCTION fnxt RETURNS CHARACTER (x AS INT, m AS INT, a AS INT, s AS INT):
/*------------------------------------------------------------------------------
Purpose: Workflow implemenation for 'xt'
Notes:   xt{a>3063:A,x<2237:A,a>2887:A,A}
------------------------------------------------------------------------------*/
   IF a > 3063 THEN RETURN "A".
   IF x < 2237 THEN RETURN "A".
   IF a > 2887 THEN RETURN "A".
   RETURN "A".
END FUNCTION.

FUNCTION fnfl RETURNS CHARACTER (x AS INT, m AS INT, a AS INT, s AS INT):
/*------------------------------------------------------------------------------
Purpose: Workflow implemenation for 'fl'
Notes:   fl{s>2668:fg,A}
------------------------------------------------------------------------------*/
   IF s > 2668 THEN RETURN "fg".
   RETURN "A".
END FUNCTION.

FUNCTION fnxsk RETURNS CHARACTER (x AS INT, m AS INT, a AS INT, s AS INT):
/*------------------------------------------------------------------------------
Purpose: Workflow implemenation for 'xsk'
Notes:   xsk{m<3311:nsj,a<1513:R,R}
------------------------------------------------------------------------------*/
   IF m < 3311 THEN RETURN "nsj".
   IF a < 1513 THEN RETURN "R".
   RETURN "R".
END FUNCTION.

FUNCTION fndt RETURNS CHARACTER (x AS INT, m AS INT, a AS INT, s AS INT):
/*------------------------------------------------------------------------------
Purpose: Workflow implemenation for 'dt'
Notes:   dt{s<2042:bvt,a>2530:zd,sgj}
------------------------------------------------------------------------------*/
   IF s < 2042 THEN RETURN "bvt".
   IF a > 2530 THEN RETURN "zd".
   RETURN "sgj".
END FUNCTION.

FUNCTION fngd RETURNS CHARACTER (x AS INT, m AS INT, a AS INT, s AS INT):
/*------------------------------------------------------------------------------
Purpose: Workflow implemenation for 'gd'
Notes:   gd{a<620:gt,x>2444:vc,a>1108:jfc,sp}
------------------------------------------------------------------------------*/
   IF a < 620 THEN RETURN "gt".
   IF x > 2444 THEN RETURN "vc".
   IF a > 1108 THEN RETURN "jfc".
   RETURN "sp".
END FUNCTION.

FUNCTION fnnv RETURNS CHARACTER (x AS INT, m AS INT, a AS INT, s AS INT):
/*------------------------------------------------------------------------------
Purpose: Workflow implemenation for 'nv'
Notes:   nv{s>1240:R,m>2836:R,a>353:A,R}
------------------------------------------------------------------------------*/
   IF s > 1240 THEN RETURN "R".
   IF m > 2836 THEN RETURN "R".
   IF a > 353 THEN RETURN "A".
   RETURN "R".
END FUNCTION.

FUNCTION fntd RETURNS CHARACTER (x AS INT, m AS INT, a AS INT, s AS INT):
/*------------------------------------------------------------------------------
Purpose: Workflow implemenation for 'td'
Notes:   td{a<2465:lh,m<1779:fsj,qz}
------------------------------------------------------------------------------*/
   IF a < 2465 THEN RETURN "lh".
   IF m < 1779 THEN RETURN "fsj".
   RETURN "qz".
END FUNCTION.

FUNCTION fnhq RETURNS CHARACTER (x AS INT, m AS INT, a AS INT, s AS INT):
/*------------------------------------------------------------------------------
Purpose: Workflow implemenation for 'hq'
Notes:   hq{m<3025:lpk,m>3391:snt,sl}
------------------------------------------------------------------------------*/
   IF m < 3025 THEN RETURN "lpk".
   IF m > 3391 THEN RETURN "snt".
   RETURN "sl".
END FUNCTION.

FUNCTION fnkzl RETURNS CHARACTER (x AS INT, m AS INT, a AS INT, s AS INT):
/*------------------------------------------------------------------------------
Purpose: Workflow implemenation for 'kzl'
Notes:   kzl{m>2636:A,m<2420:R,R}
------------------------------------------------------------------------------*/
   IF m > 2636 THEN RETURN "A".
   IF m < 2420 THEN RETURN "R".
   RETURN "R".
END FUNCTION.

FUNCTION fnhdb RETURNS CHARACTER (x AS INT, m AS INT, a AS INT, s AS INT):
/*------------------------------------------------------------------------------
Purpose: Workflow implemenation for 'hdb'
Notes:   hdb{m<2705:A,m<2892:A,s<988:A,R}
------------------------------------------------------------------------------*/
   IF m < 2705 THEN RETURN "A".
   IF m < 2892 THEN RETURN "A".
   IF s < 988 THEN RETURN "A".
   RETURN "R".
END FUNCTION.

FUNCTION fnlzc RETURNS CHARACTER (x AS INT, m AS INT, a AS INT, s AS INT):
/*------------------------------------------------------------------------------
Purpose: Workflow implemenation for 'lzc'
Notes:   lzc{s<1244:R,A}
------------------------------------------------------------------------------*/
   IF s < 1244 THEN RETURN "R".
   RETURN "A".
END FUNCTION.

FUNCTION fnpd RETURNS CHARACTER (x AS INT, m AS INT, a AS INT, s AS INT):
/*------------------------------------------------------------------------------
Purpose: Workflow implemenation for 'pd'
Notes:   pd{x>814:bts,fvh}
------------------------------------------------------------------------------*/
   IF x > 814 THEN RETURN "bts".
   RETURN "fvh".
END FUNCTION.

FUNCTION fnfqj RETURNS CHARACTER (x AS INT, m AS INT, a AS INT, s AS INT):
/*------------------------------------------------------------------------------
Purpose: Workflow implemenation for 'fqj'
Notes:   fqj{a>577:R,x>2263:A,x>2013:R,A}
------------------------------------------------------------------------------*/
   IF a > 577 THEN RETURN "R".
   IF x > 2263 THEN RETURN "A".
   IF x > 2013 THEN RETURN "R".
   RETURN "A".
END FUNCTION.

FUNCTION fnhjt RETURNS CHARACTER (x AS INT, m AS INT, a AS INT, s AS INT):
/*------------------------------------------------------------------------------
Purpose: Workflow implemenation for 'hjt'
Notes:   hjt{x>3133:bs,s>2231:lmt,s>1243:lhq,jj}
------------------------------------------------------------------------------*/
   IF x > 3133 THEN RETURN "bs".
   IF s > 2231 THEN RETURN "lmt".
   IF s > 1243 THEN RETURN "lhq".
   RETURN "jj".
END FUNCTION.

FUNCTION fntc RETURNS CHARACTER (x AS INT, m AS INT, a AS INT, s AS INT):
/*------------------------------------------------------------------------------
Purpose: Workflow implemenation for 'tc'
Notes:   tc{a<1040:R,a<2061:R,R}
------------------------------------------------------------------------------*/
   IF a < 1040 THEN RETURN "R".
   IF a < 2061 THEN RETURN "R".
   RETURN "R".
END FUNCTION.

FUNCTION fnsx RETURNS CHARACTER (x AS INT, m AS INT, a AS INT, s AS INT):
/*------------------------------------------------------------------------------
Purpose: Workflow implemenation for 'sx'
Notes:   sx{m>2430:R,a>1441:R,R}
------------------------------------------------------------------------------*/
   IF m > 2430 THEN RETURN "R".
   IF a > 1441 THEN RETURN "R".
   RETURN "R".
END FUNCTION.

FUNCTION fnjrn RETURNS CHARACTER (x AS INT, m AS INT, a AS INT, s AS INT):
/*------------------------------------------------------------------------------
Purpose: Workflow implemenation for 'jrn'
Notes:   jrn{m<3177:xrf,bg}
------------------------------------------------------------------------------*/
   IF m < 3177 THEN RETURN "xrf".
   RETURN "bg".
END FUNCTION.

FUNCTION fnsjr RETURNS CHARACTER (x AS INT, m AS INT, a AS INT, s AS INT):
/*------------------------------------------------------------------------------
Purpose: Workflow implemenation for 'sjr'
Notes:   sjr{s>434:R,R}
------------------------------------------------------------------------------*/
   IF s > 434 THEN RETURN "R".
   RETURN "R".
END FUNCTION.

FUNCTION fnsbt RETURNS CHARACTER (x AS INT, m AS INT, a AS INT, s AS INT):
/*------------------------------------------------------------------------------
Purpose: Workflow implemenation for 'sbt'
Notes:   sbt{a>1333:hf,m<2974:xq,A}
------------------------------------------------------------------------------*/
   IF a > 1333 THEN RETURN "hf".
   IF m < 2974 THEN RETURN "xq".
   RETURN "A".
END FUNCTION.

FUNCTION fnxj RETURNS CHARACTER (x AS INT, m AS INT, a AS INT, s AS INT):
/*------------------------------------------------------------------------------
Purpose: Workflow implemenation for 'xj'
Notes:   xj{s<1140:szg,a>2875:hh,m>3181:gv,A}
------------------------------------------------------------------------------*/
   IF s < 1140 THEN RETURN "szg".
   IF a > 2875 THEN RETURN "hh".
   IF m > 3181 THEN RETURN "gv".
   RETURN "A".
END FUNCTION.

FUNCTION fnzpb RETURNS CHARACTER (x AS INT, m AS INT, a AS INT, s AS INT):
/*------------------------------------------------------------------------------
Purpose: Workflow implemenation for 'zpb'
Notes:   zpb{m>3499:hgz,m<3296:lp,s>2976:vf,rkl}
------------------------------------------------------------------------------*/
   IF m > 3499 THEN RETURN "hgz".
   IF m < 3296 THEN RETURN "lp".
   IF s > 2976 THEN RETURN "vf".
   RETURN "rkl".
END FUNCTION.

FUNCTION fndp RETURNS CHARACTER (x AS INT, m AS INT, a AS INT, s AS INT):
/*------------------------------------------------------------------------------
Purpose: Workflow implemenation for 'dp'
Notes:   dp{a>3031:A,a>2953:A,R}
------------------------------------------------------------------------------*/
   IF a > 3031 THEN RETURN "A".
   IF a > 2953 THEN RETURN "A".
   RETURN "R".
END FUNCTION.

FUNCTION fnlxx RETURNS CHARACTER (x AS INT, m AS INT, a AS INT, s AS INT):
/*------------------------------------------------------------------------------
Purpose: Workflow implemenation for 'lxx'
Notes:   lxx{s>575:mh,m<2984:zdd,zzz}
------------------------------------------------------------------------------*/
   IF s > 575 THEN RETURN "mh".
   IF m < 2984 THEN RETURN "zdd".
   RETURN "zzz".
END FUNCTION.

FUNCTION fnsxk RETURNS CHARACTER (x AS INT, m AS INT, a AS INT, s AS INT):
/*------------------------------------------------------------------------------
Purpose: Workflow implemenation for 'sxk'
Notes:   sxk{x<1180:vbk,a>2579:vp,s<3501:ls,kgl}
------------------------------------------------------------------------------*/
   IF x < 1180 THEN RETURN "vbk".
   IF a > 2579 THEN RETURN "vp".
   IF s < 3501 THEN RETURN "ls".
   RETURN "kgl".
END FUNCTION.

FUNCTION fnqvb RETURNS CHARACTER (x AS INT, m AS INT, a AS INT, s AS INT):
/*------------------------------------------------------------------------------
Purpose: Workflow implemenation for 'qvb'
Notes:   qvb{s<1124:R,x<2353:kfx,ph}
------------------------------------------------------------------------------*/
   IF s < 1124 THEN RETURN "R".
   IF x < 2353 THEN RETURN "kfx".
   RETURN "ph".
END FUNCTION.

FUNCTION fnsg RETURNS CHARACTER (x AS INT, m AS INT, a AS INT, s AS INT):
/*------------------------------------------------------------------------------
Purpose: Workflow implemenation for 'sg'
Notes:   sg{x>2195:R,m>320:gdl,a>2241:A,R}
------------------------------------------------------------------------------*/
   IF x > 2195 THEN RETURN "R".
   IF m > 320 THEN RETURN "gdl".
   IF a > 2241 THEN RETURN "A".
   RETURN "R".
END FUNCTION.

FUNCTION fnnhr RETURNS CHARACTER (x AS INT, m AS INT, a AS INT, s AS INT):
/*------------------------------------------------------------------------------
Purpose: Workflow implemenation for 'nhr'
Notes:   nhr{a>2999:fb,x<176:vcc,zs}
------------------------------------------------------------------------------*/
   IF a > 2999 THEN RETURN "fb".
   IF x < 176 THEN RETURN "vcc".
   RETURN "zs".
END FUNCTION.