#!/bin/bash
#===============================================================================
#
#          FILE:  checa-hardening.sh
# 
#         USAGE:  ./checa-hardening.sh 
# 
#   DESCRIPTION:  Script para verificar Hardening y desviaciones
# 
#       OPTIONS:  ---
#  REQUIREMENTS:  ---
#          BUGS:  ---
#         NOTES:  ---
#        AUTHOR:  Miguel Barajas (mabarajas@novell.com), 
#       COMPANY:  Novell de Mexico
#       VERSION:  1.0
#       CREATED:  01/07/2010 12:59:42 PM CST
#      REVISION:  ---
#===============================================================================


echo -n "Hostname: "
echo `uname -n`
date


echo ""
echo "-----------------------------------------------------------"
echo "Desintalacion de programas:"
echo "-----------------------------------------------------------"
for I in cpp gcc rsh; do
	echo "-----------------------------------------------------------"
	echo "rpm -qa | grep $I-"

	rpm -qa | grep ^$I-
done

echo ""
echo "-----------------------------------------------------------"
echo "Servicios:"
echo "-----------------------------------------------------------"

echo "chkconfig"
chkconfig

echo ""
echo "-----------------------------------------------------------"
echo "Puertos abiertos:"
echo "-----------------------------------------------------------"

echo "netstat -nap | grep -w LISTEN"
netstat -nap | grep -w LISTEN

echo ""
echo "-----------------------------------------------------------"
echo "Desviaciones:"
echo "-----------------------------------------------------------"
echo ""
echo "Archivos sin Dueño:"
echo "-----------------------------------------------------------"
echo 'find / -type f -nouser -exec ls -l {} \;'
find / -type f -nouser -exec ls -l {} \; 2> /dev/null
echo ""
echo "-----------------------------------------------------------"
echo "Directorios sin Dueño:"
echo "-----------------------------------------------------------"
echo 'find / -type d -nouser -exec ls -l {} \;'
find / -type d -nouser -exec ls -ld {} \; 2> /dev/null 
echo ""


echo "-----------------------------------------------------------"
echo "Archivos con permisos de escritura para otros:"
echo "-----------------------------------------------------------"
echo 'find / -type f -perm -o=w -exec ls -l {} \;'
find / -type f -perm -o=w -exec ls -l {} \; 2> /dev/null | grep -v "/proc/" | grep -v "rwt"
echo ""

echo "-----------------------------------------------------------"
echo "Directorio con permisos de escritura para otros:"
echo "-----------------------------------------------------------"
echo 'find / -type d -perm -o=w -exec ls -l {} \;'
find / -type d -perm -o=w -exec ls -ld {} \; 2> /dev/null | grep -v "/proc/" | grep -v "rwt"
echo ""


echo "-----------------------------------------------------------"
echo "Defaults de duracion de contraseñas:"
echo "-----------------------------------------------------------"
echo "grep PASS /etc/login.defs"
grep PASS /etc/login.defs
echo ""

echo "-----------------------------------------------------------"
echo "Default de encriptacion:"
echo "-----------------------------------------------------------"
echo "grep  FILE /etc/default/passwd"
grep  FILE /etc/default/passwd
echo ""

echo "-----------------------------------------------------------"
echo "Default de permisos de sistema:"
echo "-----------------------------------------------------------"
echo "grep PERMISSION /etc/sysconfig/security"
grep PERMISSION /etc/sysconfig/security
echo ""


echo "-----------------------------------------------------------"
echo "Version de protocolo para SSH:"
echo "-----------------------------------------------------------"
echo "grep Protocol /etc/ssh/sshd_config"
grep Protocol /etc/ssh/sshd_config
echo ""

echo "-----------------------------------------------------------"
echo "Permitir acceso de Root por SSH"
echo "-----------------------------------------------------------"
echo "grep PermitRootLogin /etc/ssh/sshd_config"
grep PermitRootLogin /etc/ssh/sshd_config
echo ""

echo ""
echo "-----------------------------------------------------------"
echo "Ignorar Ctrl-Alt-Del:"
echo "-----------------------------------------------------------"

echo "grep ctrlaltdel /etc/inittab"
grep ctrlaltdel /etc/inittab

echo ""
echo "-----------------------------------------------------------"
echo "Configuracion de Sudoers"
echo "-----------------------------------------------------------"

echo "cat /etc/sudoers"
cat /etc/sudoers



