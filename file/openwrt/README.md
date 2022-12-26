src-git NueXini_Packages https://github.com/NueXini/NueXini_Packages.git </br>
src-git openclash https://github.com/vernesong/OpenClash.git;dev</br>
src-git-full opentopd  https://github.com/sirpdboy/sirpdboy-package</br>
src-git store https://github.com/linkease/istore.git;main </br>
src-git haibo https://github.com/haiibo/openwrt-packages</br>

#添加主页的CPU温度显示</br>
sed -i '/CPU usage/a\<tr><td width="33%"><%:CPU Temperature%></td><td><%=luci.sys.exec("cut -c1-2 /sys/class/thermal/thermal_zone0/temp")%>℃' feeds/luci/modules/luci-mod-admin-full/luasrc/view/admin_status/index.htm
