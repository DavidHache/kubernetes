#!/usr/bin/env bash
#Script to start devcon site


echo "Adding hostname to HTML File"
sed -i "s/WEBSERVER/$(hostname)/g" /usr/share/nginx/html/index.html


echo 'y--------------------------------------------------------:----::::--:-:----------------------------y'
echo 'o                                Geeves is starting Devcon demo site!                              o'
echo 'o                                                                                                  o'
echo 'o                                                         .+ssyysss+-                              o'
echo 'o                                                       /yo:.`````.-oy+                            o'
echo 'o                 .#####                              `ho.```````````.oy`                          o'
echo 'o              *###########*                          yh.````.os:````:+hs                          o'
echo 'o           ######.     ,######                      `dho.``.+-``````..om                          o'
echo 'o         ####(             (####                     ddho```````````O`.d`                         o'
echo 'o         ###                 ###                   `o+-:.``````````````./ss-                      o'
echo 'o         ###                 ###                   -h`//```````````-::::--+h`                     o'
echo 'o         ###                 ###                   -d.-.``````+-````.--/d/:.                      o'
echo 'o         ###                 ###                    oy/:.````./++/---```s.                        o'
echo 'o         ####(             (####                     -d+.```````.:/+/```/s                        o'
echo 'o           ######.     ,######                       .d.````````````.```.d                        o'
echo 'o              *###########*                          .d.```````````-:```.d`                       o'
echo 'o                  #####                               oo/.`````````````.y/                        o'
echo 'o                                                    .sd`-+/.`-//::--::/o:                         o'
echo 'o                                                `.:smNN-  .//-.-/+hdd/.                           o'
echo 'o                                          ``.:+sdmNNNNNd.   `://++::Nd/.                          o'
echo 'o                                   `.-//oshdmNNNNNNNNNNNd.    `ydy. dNNmy+-.`                     o'
echo 'o                                  -hmNNNNNNNNNNNNNNNNNNNNd.  -yhsym+oNNNNNNmhy+/-.                o'
echo 'o                                 `mNNNNNNNNNNNNNNNNNNNNNNNd-//:hssm:sNNNNNNNNNNNNmo               o'
echo 'o                                `yMNNNNNNNNNNNNNNNNNNNNNNNNm:  /dhy`-NNNNNNNNNNNNNN-              o'
echo 'o                                sMNNNNNNNNNNNNNNNNNNNNNNNNNN+  +hsyy`dNNNNNNNNNNNNNd.             o'
echo 'o                               /MNNNNNNNNNNNNNNNNNNm/yNNNdssms`msssd/sNNNNNNNNNNNNNNy`            o'
echo 'o                              .mNNNNNNNNNNNNNNNNNNNN/`+d/.``+mydsssyhhmo++++ossdNNNNNs`           o'
echo 'o                              yNNNNNNNNNNNNNNNNNNNNNh-s.``:.``-mysssmNd+/:-..``.yNNNNNo           o'
echo 'o                             /NNNNNNNNNNNNNNNNNNNNNNdo.```:h```shyssmN/+/:-.```+:mNNNNNo          o'
echo 'o                            `mNNNNNNNNNNNNNNNNNNNNNNh.`````s.```-mssmNd////-```/.sMNNNNNo         o'
echo 'o                            sNNNNNNNNNNNNNNNNNNNNNNm-``````.-```+msyNm:.`````````/mhNNNNNo        o'
echo 'o                           :NNNNNNNNNNNNNNNNNNNNMd::s.``````````:NhmNm-`/sy:`````-d.oNNNNMo       o'
echo 'o                           hNNNNNNNNNNNNNNNMNNNNN/  /o.`````.:odNNNNNNd.oNNNo.```:m- :mNNNN+      o'
echo 'o                          :NNNNNNNNNNNNNNNMNNNNNN+   /y/+oydNNNNNNNNNNNNNNNNNmysydo`  dNNNNN/     o'


nginx -g "daemon off;"
