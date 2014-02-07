#!/bin/bash
# escola.sh

# variáveis
titulo="Escola.sh 0.1"
fundo="Desenvolvido por NTM Cascavel e Logicus"

# verificando se o usuário é o root
if [ $(id -u) != "0" ];then
	dialog --title "$titulo" \
	--backtitle "$fundo" \
	--infobox "Erro: este programa precisa ser executado com usuario root. \
	Torne-se root usando comando (su -) ou (sudo -i)." 0 0
	exit 1
fi

# o while serve para manter em loop
# um bloco de código enquanto a condição existir
while : ; do

# menu principal do programa
opcao=$(dialog --stdout \
--title "$titulo" \
--backtitle "$fundo" \
--menu "Escolha uma das opções:" 0 0 0 \
busca_ip "Procurar ips na rede" \
limpa_tmp "Limpar o diretório tmp" \
sobre "Informações sobre o escola.sh" \
sair "Sair do programa")

# condicionando as opções do menu principal
case $opcao in

	busca_ip) dialog --title "$titulo" \
	--backtitle "$fundo" \
	--infobox "Aguarde enquanto estamos procurando os ips na rede..." 0 0;
	nmap -sP 192.168.1.1/24 | \
	grep -E '([0-9]{3}.){2}[0-9].[0-9]{2}' | \
	sed 's/.*for /Ip encontrado: /' > /tmp/ip && \
	dialog --title "$titulo | Ips encontrados:" \
	--backtitle "$fundo" \
	--msgbox "`cat /tmp/ip`" 0 0;;

	limpa_tmp) rm -fr /tmp;
	dialog --title "$titulo" \
	--backtitle "$fundo" \
	--msgbox "Diretório /tmp limpo!" 0 0;;

	sobre) dialog --title "$titulo" \
	--backtitle "$fundo" \
	--msgbox "O programa escola.sh foi desenvolvido pelo Núcleo de Tecnologia Educacional da Prefeitura Municipal \
	de Cascavel e pela Logicus Tecnologia de Informação. Maiores informações nos e-mails suporte@logicus.com.br e \
	ntm@cascavel.pr.gov.br. Obrigado por usar o escola.sh!" 0 0;;

	sair) dialog --title "$titulo" \
	--backtitle "$fundo" \
	--infobox "O programa foi encerrado!" 0 0;
	exit 0;;

# fim do case
esac

# fim do while
done

# fim do programa

# escreveram este programa:
# angela ferreira
# ana caroline s sousa
